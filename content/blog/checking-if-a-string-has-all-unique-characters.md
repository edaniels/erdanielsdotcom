+++
date = "2012-10-24 19:56:41+00:00"
title = "Checking if a string has all unique characters"
type = "post"
+++

That awkward moment when you realized you forgot so much of the python you learned.

I would like this to be the start of a series where I solve commonly asked programming questions in C++ and then in Python. It is extremely useful to be able to solve the same problem in two different types of languages. For me, it helps me build a better understanding of both languages and shows where one language might be favorable over another.

Let's get started.
<!--more-->
First let us assume that string is to be represented in ASCII. Therefore there are 256 choices that a character can be in the string.

If we were to count the occurrences of every character, we would be able to decide whether the string is unique.

Now the solution comes pretty simply:


## C++


```cpp
bool isUnique(string input) {
     int occurrences[256] = {0};
     for (int i = 0; i < input.length(); ++i)
          if ( ++occurrences[input[i]] > 1 )
               return false;
     return true;
}
```


## Python 3


```python

def isUnique(input):

     occurrences = [0 for i in range(256)]

     for character in input:
          occurrences[ord(character)] += 1
          if occurrences[ord(character)] > 1:
               return False
     return True

if __name__ == '__main__':
     choice = input("Enter in a string to see if it has all unique characters: ")
     if isUnique(choice):
          print('True')
     else:
          print('False')

```


I prefer the C++ solution here because we don't need to use any function to get the ASCII value of a character like we do in python with ord(). We also have the benefit here of the prefix increment operator in C++ which lets us shorten the code.
