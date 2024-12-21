# Problem Solving

## Brush-up Checklist

Before diving into Advanced Data Structures and Algorithms, consider refreshing on the following topics:

## String

- Non-alphanumeric characters include any character that is not a **letter** or **number**.
- Empty string `""` is not a character, where as `" "` (space) is a character
- Using `String(repeating:count:)` to create a sequence with a default string.
- **Substring**: A **contiguous** sequence of characters within a string.
- Using sorting techniques to handle anagrams.

## Collection
- When working with collection, index validation must be handled carefully. 
- Understanding how **stride** functions work in loops.
- Use **Stride** for traversing from **left to right** and **right to left** 
- To sort an array effectively, it should have at least two elements.
- Use **counters** when working with offset problems
- **Contiguous**: Elements that are next to each other **without gaps**.
- **Consecutive**: Elements following one another in a sequence. usually increasing (or sometimes decreasing) by 1 or a fixed interval.
```
1, 2, 3 are consecutive, but in the array [3, 1, 2],
they are consecutive but not contiguous.
```
- Methods to find subarrays within an array.
```swift
for i in 0..<array.count {
    for j in i..<array.count {
        let subArray = array[i...j]
    }
}
```
- Accessing elements in a 2D array with `array[row * columns + column]`.

## Stack
- **Stack** - Last In, First Out (LIFO) data structure.
- Use stack to solve adjacent problems 

## Queue
- **Queue** - First In, First Out (FIFO) data structure.

## Prefix Sum 
```swift
var array = [1,2,3,4,5] 
/// The prefix sum of the above array can be build like this. 
prefixSum = [1,3,6,10,15]
prefixSum[i] = a[1]+a[2]+...a[i]
/// Eg: Sum from index 2 to 4 is 
prefixSum[2..4] = prefixSum[4] - prefixSum[1] 
prefixSum[2..4] = 15 - 3 = 12 (3+4+5 = 12) 
```

- To calculate **MinLength or MaxLength** of subarray/substring
- Problem where we findout the difference 
- func frequencySort(_ s: String) -> String 

## Sliding Window
 
```swift
// A Sample template for approaching sliding window 
var left, right = 0
var runningSum = 0 

while right < array.count { 
    runningSum += array[right]

    while running >= target { 
        /// length calculation goes here
        /// shrinking the window.  
        runningSum -= array[left] 
        left -= 1
    }
    /// This is the place where we have valid subarrays 
    /// which matches the target
    right += 1
}
```
- Use to find out substring/subarray sums, products inside an array
- To calculate **MinLength or MaxLength** of subarray/substring 
