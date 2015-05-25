+++
date = "2011-07-07 20:07:02+00:00"
title = "Problem 20 (a.k.a. Who knew how simple python could be?)"
type = "post"
+++

<blockquote>
n! means n x (n - 1)  ...  3 x 2 x 1

For example, 10! = 10 x 9  ...  3 x 2 x 1 = 3628800,
and the sum of the digits in the number 10! is 3 + 6 + 2 + 8 + 8 + 0 + 0 = 27.

Find the sum of the digits in the number 100!
</blockquote>

<!--more-->

This literally took a minute to write-up in python:

```python
import math

def problem_20(target):

	factorial_num = str(math.factorial(target))

	sum = 0

	for number in factorial_num:
		sum += int(number)
	
	return sum
	
print(problem_20(100))
```
