+++
date = "2015-05-31T15:53:52-04:00"
draft = true
title = "Debugging/Fixing a Third-Party Go Package Bug"
type = "post"

+++

MongoDB's product, MMS, uses Go for all of the agents that run on MMS (Monitoring, Backup, Automation) as well as for some small utilities. All of these binaries use the [gowin32](https://github.com/winlabs/gowin32) package in some form or another. I have recently begun working on a feature in the Automation agent that requires gowin32 and I noticed when writing code like the following that my binary would crash:

<!--more-->

```go
package main

import (
	_ "github.com/winlabs/gowin32"
)

func main() {
	_ = 0
}
```

The fatal error that occurred was:

```runtime: garbage collector found invalid heap pointer *(0x68e60+0x0)=0x1 s=nil
fatal error: invalid heap pointer```

On the other hand, adding a print statement suppressed the crashing behavior:

```go
package main

import (
	_ "github.com/winlabs/gowin32"
)

func main() {
	_ = 0
	fmt.Println("Stop crashing")
}
```

Adding the ```Println``` was essentially a red herring and threw me off for a bit. This was the first time that I encountered an issue like this in Go and as such I didn't apply much common sense as to what that error message meant.

A key hint as to what's going on here is the fact that I was using Go 1.4. All of the agent code is currently using Go 1.3 and the error never occurred there.

## The Poor Man's Debugger

My first thought was that if I'm importing a package and it crashes without actually using anything from it, then there must be some kind of ```init()``` or side-effect that causes the invalid heap pointer. Of course gowin32 has no ```init()```s but it has global (package-scoped) variables all over the place. The problem was finding out which ```var``` was screwing me over.

The best idea I could think of at the time was to simply start deleting source files until the crash disappeared. It took a while to find it, but *winuser.go* was the culprit. Thankfully it was a small file and the global variables were causing the crash.

## Realizing the Bug

According to the Go 1.4 [release notes](https://golang.org/doc/go1.4), as of Go 1.3, the runtime is supposed to crash when it finds a memory word that should hold a valid pointer within the Go runtime. This means that a value like 7 in a ```*uint16``` should crash the runtime. Looking at ```MAKEINTRESOURCE``` in *winuser.go*, it was taking a ```uint16``` and literally converting it into a ```*uint16```. The Windows predefined RT_* resources range from 1-24 which clearly would count as invalid pointers. But why did this work in Go 1.3 if the runtime should crash during garbage collection? It turns out the garbage collector in Go 1.3 ignored invalid pointers that are located on the heap (see [https://github.com/golang/go/issues/9454#issuecomment-68169315](https://github.com/golang/go/issues/9454#issuecomment-68169315)).

## Reproducing the Bug

After realizing what was going on, I just wanted to prove I was right. Coming up with the following reproduction was simple and nice to explain:

```go
package main

import (
    "runtime"
    "unsafe"
)

func MAKEINTRESOURCE(integer uint16) *uint8 {
    return (*uint8)(unsafe.Pointer(uintptr(integer)))
}

var (
    test1 = MAKEINTRESOURCE(1)
)

func main() {
    runtime.GC()
}
```

Forcing the garbage collector to run would always crash the runtime with an invalid heap pointer in this example.

## Fixing the Bug

This fix was nice and short. I swapped out the ```*uint16``` for a uintptr which is designed to hold the memory address value as an integral value. Being an integral type and not a pointer, it doesn't get treated as a pointer in the runtime. This enables us to pass around the Windows ```Resource``` references all over the code and all the way down to the syscalls. Thankfully this fix was also backwards compatible with existing code due to type aliasing of the original ```*uint16``` from ```MAKEINTRESOURCE```.

For the actual pull request, see [https://github.com/winlabs/gowin32/pull/38](https://github.com/winlabs/gowin32/pull/38).

## Retrospective

It turns out that this bug was keeping us from upgrading to Go 1.4 on the binaries that were using gowin32. I wasn't aware of this since I stumbled on the bug in my free time. Another engineer came to the same conclusion as to what was wrong but arrived at the answer in a different way. In retrospect, I would have solved this faster had I actually looked for the JIRA ticket; but it was a nice exercise in debugging and I learned a lot more about Go internals.
