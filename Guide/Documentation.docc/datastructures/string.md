# String

## Ideas  

### longest palindrome substring    
To find the longest palindrome substring, iterate through the string and for each character, expand outward to the left and right 
to check if it forms a palindrome. Continue expanding until the characters on both sides are not equal. 
Keep track of the longest palindrome found during the iteration.
```swift
    let currentLength = right - left - 1
```

### Reverse Vowels 
Iterate left and right indices, but increment/decrement the indices only if its not vowels  

### First Unique Character 
Unique Character means, the char should not be repeated in the given string, or array. 
map all the char in an array with the count, as well index. filtering the first minimum index would give 
the first unique character index. 

### Anagrams 
anagrams means, by altering a given string, can form an another string. for this, the given string and 
the comparing string length should be equal, as well the frequence of the two strings char as well should be equal.  

### Permutation
Permutation may defined as the number of ways the given string can be rearrianged. by iterating string from 
start to endIndex, rearringe can be down between those indices in recurssive manner could give the permutations

### Compress string
Two pointer mechanism can be used to perfrom the opration. read and write index can provide the source of truth to 
where the element has to be read and where the element has to be written as we are not removing any elements from the array over iteration

### Rotate String 
Think of a circular string where the first and last characters are connected, forming a circular structure.
By shifting characters from the beginning to the end repeatedly, you can simulate rotation.
For example, consider the string "Bus LED board". When you rotate it, the last character "d" moves to the beginning, 
creating a circular behavior

### Remove All Adjacent Duplicates In String
Using stack, all adjacent duplicates can be removed. Even we can treat string as stack as its alreday confirming to collection 

### Split string by space 

```swift
    let string = "How are you"
    let stringArray = string.split(" ")
    output: ["How", "are", "you"]
```
    - To find number of words in string, first convert string into array using split and use the count

### Convert string to array 

```swift 
    let string = "karthik"
    let array = Array(string)
    output: ["k", "a", "r", "h", "i", "k"]
``` 

### Reverse string  

```swift
    let string = "karthik" 
```
