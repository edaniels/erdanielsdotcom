+++
date = "2011-06-24 03:40:42+00:00"
title = "Problem 4"
type = "post"
+++

<blockquote>A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 ![×](http://projecteuler.net/images/symbol_times.gif) 99.

Find the largest palindrome made from the product of two 3-digit numbers.</blockquote>
<!--more-->

This problem isn't very complicated. Basically we need to have a nested loop that literates through 100-999 (represents all 3 digit numbers) and multiply i by j. Then we check i*j if it is a palindrome (i.e.  12321). We then store this in a variable outside the scope of both loops as the largest palindrome.

The first problem is that if both of the loops start from 100 and go to 999, then we will have at least 'i - 1' duplicates for each completion of the j for loop. This is because there will be a previous occurrence of i*j that will be j*i (i.e. 1*2 (i=1, j=2) 2*1 (i=2, j=1)). To avoid this we just start j at the current 'i' instead.

This reduces the amount of palindromes from $latex (n)^{2}$  to $latex displaystylesumlimits_{i=1}^n i or frac{n}{2}(n+1)$ where n is the amount of numbers to try. In this case it is 900. So we have saved 404550 duplicate palindrome checks (810000 - 404450). This number will approach exactly half of n as n approaches infinity. Therefore this method is much more efficient and scalable.

To check for palindromes we just need to reverse the number in question as a string and check the number in question as a string.

Here is the source code for the solution and reverse function.

```cpp
int P4 ()
{
	char *test = new char[20];

	int largest = 0;

	int tempNum;

	for (int i = 100; i <= 999; i++)

		// Eliminate doubling up on previous multiplications
		for (int j = i; j <= 999; j++) { 
			tempNum = i * j; 			
                        if ( 
                              string(itoa(tempNum,test,10)).compare(reverse(string(itoa(tempNum,test,10)))) == 0 && (tempNum) > largest
                           )

				largest = tempNum;

		}

	delete test;

	return largest;
}

string reverse (string in)
{
	char temp;

	for (int i = 0; i < in.length()/2; i++)
	{
		temp = in[i];

		in[i] = in.at(in.length() - i - 1);

		in[in.length() - i - 1] = temp;
	}

	return in;
}
```

The full source code is avaliable at [https://github.com/edaniels/Euler](https://github.com/edaniels/Euler) or [http://erdaniels.com/sourcecode/Euler/Problem 4/](http://erdaniels.com/sourcecode/Euler/Problem%204/)
