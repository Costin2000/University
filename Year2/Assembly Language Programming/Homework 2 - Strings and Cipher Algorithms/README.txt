Student: Barus Catalin-Stefan
Group: 321CD

**** IOCLA Homework 2 ****

**** STRINGS ****

*** Task 1 - OTP ***

For this task, the main idea was to iterate through the plaitext and key at the same time. Since we know that for this task their length are equal, we could traverse them at the same time and use 8 bit registers such as al and bl to keep track of one letter at the time. All that is left to do is to apply xor between al and bl and move the result to one corresponding byte in edx, which serves as the ciphertext.


*** Task 2 - Caesar Cipher ***

The main problem for this task was how to mathematically get to a new ciphered value, if all I knew was the value of the key. Based on the ASCII table, I noticed that if I substract 97 for lower letters (since 97 in ASCII represents "a"), and 65 for upper letters (since 65 in ASCII represents "A") I get a value that, when added to the key value and either 97 or 65, I obtain a new ciphered letter. This was the basis for my implementation, but another problem soon followed, what if my letter was "Z"? If it will get incremented with the key value I will get a random ASCII character instead. To remedy this, the sum of the key and decomposed letter (letter - 65 or letter - 97). was to be divided by 26 (since there are 26 letters in the English alphabet). The remainder of this division, plus 97 or 65 depending on the case is the new ciphered letter that we want.

In assembly, all I had to do was iterate through the plaintext and check each letter, one at a time. The process was easy since the same key was applied to each letter. Using the al register to retain one letter, I analyzed it for all the cases I described above, and if it were to be a random ASCII character from the beggining, it would just be added to the ciphered text as it is.


*** Task 3 - Vigenere Cipher ***

