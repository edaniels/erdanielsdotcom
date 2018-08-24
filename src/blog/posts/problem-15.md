date=2011-07-03 04:05:27+00:00
title=Problem 15
template=templates/blog_post.html

<blockquote>
$2^{15} = 32768$ and the sum of its digits is $3 + 2 + 7 + 6 + 8 = 26$.

What is the sum of the digits of the number $2^{1000}$?</blockquote>

<!--more-->

I had to write minimal code after adding a sumDigits method to my BigInt class. Since my class does not have a multiplication function yet I just did slow addition multiplication inline.

```cpp
BigInt P15 (int target)
{
	BigInt two = 2;
	int n = 2;

	while (n <= target)
	{
		two += two;
		n++;
	}

	return two.sumDigits();
}
```

```cpp
BigInt BigInt::sumDigits()
{
	BigInt sum = 0;

	for (int i = 0; i < this->length; i++)
		sum += (this->number[i] - '0');

	return sum;
}
```
