+++
date = "2014-02-23 03:22:32+00:00"
title = "Re: Apples SSL/TLS bug"
type = "post"
+++

So it looks like a user on  Hacker News found a bug in Apple's SSL Key Exchange code. It was a classic bug caused by what seems like a copy and paste error. I'm writing this note here for myself and others that may stumble across this article: Use -Weverything (clang) if you are compiling critical code and don't want to miss anything. -wall is a legacy option that covers more popular warnings but not nearly everything. For gcc users there is -Wall -Wextra . There isn't a CVE as of yet.
