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

## Modified Binary Search 
```swift
/// Next greater element
while left <= right 
    array[mid] <= target   
        left = mid + 1; right = mid - 1

/// Find min element 
while left < right 
    array[mid] > array[right]  
        left = mid + 1, right = mid

/// Find max element
while left < right 
    array[mid] > array[right]  
        left = mid, right = mid - 1

/// find peak element
while left < right 
    array[mid] < array[mid+1]
        left = mid + 1, right = mid

/// Search in cicular sorted array (including duplicates)
while left <= right 
    array[left] <= array[mid]
        array[left] <= target && target <= array[mid]

/// Find Occurance 
while left <= right 
    mid > 0, array[mid] == target && array[mid-1] != target 
        array[mid] >= target; right = mid - 1 

/// Find Last occurance
while left <= right
    mid < array.count && array[mid] == target && array[mid+1] != target 
        array[mid] <= target; left = mid + 1 
```

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

## Kth Element 
```swift
/// Grab prefix upto the k as heap. 
/// Use min heap (asc sort)
/// Traverse from the kth element as we grapped upto prefix 
/// Override the heap[0] whenever seeing larger values 
func kthLargest(_ array: [Int], _ k: Int) -> Int? { }
```

```swift
/// Grab prefix upto the k as heap. 
/// Use max heap (desc sort)
/// Traverse from the kth element as we grapped upto prefix 
/// Override the heap[0] whenever seeing smaller values then heap head. 
func kthSmallest(_ array: [Int], _ k: Int) -> Int? { }
```

```swift
/// Calculate the frequency 
/// Use min heap (asc sort) - (kth largest element technique)
/// Grab the values upto the limit (k)
/// Override the heap whenever seeing larger frequency 
func topKFrequent(_ nums: [Int], _ k: Int = 2) -> [Int] { } 
```
## Monotonic Stack 
```swift
/// Clone array to track the next/previous smaller/greater elements
/// Use index stack to track index which didn't yet find the answer
/// Traverse each element, lookup the stack to find the answer. 
/// Update the stack with the current index, so that its result can be found later.
func nextGreaterElements(_ nums: [Int]) -> [Int] { }
func nextSmallerElements(_ nums: [Int]) -> [Int] { }
```

```swift
/// Clone the array to track the result 
/// Use index stack 
/// Traverse each element, lookup the stack and remove the elements till smaller/greater as per our requirement 
/// Update the index stack 
func previousGreaterElements(_ nums: [Int]) -> [Int] { }
func previousSmallerElements(_ nums: [Int]) -> [Int] { }
```

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
```swift
/// Use dp table to track the maximum sum at each cell.
/// Condition: 
/// - if array[i] > previous sum (dp[i-1]+array[i]), that can be considered fresh start 
/// - Otherwise it just enlarging the sum window.
/// Length Calculation: Calculate the max length whenever updating the dp table. 
func findMaxSubArraySum(_ array: [Int]) { }
```
- `func longestIncreasingSubSequence(_ nums: [Int]) -> Int` [LeetCode](https://leetcode.com/problems/longest-increasing-subsequence) | [Youtube](https://www.youtube.com/watch?v=CE2b_-XfVDk)

Dp Table 2D: 
```swift
/// 1. Create 2D dp table with 0's
/// 2. Traverse diagonally && fill vertically
/// 3. Condition:
///     - i == j (single char)
///     - diff == 1 (two char)
///     - arr[i] == [j] => update by 2
///     - arr[i] == [j] => max(dp[i + 1][j], dp[i][j - 1])
/// 4. Length calculation: whenever updating the dp table
func longestPalindromeSubstring(_ s: String) -> String { }
```
```swift
/// 1. Create 2D dp table with 0's
/// 2. Traverse diagonally && fill vertically
/// 3. Condition:
///     - i == j (single char)
///     - diff == 1 (two char)
///     - arr[i] == [j] => update by 2
///     - arr[i] == [j] => max(dp[i + 1][j], dp[i][j - 1])
/// 4. Length calculation
/// 5. Construct palindrome text by traversing with start and end.
///     - use dp table values (bottom || left)
func longestPalindromeSubsequce(_ s: String) -> String { }
```
```swift
/// 1. Create dp table with length+1, filled with 0's'
/// 2. Traverse and fill the table `horizontally` (starting with 1)
/// 3. Condition:
///     - if A[i-1] == B[j-1] => dp[i - 1][j - 1] + 1
///     - if not update by 0
/// 4. Calculate the length (whenever updating the dp table)
func longestCommonSubstring(_ text1: String, _ text2: String) -> Int { }
```
```swift
/// 1. Create dp table with length+1, filled with 0's'
/// 2. Traverse and fill the table `horizontally` (starting with 1)
/// 3. Condition:
///     - if A[i-1] == B[j-1] => dp[i - 1][j - 1] + 1
///     - if not => max(dp[i-1][j], dp[i][j-1]) 
/// 4. Calculate the length
/// 5. Construct common string by traversing both arrays from right to left.
///     - use dp table values (top || left) 
func longestCommonSubsequence(_ text1: String, _ text2: String) -> Int { }
```
```swift 
/// 1. Create dp table with length+1, filled with 0's'
/// 2. Traverse and fill the table `horizontally` (starting with 1)
/// 3. Condition:
///     - clone previous, if knapsack (bag) < current element
///     - if not, max(dp[i - 1][j], profit[i - 1] + dp[i - 1][j - weights[i - 1]])
/// 4. Result (weigth based)
///     - Traverse each weight from last cell, to findout the items that were picked. 
///     - if current != previous then that item is picked
///     - subtract the picked item weigth will give the remaning weigth in the cell. 
func knapSack(weights: [Int], profit: [Int], knapsack: Int) { }
```

```swift
// Convert the collection into Item struct (both profit and wight should be double)
// Sort(desc) the struct by profilt/wight ratio
// Calculate the maxWeight using runningWeight (by adding each item into the bag)
// Use knapsack as the max weight (bag limit)
func fractionalKnapsack(weights: [Double], profilt: [Double], knapsack: Double) -> Double { }
```

```swift
/// Approach 1: select the item with max profit first 
/// Approach 2: select the which has minimum weight(help to select more items)
/// Approach 3: Select the item which has max (profit/weight) ratio 
```
- `func longestConsecutiveSubsequence(_ nums: [Int]) -> [Int]`

## LinkedList 
- Use three pointers to reverse a single linked list
- On another way to reverse single linked list is to use stack. 
    - Traverse the list, append it in the stack, then pop it. which will give the nodes in reverse order
    - Use that to construct new linked list
