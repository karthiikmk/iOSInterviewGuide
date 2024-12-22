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

## Two Pointers 
- Use **fast and slow** pointer approach to detect the cycles  

## Prefix Sum
Prefix sum also known as cumulative sum, where each element represents the **sum of all preceding elements** in the array upto the index.  
> map, runningSum, difference 
```swift
var array = [1,2,3,4,5] 
/// The prefix sum of the above array can be build like this. 
prefixSum = [1,3,6,10,15]
prefixSum[i] = a[1]+a[2]+...a[i]
/// Eg: Sum from index 2 to 4 is 
prefixSum[2..4] = prefixSum[4] - prefixSum[1] 
prefixSum[2..4] = 15 - 3 = 12 (3+4+5 = 12) 
```
The following template can be used to solve most of the prefix sum problems. 
```swift
var map = [Int: Int]() // difference map
map[0] = 1 // for calculating count
map[0] = -1 // for calculating length 
var runningSum = 0
var i = 0 
while i < array.count { 
    runningSum += array[i]
    let diff = runningSum - k // where k is target
    if let j = map[diff] { 
        let length = i-j
        // work with the lenght
    } else {
        map[runningSum] = i 
    }
    i+=1 
}
```

- To calculate **MinLength or MaxLength** of subarray/substring
- Problem where we findout the difference 
- func frequencySort(_ s: String) -> String 

## Sliding Window
To solve most of the sliding window problems, first we need **Target/Size**
> left, right, runningSum (enlarge window), length calculation, shrinking window
 
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

## Dynamic Programming 

```swift
// Diagnal Iteration: a difference to iterate and fill the dp table diagnolly.
for diff in 0..<n {
    for i in 0..<(n-diff) {
        let j = i+diff
        print("(\(i), \(j))")
    }
}
```

Dp Table: 1D
> Clone array with 0, dp table, including previous + current, excluding previous
- `func findMaxConsecutiveOnces(_ nums: [Int]) -> Int`
- `func findMaxSubArraySum(_ array: [Int])`
- `func longestIncreasingSubSequence(_ nums: [Int]) -> Int` [LeetCode](https://leetcode.com/problems/longest-increasing-subsequence) | [Youtube](https://www.youtube.com/watch?v=CE2b_-XfVDk)

Dp Table 2D: 
- `func longestPalindromeSubstring(_ s: String) -> String`
- `func longestPalindromeSubsequce(_ s: String) -> String`
- `func longestCommonSubstring(_ text1: String, _ text2: String) -> Int`
- `func longestCommonSubsequence(_ text1: String, _ text2: String) -> Int`
- `func longestConsecutiveSubsequence(_ nums: [Int]) -> [Int]`

## LinkedList 
- Use three pointers to reverse a single linked list
- On another way to reverse single linked list is to use stack. 
    - Traverse the list, append it in the stack, then pop it. which will give the nodes in reverse order
    - Use that to construct new linked list
