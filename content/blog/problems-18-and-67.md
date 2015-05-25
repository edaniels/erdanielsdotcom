+++
date = "2011-07-04 07:01:24+00:00"
title = "Problems 18 and 67"
type = "post"
+++

Problems 18/67



<blockquote>
By starting at the top of the triangle below and moving to adjacent numbers on the row below, the maximum total from top to bottom is 23.

3
7 4
2 4 6
8 5 9 3

That is, 3 + 7 + 4 + 9 = 23.

Find the maximum total from top to bottom of the triangle below:
</blockquote>

<!--more-->

The only difference between these two problems is the size of the triangle; one spans 15 lines while the other 100. Like it says in a note at the bottom of the problem, it would take too long to brute force every possible path and in my opinion that approach would be too complicated.

The way my algorithm and a lot of other people's algorithms for this problem works is by starting from either the top or bottom of the triangle (in mine, the bottom), you have the computer calculate the max value for the path from a row above the bottom to the bottom. The algorithm always uses two rows and updates the top row as it passes through. There can only be two possible new values per value in the top row. This allows us to collapse the triangle upon each iteration and speed up the process. 

At first I didn't understand the problem and I thought it was just asking what is the sum of the path of the highest adjacent numbers. Obviously that was wrong but it created an interesting point. It is best to start at the bottom because you do not know how numbers below the current row you are on will affect the sum. But if you start from the bottom you already know what the max values for that path can be. Also, if you were to start from the top with the same algorithm, you would have to search for the maximum value in the last row to get your answer as opposed to having the top contain one element.

Some memory is wasted in my array declaration since it is not truly [15][15] but C++ is needy like that and doesn't support jagged arrays as far as I know.

```cpp
void calcMaxTriangleRow (BigInt top[], BigInt bottom[], int bottomSize)
{
	BigInt left, right;
	int topSize = bottomSize - 1;

	if (bottomSize == 1)
	{
		left = bottom[0];
		right = bottom[1];

		(left > right) ? top[0] = left + top[0] : top[0] = right + top[0];
	}

	for (int i = 0; i < topSize; i++)
	{
		left = bottom[i];
		right = bottom[i+1];

		(left > right) ? top[i] = left + top[i] : top[i] = right + top[i];
			
	}
}
```

Problem 18:
```cpp
BigInt P18 ()
{
	BigInt triangle[15][15] = {  {75}, 
							  {95,64},
						      {17,47,82},
						      {18,35,87,10},
						      {20,4,82,47,65,},
						      {19,1,23,75,3,34},
					          {88,2,77,73,7,63,67},
					          {99,65,4,28,6,16,70,92},
					          {41,41,26,56,83,40,80,70,33},
				              {41,48,72,33,47,32,37,16,94,29},
				              {53,71,44,65,25,43,91,52,97,51,14},
						      {70,11,33,28,77,73,17,78,39,68,17,57},
							  {91,71,52,38,17,14,91,43,58,50,27,29,48},
							  {63,66,4,68,89,53,67,30,73,16,69,87,40,31},
							  {4,62,98,27,23,9,70,98,73,93,38,53,60,4,23} };

	int size = 15;

	int i = 1;

	while (size > 1)
	{
		calcMaxTriangleRow(triangle[15-i-1], triangle[15-i], size--);

		i++;
	}

	return triangle[0][0];
}
```

Problem 67:
```cpp
BigInt P67 ()
{
	fstream triangleTxt = fstream("triangle.txt",ios::in);

	BigInt triangle[100][100];

	for (int i = 0; i < 100; i++)
	{
		for (int j = 0; j < (i+1); j++)
			triangleTxt >> triangle[i][j];
	}

	int size = 100;

	int i = 1;

	while (size > 1)
	{
		calcMaxTriangleRow(triangle[100-i-1], triangle[100-i], size--);

		i++;
	}

	return triangle[0][0];
}
```
