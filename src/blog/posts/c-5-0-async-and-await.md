date=2012-10-16 00:05:57+00:00
title=C# 5.0 - Async and Await
template=templates/blog_post.html

[Asynchronous Programming with Async and Await (C# and Visual Basic)](http://msdn.microsoft.com/en-us/library/hh191443.aspx)

I haven't really used C# in a while due to school and mainly just not having a need to use it for anything new as of yet. But one thing I can say is that typical asynchronous programming introduces obscurity and complexity into your code that may confuse someone not yet intimate with the language. After giving this a read through, it look as if you can create a program that almost looks synchronous. Not having to worry about threading is a huge plus. The only thing someone has to do now to program this way is to get their head around the async and await keywords.
<!--more-->
For asnyc methods we just need to specify a Task or Taskand that is essentially all that is needed for asynchronous to kick in. You only want to use Task when your method does not actually return anything; this is useful if we want a non-blocking way of doing work in the background so we can allow our caller to do work and then **await **for the **async **method to finish.  Otherwise we just specify a TResult (string, int, etc.) and this will guarantee that the caller calling our **async** method will receive a TResult in return.

On an unrelated note, I have an interview at Microsoft in the near future for an internship position as an SDET (Software Development Engineer in Test). I'm unbelievably excited to visit Washington for the first time, visit the Microsoft campus, and just see how they interview. Maybe I will even get a chance to visit Valve on my off time!
