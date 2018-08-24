date=2011-07-03 03:18:07+00:00
title=Problem 14
template=templates/blog_post.html

<blockquote>
The following iterative sequence is defined for the set of positive integers:
</blockquote>

<blockquote>
$
n =
\left\{
	\begin{array}{ll}
		\frac{n}{2}  & \mbox{if n is even} \\
		3*n + 1 & \mbox{if n is odd}
	\end{array}
\right.
$
</blockquote>

<blockquote>
Using the rule above and starting with 13, we generate the following sequence:

13  40  20  10  5  16  8  4  2  1
It can be seen that this sequence (starting at 13 and finishing at 1) contains 10 terms. Although it has not been proved yet (Collatz Problem), it is thought that all starting numbers finish at 1.

Which starting number, under one million, produces the longest chain?

NOTE: Once the chain starts the terms are allowed to go above one million.
</blockquote>

<!--more-->

Simple and quick brute force solution

```cpp
long long P14 (long long target)
{
	long long current = target;
	long long chainLength = 0;
	long long count = target;
	long long longestChain[2] = {count, chainLength};

	while (count > 1)
	{
		while (current > 1)
		{
			if (current % 2 == 0)
				current /= 2;
			else
				current = (current*3) + 1;

			chainLength++;
		}

		if (chainLength > longestChain[1])
		{
			longestChain[0] = count;
			longestChain[1] = chainLength;
		}

		count--;
		current = count;
		chainLength = 0;
	}

	return longestChain[0];
}
```
