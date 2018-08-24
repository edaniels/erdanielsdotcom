date=2011-07-01 04:04:44+00:00
title=BigInt
template=templates/blog_post.html

So because of the challenges imposed by Problem 13 on Project Euler, I could either create a BigInt class, use a different language other than C++ (like C#), or just notice how only a certain amount of numbers affect addition. I chose the first choice because I know I need to make a BigInt class next semester for OOP. The hardest part of making this was the addition and carry over. I also had to make a compromise of size where two numbers can add up to maximum of the length of both numbers combined. The class only supports +, ++ (postfix), +=, =, and <. It works pretty well with Fibonacci numbers.

[ BigInt Source ](http://erdaniels.com/sourcecode/BigInt/)

