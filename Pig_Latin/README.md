Taking all the consonants before the first vowel of a word and moving them to the back of the word followed by the letters "ay".

~~~
hello => ellohay
creating => eatingcray
~~~

If the first letter of the word is a vowel, the string is left the same and the letters "way" are appended to the end.

~~~
algorithm => algorithmway
~~~

Watch out, casing of the word should remain the same:

~~~
Hello World => Ellohay Orldway
Hello world => Ellohay orldway
~~~

Same is true for punctuation:

~~~
Pizza? Yes please! => Izzapay? Esyay easeplay!
~~~

Original source: https://www.codewars.com/kata/advanced-pig-latin
