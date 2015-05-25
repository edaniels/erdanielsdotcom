+++
date = "2013-06-16 21:35:22+00:00"
title = "Combining Asynchronous & Multi-Threaded Programmming"
type = "post"
+++

Over the past week I have had to develop a networking architecture that can handle multiple clients and quickly transmit received data to a specified location. The following is a description of some high level approaches of how the architecture could be implemented.
<!--more-->
A naive approach to making a server accomplish this is to use a new process for each client connection. This is very easy to do but does not scale well at all as connections increase. With a large amount of processes you will start to waste time with context switching.

The next approach which is not as bad is to spawn a new thread for each connection. Given the same amount of connections that the process approach received, you will incur less of a hit during context switching due to being able to keep the same virtual memory space. But an increase in threads implies an increase in stack size which is limited to a certain size depending on your system. Another cautionary note for Linux users is that if you run out of VM space, this will cause Linux to start killing random processes which could in turn kill your one process that spawned many threads.

For threads and processes alike, spawning them requires significant computational time.

I see this next approach as an ideal solution but I am definitely open to criticism. For every connection we received we can place it in a [poll](http://linux.die.net/man/3/poll) object instance. We can now poll inside a single thread and when any connection is up for being acted on, we can place a request in a service queue. This service queue would be serviced by a set amount of workers in a thread pool. The act of placing a request for service is our asynchronous action and the multi-threaded aspect is acting on these requests with multiple threads. An advantage here is that we create our threads ahead of time and keep reusing them. Also, if we set the size of the thread pool relative to the amount of cores on the computer, we MAY be able to get the most use out of our program. This is more of a parameter that varies based on the use case and system.

I suppose you could have a single threaded event loop that still checks for connections that need to be serviced but it puts those requests on the same event loop and processes them as it sees fit. This doesn't seem very scalable but nginx and node.js have had a lot of success (as have I when using node.js).
