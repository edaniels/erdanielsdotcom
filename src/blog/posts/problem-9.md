date=2011-06-27 01:23:42+00:00
title=Problem 9
template=templates/blog_post.html

<blockquote>A Pythagorean triplet is a set of three natural numbers, $a < b < c$, for which,
<!--more-->
$a^2 + b^2 = c^2$
For example, $32 + 42 = 9 + 16 = 25 = 52$.

There exists exactly one Pythagorean triplet for which $a + b + c = 1000$.
Find the product $abc$.</blockquote>


I am sure this could be much more optimized but $k$ always stays ahead of $i$ and $j$ and can only go up to the point where $k <= target - i - j$. Returns -1 in case of failure.

```cpp
long long P9 (long long target)
{
	long long product = -1;

	for (int i = 3; i < target - i; i++)
		for (int j = 4; j < target - i - j; j++)
			for (int k = 5; k <= target - i - j; k++)
				if (i*i + j*j == k*k && i+j+k == target)
					return i*j*k;

	return product;
}
```
