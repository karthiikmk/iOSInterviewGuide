//
//  Leetcode+Array.swift
//  Algorithms
//
//  Created by Karthik on 22/03/24.
//

import Foundation

/*
 - Find the largest/smallest element in an array.
 22. Find the longest common subsequence of two strings.
 23. Find the longest increasing subsequence of an array.
 30. Find the median of two sorted arrays.
*/

extension LeetCode {
    
    /// Use `max(by: {})` to find the max or min element from the dictionary.
    /// Use `reduce` to convert array into dictionary
    /// Use `stride(from: through, by: -1` to iterate the array in reverse **
    func runArray() {
        // reverse([1,2,3,4,5])
        // sortedSquares([-2, -1, 0, 1, 2, 3])
        // maxSumOfSubarray()
        // minSumOfSubArray()
        // maxSumOfSubarray(arr: [5,4,3,1,8], size: 3)
        // findSecondLargest([1,2,4,3])
        // findSecondSmallest([16,17,15])
        // findCharCount(in: "a2b3")
        // subarraySum([1,2,3,5,4], 2)    
        // findCharCountUsingRegex()
        // runningSum()
        // largestAltitude()
        // maxSubArrayLength()
        // countOfSubArray()
        // maxLengthOfBinarySubarray()
        // topKFrequent()
        // nextGreaterElements()
    }
}

extension LeetCode {
    
    /// NOTE: Recommended way
    func reverse<T>(_ array: inout [T], _ startIndex: Int, _ endIndex: Int) {
        var start: Int = startIndex
        var end: Int = endIndex
        while start < end {
            array.swapAt(start, end)
            start += 1
            end -= 1
        }
    }
    
    /// Eg: [1, 2, 3, 4, 5, 6, 7, 8, 9], offset: 3
    /// Output: [3, 2, 1, 6, 5, 4, 9, 8, 7]
    func reverse(array: inout [Int], by offset: Int) {
        
        var startIndex = 0
        let endIndex = array.count-1
        
        // Idea: 1
        while startIndex < array.count { // iterate upto the last number
            let start = startIndex
            let end = min((startIndex+offset-1), endIndex) // to avoid index outofbounds
            reverse(&array, start, end)
            startIndex += offset
        }
        
        /// Idea 2:
        for index in stride(from: 0, through: array.count-1, by: offset) {
            let endIndex = min(array.count-1, index+offset)
            reverse(&array, index, endIndex)
        }
        
        print("Reversed array by offset: \(offset) - \(array)")
    }
    
    // let d (index) = 3
    // let arr = [1, 2, 3, 4, 5]
    func rotateLeft(arr: [Int], d: Int) -> [Int] {
        var array: [Int] = arr
        reverse(&array, 0, d-1)
        reverse(&array, d, arr.count-1)
        reverse(&array, 0, arr.count-1)
        return array
    }
    
    /// Input: [9, 9]
    /// Output: [1, 0, 0]
    /// Explanation: The array represents the integer 99. Adding one results in 100, so the output is [1, 0, 0].
    func plusOne(_ digits: [Int]) -> [Int] {
        let result = digits.reduce(0) { $0 * 10 + $1 }
        let incrementedResult = result + 1
        let array = incrementedResult.toArray()
        debugPrint("plush one \(array)")
        return array
    }

    /// NOTE:
    /// Input: b3c6d15
    /// Output: bbbccccccddddddddddddddd
    /// If not we should make use of regex pattern matching.
    func findCharCount(in string: String) {
        var charFrequency = [String: Int]()
        let array = Array(string)
        
        var index = 0
        var currentLetter = ""
        var currentNumber = ""
                
        while index < array.count {
            let element = array[index]
            if element.isLetter {
                if !currentLetter.isEmpty && !currentNumber.isEmpty {
                    charFrequency[currentLetter] = Int(currentNumber)
                    currentLetter = String(element)
                    currentNumber = ""
                } else if currentNumber.isEmpty {
                    currentLetter += String(element) // Expanding window
                } else {
                    currentLetter = String(element)
                    currentNumber = ""
                }
            } else if element.isNumber {
                currentNumber += String(element)
            }
            index += 1
        }
        
        /// last pair, as we are updating the dictinoary only on the isLetter case.
        if !currentLetter.isEmpty && !currentNumber.isEmpty {
            charFrequency[currentLetter] = Int(currentNumber)
        }
        
        var resultString = ""
        for (char, count) in charFrequency {
            resultString +=  String(repeating: char, count: count)
        }
        
        print("result: \(resultString)")
    }
    
    func findCharCountUsingRegex(in string: String = "b31c6d15e120", regex: String = "([a-zA-Z])(\\d+)") {
        let matches = RegexBuilder(regex: regex)
            .getMatches(input: string)
        
        var result = [String: Int]()
        for match in matches {
            if let charGroup = match.getRange(at: 1, in: string),
               let countGroup = match.getRange(at: 2, in: string) {
                
                let character = charGroup.substring(from: string)
                let count = Int(countGroup.substring(from: string)) ?? 0
                print("\(character) (\(count))")
                result[character, default: 0] += count
            }
        }
    }
}

// - MARK: Search
extension LeetCode {
    
    /// - NOTE: Array is sorted, so use binary search
    func search(_ nums: [Int], _ target: Int) -> Int {
        var startIndex: Int = 0
        var endIndex: Int = nums.count - 1
        
        /// Need to check the endIndex value as well.
        while startIndex <= endIndex { // **
            let middleIndex = startIndex + (endIndex - startIndex) / 2
            let middleValue = nums[middleIndex]
            
            if target == middleValue {
                return middleIndex // result index
            } else if target > middleValue {
                startIndex = middleIndex + 1
            } else {
                endIndex = middleIndex - 1
            }
        }
        return -1
    }
    
    /// Two Sum II - Input Array Is `Sorted`
    /// OJ: https://leetcode.com/problems/two-sum-ii-input-array-is-sorted/description/
    ///
    /// - seealso: Binary search, two sum
    /// [2,7,11,15] Target: 9
    /// Idea: Using Two pointer (but only applicable for sorted)
    func twoSum(_ numbers: [Int], _ target: Int) -> [Int] {
        guard !numbers.isEmpty else { return [] }
        var startIndex: Int = 0
        var endIndex: Int = numbers.count - 1
        
        while startIndex <= endIndex {
            let sum = numbers[startIndex] + numbers[endIndex] // *** important (Not with `middleIndex`)
            if sum == target {
                return [startIndex + 1, endIndex + 1] // 1 Indexed array.
            } else if target > sum {
                startIndex += 1 // Not with middleIndex
            } else {
                endIndex -= 1 // Not with middleIndex
            }
        }
        return []
    }
}

// - MARK: Sort
extension LeetCode {
    
    /// - NOTE: Merge two sorted list into a single sorted list
    /// Naive approch, TimeComplexity O(m*n)
    func mergeTwoSortedArray(_ first: [Int], _ second: [Int]) -> [Int] {
        var result = [Int]()
        var i: Int = 0
        var j: Int = 0
        
        /// if any one array reaches the end, we should stop copiying.
        while i < first.count && j < second.count {
            if first[i] < second[j] {
                result.append(first[i])
                i += 1
            } else {
                result.append(second[j])
                j += 1
            }
        }
        // Copy the remaining elements
        while i < first.count {
            result.append(first[i])
            i += 1
        }
        while j < second.count {
            result.append(second[j])
            j += 1
        }
        return result
    }
    
    /// NOTE:
    /// Time complexity is O(m+n)
    func mergeTwoSortedArray1(_ first: [Int], _ second: [Int]) -> [Int] {
        
        var result = Array(repeating: 0, count: first.count + second.count)
        var i = 0
        var j = 0
        var k = 0 // Auxilary
        
        while k < result.count {
            if i < first.count && j < second.count {
                if first[i] < second[j] {
                    result[k] = first[i]
                    i += 1
                } else {
                    result[k] = second[j]
                    j += 1
                }
            } else if i < first.count {
                result[k] = first[i]
                i += 1
            } else if j < second.count {
                result[k] = second[j]
                j += 1
            }
            k += 1
        }
        
        return result
    }
    
    /// - NOTE: same thing we can do for the above as well.
    func mergeUnsortedArray(_ first: [Int], _ second: [Int]) -> [Int] {
        let array = first + second
        let sorted = bubbleSort(array) // use whichever the sorting you like
        return sorted
    }
    
    /// NOTE: This will work only for `sorted array`.
    /// The given array must be sorted like [-2, -1, 0, 1, 2, 3]
    /// So that we can travers with via start and end
    /// return the result in ASCEDNING order.
    func sortedSquares(_ array: [Int]) -> [Int] {
        /// if we use append, then larger will goes to the first position, which we dont want)
        var result = [Int](repeating: 0, count: array.count) // ***
        var startIndex = 0
        var endIndex = array.count - 1
        var k = endIndex // By Keeping k as end of the array.
        
        while startIndex <= endIndex {
            if abs(array[startIndex]) > abs(array[endIndex]) {
                result[k] = array[startIndex] * array[startIndex]
                startIndex += 1
            } else {
                result[k] = array[endIndex] * array[endIndex]
                endIndex -= 1
            }
            k -= 1
        }
        print("sorted square: \(result)")
        return result
    }
    
    /// Sort Array By Parity
    ///
    /// Given an integer array nums, `move all the even integers at the beginning` of the array followed by all the odd integers.
    /// Return any array that satisfies this condition.
    ///
    /// Input: nums = [3,1,2,4]
    /// Output: [2,4,3,1]
    /// Explanation: The outputs [4,2,3,1], [2,4,1,3], and [4,2,1,3] would also be accepted.
    ///
    /// Idea: Iterate from left to rigth
    /// Move all the odd to the end (reduce endIndex on each)
    func sortArrayByParity(_ array: inout [Int]) -> [Int] {
        guard array.count > 1 else { return array }
        
        var startIndex: Int = 0
        var endIndex: Int = array.count - 1
        
        /// We need to look for the last number as well.
        while startIndex <= endIndex {
            if array[startIndex] % 2 == 0 { // Even
                startIndex += 1
            } else {
                array.swapAt(startIndex, endIndex)
                endIndex -= 1
            }
        }
        return array
    }
    
    /// - NOTE: `Array must be sorted`. S
    /// Since its sorted, we can check the first and next elements are equal for the duplicates
    /// IDEA: The idea is to compare the current and next index
    /// If both are same the duplidated, the update the hashtable with count
    func findDuplicatesInSortedArray(in array: [Int]) -> [Int: Int] {
        var duplicates = [Int: Int]()
        var startIndex: Int = 0
        while startIndex < array.count - 1 { // ** we need next element to check, < endIndex.
            let current = array[startIndex]
            let next = array[startIndex+1]
            if current == next {
                duplicates[current, default: 1] += 1 // ** important
            }
            /// next loop
            startIndex += 1
        }
        return duplicates
    }
    
    /// NOTE: Array is `unsorted`
    /// Since array in unsorted, there is no other way than having the visiteds to track the duplicates
    /// Return all the elements which appears more than once.
    func findDuplicates(in array: [Int]) -> [Int: Int] {
        var visiteds = Set<Int>()
        var duplicates = [Int: Int]()
        
        var startIndex = 0
        while startIndex < array.count {
            let element = array[startIndex]
            if !visiteds.contains(element) {
                visiteds.insert(element)
            } else {
                duplicates[element, default: 0] += 1
            }
            startIndex += 1
        }
        
        return duplicates
    }
    
    /// Given an integer array nums of length n where all the integers of nums are in the range [1, n]
    /// and each integer appears once or twice, return an array of all the integers that `appears twice (more than once)`.
    func findDuplicates(_ nums: [Int]) -> [Int] {
        var visited = Set<Int>()
        var duplicates = Set<Int>()
        
        for num in nums {
            if !visited.contains(num) {
                visited.insert(num)
            } else {
                duplicates.insert(num)
            }
        }
        debugPrint("duplicates: \(duplicates)")
        return Array(duplicates)
    }
}

// MARK: - Duplicates
extension LeetCode {

    /// - NOTE: With indices, we could able to find the missing number in the
    /// Natural continious numbers
    ///
    /// Eg: [6, 7, 8, 9, 10, 11, 13, 14]
    /// index 6 is not meeting the difference
    ///
    /// Idea: First index should be taken as differentiator
    /// Returnt the missing element if found.
    func findMissingElement(array: [Int]) -> Int? {
        let difference = array[0]
        var index = 0
        
        while index < array.count {
            if array[index] - index != difference {
                return index + difference
            }
            index += 1
        }
        return nil
    }
    
    /// Given an array containing n distinct numbers in the `range [0, n]`,
    /// find the one number that is missing from the array.
    /// Idea: Use sum of natural numbers
    /// nums array should contains values from `0 to n`
    func missingNumber(_ nums: [Int]) -> Int {
        let expectedSum = nums.toNaturalNumbersSum()
        let actualSum = nums.reduce(0, +)
        return expectedSum-actualSum // will the give missing number.
    }
    
    /// Remove the given element form the array, return the lenth of the array after removing the value.
    /// Eg: [0,1,2,2,3,0,4,2], val = 2
    /// Idea: is to move the element which is equal to the value to the right side pointer (endIndex)
    /// Length can be calculated with the endIndex (endIndex = count-1), if we need count then endIndex+1
    func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
        var startIndex: Int = 0
        var endIndex: Int = nums.count - 1
        
        while startIndex <= endIndex {
            if nums[startIndex] == val {
                nums.swapAt(startIndex, endIndex)
                endIndex -= 1 // This part is tricky.
            } else {
                startIndex += 1
            }
        }
        debugPrint("lenght: \(endIndex + 1)")
        return endIndex + 1 // length
    }

    /// Remove Duplicates from Sorted Array
    ///
    /// OJ: https://leetcode.com/problems/remove-duplicates-from-sorted-array/description/
    ///
    /// Using slow and fast for removing duplicates
    /// Collecting non duplicates items in the front
    /// given array must be sorted
    /// [0,0,1,1,1,2,2,3,3,4]
    ///
    /// Tip: This only applicable for contigious duplicates.
    /// Return the lenght of the non duplicate values
    func removeDuplicates(_ array: inout [Int]) -> Int {
        if array.isEmpty { return 0 } // Handle edge case

        var slow = 0
        var fast = 1 // ** important as its sorted array, we should look for the next

        while fast < array.count {
            if array[slow] != array[fast] {
                slow += 1
                array[slow] = array[fast]
            }
            fast += 1
        }
        // The unique elements are from index 0 to slow (inclusive)
        return slow + 1 // length
    }

    /// NOTE:
    /// Eg: [0,2,1,0,1,3]
    /// Hint: Using visited, we can look for duplication
    /// Blindly start inserting the non duplicated number from the starting poistion
    func removeDuplicatesInUnsortedArray(_ array: inout [Int]) -> Int {
        var visiteds: Set<Int> = []
        var writeIndex = 0 // treat as write index
        var index = 0  // iterator
        
        while index < array.count {
            let element = array[index]
            if !visiteds.contains(element) {
                visiteds.insert(element)
                array[writeIndex] = element // ** important
                writeIndex += 1
            }
            index += 1 // loop
        }
        return writeIndex
    }
}

// MARK: - Two Pointers
extension LeetCode {

    /// - Complexity: O(n)
    /// Input: [1, -2, 3, -4, -5, 6]
    /// Output: [-2, -4, -5, 1, 3, 6]
    /// Explanation: The negative numbers [-2, -4, -5] appear before the positive numbers [1, 3, 6].
    /// Given an array of integers containing both positive and negative numbers,
    /// write a function to rearrange the array so that all the negative numbers appear on one side and all the positive numbers appear on the other side.
    /// The order of appearance of the positive or negative numbers does not matter.
    /// Idea: is to move the +ve to the right and bring the -ve to the left
    /// if number < 0, then that is -ve
    func rearrangePositiveAndNegative(_ array: inout [Int]) -> [Int] {

        var startIndex: Int = 0
        var endIndex: Int = array.count - 1

        while startIndex < endIndex {
            
            // find the +ve poistion from the left
            // while negative, increment
            while array[startIndex] < 0 {
                startIndex += 1
            }
            
            // find the negative position form the right
            while array[endIndex] > 0 {
                endIndex -= 1
            }
            
            // if negative position is > positive position, then swap it.
            if startIndex < endIndex {
                array.swapAt(startIndex, endIndex)
                startIndex += 1 // important to increment after the swap
                endIndex -= 1 // important to decrement after the swap
            }
        }
        return array
    }

    /// - NOTE: Given a one-dimensional array representing a single lane with vehicles moving in either directions,
    /// Write a function to determine how many `pairs` of vehicles are moving towards each other.
    /// Uses two-pointer technique
    func findPairs() -> Int {
        let array: [String] = [">", "<", ">", ">", "<"]
        var count = 0
        
        for (i, vehicle) in array.enumerated() {
            if vehicle == ">" {
                for j in i..<array.count {
                    if array[j] == "<" {
                        count += 1
                        break
                    }
                }
            }
        }
        return count
    }
    
    /// OJ: https://leetcode.com/problems/majority-element/description/
    /// Write down and think how it works.
    /// - seealso: incrementing decrementing
    /// Eg: [2,2,1,1,1,2,2]
    /// Idea 1: Using count increment & decrement we can solve this
    /// Idea 2: we can also solve this by frequency counter. then looking for the bigger one there.
    func majorityElement(_ nums: [Int]) -> Int {
        var element = nums[0] // starting from first number.
        var count: Int = 0
        for num in nums {
            if num == element {
                count += 1
            } else if count == 0 {
                element = num
                count += 1 // ** important
            } else {
                count -= 1
            }
        }
        return element
        
        // Alternative way.
//        _ = nums
//            .reduce(into: [Int: Int]()) { result, num in
//                result[num, default: 0] += 1
//            }
//            .max { a, b in a.value < b.value }
    }
}

extension LeetCode {

    /// - NOTE: To solve this problem we need some deep understand on string
    /// 1. String can be treated as array.
    /// 2. In string character can be appended like an array.
    ///
    /// Idea: Iterating all the characters in the first element
    /// Comparing each char with all the other string indexes.
    /// ["flow", "flowing", "flower"]
    func longestCommonPrefix(_ strs: [String]) -> String {
        var prefix: String = ""
        guard !strs.isEmpty else { return prefix }

        for (i, char) in strs.first!.enumerated() {
            for j in 1..<strs.count {
                let innerString = strs[j]
                let innerArray = Array(innerString)
                /// At times first string count could be larger.
                /// We should make sure, i (parent) is lesser than the current array count.
                let isValidIndex = i < innerArray.count
                if !isValidIndex || innerArray[i] != char {
                    return prefix
                }
            }
            prefix.append(char)
        }
        return prefix
    }

    /// - NOTE: The trick is, sell can happen only if we bought
    /// So its liks moving in foward direction
    /// Profit can be made only if we buy lower and sell higher
    /// if the current prices is less than the previous by then buy
    /// if we didn't buy for an index, try to check the selling profit in that index
    func maxProfitSingeBuySell(_ prices: [Int]) -> Int {
        guard !prices.isEmpty else { return 0 }
        var buyPrice = Int.max
        var maxProfit: Int = 0

        for currentPrice in prices {
            if currentPrice < buyPrice { // buy
                buyPrice = currentPrice
            } else { // sell
                let profilt = currentPrice - buyPrice
                maxProfit = max(maxProfit, profilt)
            }
        }
        return maxProfit
    }

    func maxProfitMultipleBuySell(_ prices: [Int]) -> Int {
        var maxProfit: Int = 0

        /// We need previous day price, in order to take decesion.
        /// Working with index, not price.
        /// Assume 0th index - yesterday price
        for day in 1..<prices.count {
            let previousDayPrice = prices[day - 1]
            let currentDayPrice = prices[day]
            if currentDayPrice > previousDayPrice { // sell
                let profit = currentDayPrice - previousDayPrice
                maxProfit += profit
            }
        }
        return maxProfit
    }

    /// Dutch National Flag Problem
    ///
    /// Given an array consisting of only 0s, 1s, and 2s, sort the elements in linear time and constant space.
    ///
    /// - idea: The idea is to move the 2 in the righ side, keeping the 0 in the left side and maintaining 1 in middle.
    /// - complexity: O(n)
    /// - seealso: Two Pointers, MultiPoints
    func dutchNationalFlag(_ a: [Int]) {

        var array: [Int] = a
        var lowIndex: Int = 0
        var midIndex: Int = 0
        var highIndex: Int = array.count - 1

        // As all the process happening with middleIndex
        while midIndex <= highIndex {
            /// Means we are looking for 0 to send left side
            if array[midIndex] == 0 {
                array.swapAt(midIndex, lowIndex) // swapping middle to low
                lowIndex += 1
                midIndex += 1 // ** important
            } else if array[midIndex] == 1 {
                midIndex += 1
            } else {
                array.swapAt(midIndex, highIndex) // swapping middle to high
                highIndex -= 1
                // We don’t increment midIndex because the new element at midIndex (swapped from highIndex) has not been processed yet
            }
        }
    }
    
    /// Sort Colors
    ///
    /// Given an array nums with n objects colored red, white, or blue, sort them in-place so that objects of the same color are adjacent, with the colors in the order red, white, and blue.
    /// We will use the integers 0, 1, and 2 to represent the color red, white, and blue, respectively.
    /// You must solve this problem without using the library's sort function.
    func sortColors(_ nums: inout [Int]) {
        guard !nums.isEmpty else { return }
        var startIndex: Int = 0
        var middleIndex: Int = 0
        var endIndex: Int = nums.count - 1
        
        // All swaps gonna happen w.r.t middle index
        while startIndex <= endIndex {
            if nums[middleIndex] == 0 {
                nums.swapAt(middleIndex, startIndex)
                startIndex += 1
                middleIndex += 1
            } else if nums[middleIndex] == 1 {
                middleIndex += 1
            } else {
                nums.swapAt(middleIndex, endIndex)
                endIndex -= 1
            }
        }
    }
    
    /// https://leetcode.com/problems/jump-game/description/
    /// Topic: Greedy algo
    func canJump(_ nums: [Int]) -> Bool {
        var reach: Int = 0
        for (index, number) in nums.enumerated() {
            if index > reach { return false } // when index goes beyond the reach
            reach = max(reach, index+number)
        }
        return reach >= nums.count - 1 // able to reach last index
    }
}

// - MARK: Top-K Elements Pattern
/// Sort - asc, Sort(by: >) - desc
/// Min heap - asc sort
/// Max heap - desc sort
extension LeetCode {
    
    /// NOTE: if its already sorted, then
    /// For `sorted`: last index - 1 should give the second largest number
    /// For `unsorted` Keep two reference (largest, second largest), update while iterating through
    /// In both largest, and smallest case, we should `look for largest and smallest case first`.
    @discardableResult
    func findSecondLargest(_ array: [Int]) -> Int {
        guard !array.isEmpty else { return -1 }
        guard array.count > 1 else { return array[0] }
        
        // we gonna iterate linearly
        var largest: Int = array[0] // Assuming the first element as largest
        var secondLargest: Int = Int.min
        
        var index = 0
        while index < array.count {
            let value = array[index]
            if value > largest {
                secondLargest = largest
                largest = value
            } else if value > secondLargest && value < largest {
                secondLargest = value
            }
            index += 1
        }
        print("Second largest: \(secondLargest)")
        return secondLargest
    }
    
    /// NOTE: First try to understand what is second smallest one.
    /// For Eg: 17, 16, 12, Here 12 is the smallest one, 16 is the second smallest one.
    ///
    /// IDEA: Iterate the entire array
    /// Use two pointer variables to hold the smallest and second smallest
    /// Update the smallest and second smallest as per our conditions
    @discardableResult
    func findSecondSmallest(_ array: [Int]) -> Int {
        guard !array.isEmpty else { return -1 }
        guard array.count > 1 else { return array[0] }
        
        var smallest: Int = array[0] // assume first element as smallest
        var secondSmallest: Int = Int.max
        
        var index: Int = 0
        while index < array.count {
            let value = array[index]
            if value < smallest {
                secondSmallest = smallest
                smallest = value
            } else if value != smallest && value < secondSmallest {
                secondSmallest = value
            }
            index += 1
        }
        let result = secondSmallest == Int.max ? -1 : secondSmallest
        print("Second smallest: \(result)")
        return result
    }
    
    func kthSmallest(_ array: [Int], _ k: Int) -> Int? {
        guard !array.isEmpty else { return nil }
        guard k > 0 && k <= array.count else { return nil } // valid index
        let sortedArray = array.sorted()  // Sort in ascending order
        return sortedArray[k - 1] // if k is 2 then 1st index is the second smallest
    }

    func kthLargest(_ array: [Int], _ k: Int) -> Int? {
        guard !array.isEmpty else { return nil }
        guard k > 0 && k <= array.count else { return nil } // valid index
        let sortedArray = array.sorted(by: >)  // Sort in descending order
        return sortedArray[k - 1]
    }
    
    /// NOTE: Array will be having only 3 elements
    func findKthLargestElement(_ array: [Int], _ k: Int) -> Int? {
        /// Ensure array has exactly 3 elments and k is valid
        guard array.count == 3, k > 0 && k <= 3 else { return nil }
        
        var largest: Int = Int.min
        var secondLargest: Int = Int.min
        var thirdLargest: Int = Int.min
        
        var index = 0
        while index < array.count {
            let value = array[index]
            if value > largest {
                thirdLargest = secondLargest
                secondLargest = largest
                largest = value
            } else if value > secondLargest {
                thirdLargest = secondLargest
                secondLargest = value
            } else if value > thirdLargest {
                thirdLargest = value
            }
            index += 1
        }
        
        return k == 0
        ? largest
        : k == 1 ? secondLargest : thirdLargest
    }
    
    // grap the prefix elements
    // asc sort it
    // traverse from the k element
    // update the heap, whenever seeing bigger values than heap
    func kthLargestUsingHeap(_ array: [Int], _ k: Int) -> Int? {
        var heap = array.prefix(k)
        heap.sort(type: .asc) // min heap

        for index in k..<array.count {
            /// Overriding the heap if the current value is greater than the heap.
            if array[index] > heap[0] {
                heap[0] = array[index]
                heap.sort(type: .asc)
            }
        }
        return heap[0]
    }

    /// By keeping the largest element at the top, we can quickly remove it if we encounter a smaller element in the array.
    /// the root of the max-heap will be the k-th smallest element after processing the entire array.
    func kthSmallestUsingHeap(_ array: [Int], _ k: Int) -> Int? {
        guard k > 0 && k <= array.count else { return nil }

        // Create a max-heap with the first `k` elements
        var heap = array.prefix(k)
        heap.sort(type: .desc) // max heap

        for i in k..<array.count {
            if array[i] < heap[0] { // ** update only if smaller number found than heap.
                heap[0] = array[i]
                heap.sort(type: .desc)
            }
        }
        return heap[0]
    }
    
    /// Given an integer array nums and an integer k, return the k most frequent elements. You may return the answer in any order.
    /// https://leetcode.com/problems/top-k-frequent-elements/?envType=problem-list-v2&envId=xlepz4mv
    ///
    /// Idea:
    /// Brute Force: use a dictionary to count the frequency, then sort the keys of the dictionary based on their frequency.
    /// Optimized: instead of sorting, use min heap with k as limit, and override whenever larger freq comes.
    func topKFrequent(_ nums: [Int] = [1,1,1,2,2,3,3,3], _ k: Int = 2) -> [Int] {
        var frequency = [Int: Int]()
        for num in nums {
            frequency[num, default: 0] += 1
        }
        // Using a min-heap to keep the top k elements
        struct Item {
            let num: Int
            let freq: Int
        }
        var heap = [Item]() // Min Heap
        for (num, freq) in frequency {
            if heap.count < k {
                heap.append(.init(num: num, freq: freq))
                heap.sort(by: { $0.freq < $1.freq }) // asc sort
            } else if freq > heap[0].freq {
                heap[0] = .init(num: num, freq: freq) // overriding the heap
                heap.sort(by: { $0.freq < $1.freq }) // Re-sort to maintain min-heap order
            }
        }
        return heap.map { $0.num }
    }
    
    /// https://leetcode.com/problems/sort-characters-by-frequency/description/?envType=problem-list-v2&envId=xlepz4mv
    func frequencySort(_ s: String) -> String {
        // Step 1: Count the frequency of each character
        var frequencyMap = [Character: Int]()
        for char in s {
            frequencyMap[char, default: 0] += 1
        }
        
        // Step 2: Desc Sort frequency
        let sortedCharacters = frequencyMap
            .sorted { $0.value > $1.value }
        
        // Step 3: Build the result string
        var result = ""
        for (char, count) in sortedCharacters {
            result += String(repeating: char, count: count)
        }
        return result
    }
    
    /// https://leetcode.com/problems/find-k-closest-elements/?envType=problem-list-v2&envId=xlepz4mv
    /// Array must be sorted
    /// Idea: Find the middle for the given x using binary search
    /// find the range
    /// adjust the range
    func findClosestElements(_ arr: [Int], _ k: Int, _ x: Int) -> [Int] {
        // find the index of the element closest to x using binary search
        var startIndex = 0
        var endIndex = arr.count - 1
        while startIndex < endIndex {
            let mid = startIndex + (endIndex - startIndex) / 2
            if arr[mid] == x {
                startIndex = mid // ***
                break
            } else if x > arr[mid] {
                startIndex = mid + 1
            } else {
                endIndex = mid - 1
            }
        }
        
        // Range from the found index.
        var low = max(0, startIndex - k)
        var high = min(arr.count-1, startIndex + k)
        
        // if length is more than k, it has to be adjusted
        while high - low + 1 > k {
            /// An integer a is closer to x than an integer b if:
            /// |a - x| < |b - x|, or |a - x| == |b - x| and a < b
            if abs(arr[low] - x) <= abs(arr[high] - x) {
                high -= 1
            } else {
                low += 1
            }
        }
        /// If both lo and hi point to the same index,
        /// it means that we've found the k closest elements centered around that index
        if low == high {
            return Array(arr[low-1...high+1])
        } else {
            return Array(arr[low...high])
        }
    }
}

// - MARK: Sliding Window
/// start, enlarge (runningSum), update lenght, reset
extension LeetCode {
    
    /// NOTE: A subarray is a contiguous part of the array. The elements must be consecutive.
    /// Eg: [1,2,3] => [1] [1,2] [1,2,3] [2] [2,3] [3]
    func findAllSubArrays(_ array: [Int]) -> [[Int]] {
        guard !array.isEmpty else { return [] }
        var subArrays = [[Int]]()
        
        for i in 0..<array.count {
            for j in i..<array.count {
                let subArray = array[i...j]
                subArrays.append(Array(subArray))
            }
        }
        return subArrays
    }
    
    /// - Discussion: Find the max number of times 1 appears consecutively (continiously).
    ///  The numbers in an array would be 0, 1's. Eg: [0, 1, 1, 1, 0, 0, 1]
    /// - Returns: Maximum number of times 1 appears consecutively
    /// - Complexity: O(n)
    /// Idea: as its asing for max, think about the window (left, right)
    /// SeeAlso: Dynamic programming solution as well.
    fileprivate func findMaxConsecutiveOnces(_ nums: [Int]) -> Int {
        var maxLength = 0
        var left = 0 // track where its started, to find the length
        var right = 0 // iterate through the array
        
        while right < nums.count {
            if nums[right] == 1 {
                maxLength = max(maxLength, (right - left + 1))
                right += 1 // enlarging only after calculating the max length
            } else {
                right += 1
                left = right
            }
        }
        return maxLength
    }
    
    /// NOTE: Find the sum of a continuous subarray of fixed `size k`.
    /// HINT: Sub array `size should be equal to k`, which is also called as fixed size subarray
    /// Idea: Calculate the first k window
    /// Then enlarge and shrink the window by index
    @discardableResult
    func maxSumOfSubarray(array: [Int], size k: Int = 3) -> Int {
        var maximumSum = Int.min
        var runningSum = 0
        
        var left = 0
        var right = 0
        
        /// Iterate the initial window size
        while right < k {
            runningSum += array[right]
            right += 1
        }
        maximumSum = runningSum
        
        while right < array.count {
            /// Shrink the window from left side
            runningSum += array[right] - array[left]
            left += 1
            /// Length Calculation
            if runningSum > maximumSum {
                maximumSum = runningSum
                print("subarray: \(array[left...right])")
            }
            /// Next loop
            right += 1
        }
        return maximumSum
    }
    
    /// NOTE: Find the `maximum length` of a subarray whose sum is `greater than or equal` to a given value k.
    /// Eg: [5,4,3,1,8] where k = 8
    /// Idea: Start enlarging the window, and start shrinking as soon as we found the subarray
    /// Returnt the length of the sub array.
    @discardableResult
    func maxLengthOfSubarray(arr: [Int] = [5,4,3,1,8], k: Int = 8) -> Int {
        
        var maxLength = Int.min // ***
        var runningSum = 0
        
        var left = 0
        var right = 0
        
        /// [5,4,3,1,8]
        while right < arr.count {
            runningSum += arr[right]
            
            while runningSum >= k { // `while` is very improtant
                /// Lenght calculation
                let length = right - left + 1
                if length > maxLength { // **
                    maxLength = length
                    print("subarray \(arr[left...right])")
                }
                /// Shrinking the window, as we found the subarray
                runningSum -= arr[left]
                left += 1
            }
            ///
            right += 1
        }
        return maxLength
    }
    
        /// NOTE: Find the `minimum length` of a subarray whose sum is `greater than or equal` to a given value k.
    @discardableResult
    func minLengthOfSubArray(array: [Int] = [5,4,3,1,8], k: Int = 8) -> Int {
        
        var subArray: [Int] = []
        var miniumLength = Int.max // ***
        var runningSum  = 0
        
        var left = 0
        var right = 0
        
        while right < array.count {
            runningSum += array[right]
             
            while runningSum >= k { // ** important
                /// Length calculation
                let length = right - left + 1
                if length < miniumLength { // **
                    miniumLength = length
                    subArray = Array(array[left...right])
                }
                /// Shrink the window as soon as we found the subarray
                runningSum -= array[left]
                left += 1
            }
            ///
            right += 1
        }
        print("Min subArray: \(subArray) - lenght: \(miniumLength)")
        return miniumLength
    }
    
    func countOfSubArrayWithSum(_ nums: [Int], _ k: Int) -> Int {
        guard !nums.isEmpty else { return 0 }
        
        var count = 0
        var runningSum = 0
        
        var left = 0
        var right = 0
        
        while right < nums.count {
            runningSum += nums[right]
        
            while runningSum > k {
                runningSum -= nums[left]
                left += 1
            }
            if runningSum == k {
                count += 1 // Found a valid subarray
            }
            right += 1
        }
        return count
    }
    
    /// NOTE: return the `number of contiguous subarrays` where the product of all the elements in the subarray is strictly `less than k`.
    /// Eg: [10, 5, 2, 6], k = 100
    func countOfSubArrayWithProduct(_ nums: [Int], _ k: Int) -> Int {
        guard !nums.isEmpty else { return 0 }
        
        var count = 0
        var runningProduct = 1
        
        var left = 0
        var right = 0
        
        while right < nums.count {
            /// Enlarnging the window
            runningProduct *= nums[right]
            ///
            while runningProduct >= k { // ** while is very important
                runningProduct /= nums[left]
                left += 1 // 1
            }
            /// Each subarray ending at `right` with a product less than k is valid subarray
            /// The place is very much important in calculating the count
            count += right - left + 1
            right += 1
        }
        return count
    }
}

// - MARK: PrefixSum Pattern
/// Idea: Cumilative Sum, HashMap
/// if index based, then init map with [0: -1]
/// if count based, then init map with [0: 1]
extension LeetCode {

    func runningSum(_ array: [Int] = [10,20,10,5,15]) -> [Int] {
        guard !array.isEmpty else { return [] }
        var prefixSum = [Int]()
        prefixSum.append(array[0])
        
        for i in 1..<array.count {
            prefixSum.append(prefixSum[i-1]+array[i])
        }
        print("runningSum: \(prefixSum)")
        return prefixSum
    }
    
    /// prefixSum[i] = arr[0] + arr[1] + arr[2] . . . arr[i].
    func prefixSum(_ array: [Int]) -> [Int] {
        runningSum(array)
    }
    
    /// https://leetcode.com/problems/find-the-highest-altitude/
    func largestAltitude(_ gains: [Int] = [-5,1,5,0,-7]) -> Int {
        var maxAltitude = 0
        var runningAltitude = 0 // tracks prefix sum
            
        for gain in gains {
            runningAltitude += gain
            maxAltitude = max(maxAltitude, runningAltitude)
        }
        print("max altitude: \(maxAltitude)")
        return maxAltitude
    }
    
    /// Given an array of n integers, find if any index exists such that
    /// the `sum of elements to its right` is `equal` to the `sum of elements to its left`.
    /// https://leetcode.com/problems/find-the-middle-index-in-array/description/
    /// Eg: [2,3,-1,8,4]
    func findMiddleIndex(_ nums: [Int]) -> Int {
        let prefixSum = runningSum(nums) // [2,5,4,12,16]

        for i in 0..<nums.count {
            let leftSum = i > 0 ? prefixSum[i-1] : 0 // upto previous index
            let rightSum = prefixSum[nums.count-1] - prefixSum[i] // from endIndex - current = rest
            if leftSum == rightSum {
                return i
            }
        }
        return -1
    }
    
    /// Find number of ways to split an array into two subarrays with
    /// the `sum of the first subarray` >= `sum of the second subarray`.
    ///
    /// Idea:
    /// find the prefix sum
    /// check each index sum is >= the remaining part
    func numberOfWaysToSplitArray(_ array: [Int]) -> Int {
            
        var prefixSum = runningSum(array)
        let totalSum = prefixSum[array.count-1]
        var count: Int = 0
        
        for i in 0..<array.count {
            let firstSubArray = prefixSum[i]
            let secondSubArray = totalSum - prefixSum[i] // remaining part.
            if firstSubArray >= secondSubArray {
                count += 1
            }
        }
        
        /// Alternative way (No extraspace, without prefixSum)
        var rightSum = 0
        var leftSum = 0
        
        for i in 0..<array.count {
            rightSum += array[i]
        }
        /// Increasing leftSum, Reducing the right sum.
        /// so that it can find the first bigger part.
        for i in 0..<array.count {
            leftSum += array[i]
            rightSum -= array[i]
            if leftSum >= rightSum {
                count += 1
            }
        }
        return count
    }
    
    /// - NOTE: Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target.
    /// You may assume that each input would have exactly one solution, and you may not use the same element twice.
    /// You can return the answer in any order.<##>
    /// Eg: Input: nums = [2,7,11,15], target = 9
    ///     Output: [0,1]
    ///     Explanation: Because nums[0] + nums[1] == 9, we return [0, 1].
    ///
    /// idea: This difference represents the second number needed to achieve the target sum.
    /// Check if the calculated difference exists in the mappingNumberToIndex dictionary.
    /// If it does, this means that a pair of numbers has been found whose sum equals the target value.
    /// `Return` indices of the two numbers such that they add up to target
    func twoSum(_ array: [Int], target: Int) -> [Int] {
        guard !array.isEmpty else { return [] }
        var number_index = [Int: Int]()
        
        for (index, number) in array.enumerated() {
            let difference = target - number
            if let otherPair = number_index[difference] {
                return [otherPair, index]
            }
            number_index[number] = index // **
        }
        return []
    }
    
    func countOfSubArray(_ nums: [Int] = [5,4,3,1,8], _ k: Int = 8) -> Int {
        /// How many sub arrays are there with the given sum
        var map = [Int: Int]() // tracks the difference
        map[0] = 1 // to handle the edge case (equal case)
        
        var count: Int = 0
        var runningSum: Int = 0

        for i in 0..<nums.count {
            runningSum += nums[i]
            let difference = runningSum - k
            if let c = map[difference] { // if there is difference, then we there is exact k
                count += c
            }
            map[runningSum, default: 0] += 1 // how manytimes we have seen
        }
        print("count of subarray: \(count)")
        return -1
    }

    func maxSubArrayLength(_ nums: [Int] = [5,4,3,1,8], _ k: Int = 8) -> Int {
        var maxLength: Int = Int.min
        var minLength: Int = Int.max
        
        var map = [Int: Int]() // num_index, stores the first occurrence of each prefix sum
        map[0] = -1 // Handles the edge case (begning)
        
        var runningSum: Int = 0
        var i = 0
        
        while i < nums.count {
            runningSum += nums[i]
            let difference = runningSum - k // important
            if let j = map[difference] { // first occurance
                let length = i - j
                maxLength = max(maxLength, i - j)
                minLength = min(minLength, i - j)
                if length > maxLength {
                    let start = i - length + 1
                    print("subarray: \(nums[start...i])")
                }
            } else {
                map[runningSum] = i
            }
            i += 1
        }
        print("lenght: \(maxLength)")
        print("map: \(map)")
        return maxLength
    }
    
    /// Given a binary array nums, return the maximum length of a
    /// contiguous subarray with an `equal number of 0 and 1`.
    /// https://leetcode.com/problems/contiguous-array/description/
    ///
    /// Idea: Consider 0 as -1 and 1 as 1. Then, the problem reduces to finding a subarray where the sum is 0.
    func maxLengthOfBinarySubarray(_ nums: [Int] = [0,1,0,1,0,1,1]) -> Int {
        var maxLength = Int.min
        
        var map = [Int: Int]() // sum_index
        map[0] = -1 // sum zero at one index before start
        
        var runningSum: Int = 0
        var i = 0
        
        while i < nums.count {
            runningSum += (nums[i] == 1) ? 1 : -1
            if let j = map[runningSum] {
                maxLength = max(maxLength, i - j)
            } else {
                map[runningSum] = i
            }
            i += 1
        }
        print("maxLength :\(maxLength)")
        return maxLength
    }
    
    /// Idea: Even sum can form odd subarray while adding odd sum into it. and viceversa.
    /// Odd - Even = odd
    /// Even - Odd = odd
    func countOfOddSubArrays(_ nums: [Int] = [1,3,5]) -> Int {
        var count = 0
        var oddCount = 0
        var evenCount = 1 // 0 is considered as even, so 1
        
        var runningSum = 0
        var i = 0
        
        while i < nums.count {
            runningSum += nums[i]
            if runningSum % 2 == 0 { // Current sum is even
                count += oddCount  // (3+2=5)
                evenCount += 1
            } else { // Current sum is odd
                count += evenCount  // any of those evenCount can form an odd subarray sum with the current odd sum (2+1=3)
                oddCount += 1
            }
            i += 1
        }
        return count
    }
}

// - MARK: Fast & Slow (involvs cycle)
extension LeetCode { }

// - MARK: Monotonic stack
/// next greater element, next smaller element, finding maximum areas
/// Time Complexity: O(n) even though there is a loop inside a loop, no element is processed more than twice (push and pop)
///
/// Clone array to track the next/previous smaller/greater elements
/// Use index stack to track index which didn't yet find the answer
/// Traverse each element, and compare each element with stack to find the answer
/// Update the stack with the current index, so that its result can be found later.
extension LeetCode {
 
    /// Idea: if array maintained in decreasing order, which means that doesn't have any next greater numbers.
    /// Eg: 4,3,2 which means it doesn't find any next greater numbers yet.
    /// Eg: [2,1,2,4,3], result = [3,2,3,-1,-1]
    func nextGreaterElements(_ nums: [Int] = [2,1,2,4,3]) -> [Int] {
        var result = Array(repeating: -1, count: nums.count) // index
        var indexStack = [Int]() // Maintains decreasing order (indices)
        for (i, num) in nums.enumerated() {
            while !indexStack.isEmpty && nums[indexStack.last!] < num { // value comparision
                result[indexStack.removeLast()] = num
            }
            indexStack.append(i)
        }
        print("result: \(result)")
        return result
    }
    
    /// Remove all the previous smaller elements, the remaining last item is what the previous greater one.
    func previousGreaterElements(_ nums: [Int] = [2,1,2,4,3]) -> [Int] {
        var result = Array(repeating: -1, count: nums.count)
        var stack = [Int]() // Stack to hold indices of nums array
        
        for (i, num) in nums.enumerated() {
            while !stack.isEmpty && nums[stack.last!] <= num { // (equal elements has to be removed)
                stack.removeLast()
            }
            // If stack is not empty, the top element is the previous greater element
            if let stackTop = stack.last {
                result[i] = nums[stackTop]
            }
            stack.append(i)
        }
        print("Result with previous greater elements: \(result)")
        return result
    }
    
    func nextSmallerElements(_ nums: [Int] = [2,1,2,4,3]) -> [Int] {
        var result = Array(repeating: -1, count: nums.count)
        var indexStack = [Int]()
        for (i, num) in nums.enumerated() {
            while !indexStack.isEmpty && nums[indexStack.last!] > num {
                result[indexStack.removeLast()] = num
            }
            indexStack.append(i) // important
        }
        return result
    }
    
    func previousSmallerElements(_ nums: [Int] = [2,1,2,4,3]) -> [Int] {
        var result = Array(repeating: -1, count: nums.count)
        var stack  = [Int]()
        for (i, num) in nums.enumerated() {
            while stack.isEmpty && nums[stack.last!] >= num {
                stack.removeLast()
            }
            // If stack is not empty, the top element is the previous smaller element
            if let stackTop = stack.last {
                result[i] = nums[stackTop]
            }
            stack.append(i)
        }
        return result
    }
    
    /// Given an array of integers temperatures represents the daily temperatures,
    /// return an array answer such that answer[i] is the number of days you have to wait after the ith day to get a warmer temperature.
    /// If there is no future day for which this is possible, keep answer[i] == 0 instead.
    ///
    /// Input: [73, 74, 75, 71, 69, 72, 76, 73]
    /// Output: [1, 1, 4, 2, 1, 1, 0, 0]
    ///
    /// Idea: Use next greater element technique (warm)
    func dailyTemperatures(_ temperatures: [Int]) -> [Int] {
        var stack: [Int] = []
        var result = Array(repeating: 0, count: temperatures.count)
        for i in 0..<temperatures.count {
            while !stack.isEmpty && temperatures[stack.last!] < temperatures[i] {
                let stackTop = stack.removeLast()
                result[stackTop] = i - stackTop // Need to find days (not temperature difference)
            }
            stack.append(i)
        }
        return result
    }
    
    /// Number of visible people in the queue
    /// https://leetcode.com/problems/number-of-visible-people-in-a-queue/description/
    ///
    /// Idea: Combination of next greater and previous greater.
    /// 1. findout then next taller person to the right (next greater)
    /// 2. also the person who is taller than the current persion (previous greater)
    func canSeePersonsCount(_ heights: [Int]) -> [Int] {
        var result = Array(repeating: 0, count: heights.count)
        var stack  = [Int]()
        for i in 0..<heights.count {
            while !stack.isEmpty && heights[stack.last!] <= heights[i] {
                let stackTop = stack.removeLast()
                result[stackTop] += 1 // next greater
            }
            if let stackTop = stack.last {
                result[i] += 1 // previous greater
            }
            stack.append(i)
        }
        return result
    }
}

// - MARK: Modified binary search pattern ****

/// Algorithm:
///
/// Find the middle element of the array.
/// Check if the middle element is the minimum element
/// If the middle element does not satisfy the minimum element condition then apply binary search on the unsorted half of the array.
extension LeetCode {
    
    /// All the problems here are following *SORTED* inputs.
    /// Without sorting, we couldn't apply modified binary search.
    
    /// Find Smallest Letter Greater Than Target (Next greater element)
    /// https://leetcode.com/problems/find-smallest-letter-greater-than-target/
    ///
    /// Idea:
    /// Character can be be compared with operators like (<,>, and =)
    /// Apply modified binary search
    /// modified binary search algorithm is to find the *leftmost occurrence* of an element in a sorted array
    func nextGreatestLetter(_ array: [Character], _ target: Character) -> Character {
        var left = 0
        var right = array.count - 1
        while left <= right {
            let mid = left + (right - left) / 2
            if array[mid] <= target {
                left = mid + 1
            } else {
                right = mid - 1
            }
        }
        return array[left % array.count]
    }
    
    /// Find Minimum in Rotated Sorted Array
    /// https://leetcode.com/problems/find-minimum-in-rotated-sorted-array/description
    ///
    /// Input: [4, 5, 6, 7, 0, 1, 2] => 0
    /// Input: [4, 5, 6, 0, 1, 2, 3] => 0
    ///
    /// Idea:
    /// min element always found in the unsorted half.
    /// find the *leftmost occurrence* of an element in a unsorted half
    /// It doesn't mean, if we find left sorted array, the right is unsorted.
    func findMin(_ array: [Int]) -> Int? {
        guard !array.isEmpty else { return nil } // Return nil if the array is empty
        var left = 0
        var right = array.count - 1
        
        while left < right {
            let mid = left + (right - left) / 2
            if array[mid] > array[right] { // Minimum is in the right half
                left = mid + 1
            } else { // Minimum is in the left half (including mid)
                right = mid
            }
        }
        // At the end, left == right, which is the min index
        return array[left]
    }
    
    // Function to find the maximum element in a rotated sorted array
    ///
    /// Input: [4, 5, 6, 7, 0, 1, 2] => 7
    /// Input: [4, 5, 6, 0, 1, 2, 3] => 6
    func findMax(_ array: [Int]) -> Int? {
        guard !array.isEmpty else { return nil } // Return nil if the array is empty
        var left = 0
        var right = array.count - 1
        
        while left < right {
            let mid = left + (right - left) / 2
            if array[mid] > array[right] { // Maximum is in the right half
                left = mid
            } else { // Maximum is in the left half (excluding mid)
                right = mid - 1
            }
        }
        return array[left]
    }
    
    /// A peak element in an array is an element that is strictly greater than its neighbors
    ///
    /// array[i] is peak if
    /// 1. array[i] > array[i-1] (if i > 0)
    /// 2. array[i] > array[i+1] (if i < array.count-1)
    ///
    /// Input: [1, 2, 3, 4, 5] (Asc)
    /// Input: [5, 4, 3, 2, 1] (Desc)
    /// Input: [1, 2, 1, 3, 1] (Mulitiple Peaks)
    func findPeak(_ array: [Int]) -> Int {
        var left = 0
        var right = array.count - 1
        while left < right {
            let mid = left + (right - left) / 2
            if array[mid] < array[mid+1] { // Peak is in the right half
                left = mid + 1
            } else { // Peak is in the left half (including mid)
                right = mid
            }
        }
        // At the end, left == right, which is the peak index
        return array[left]
    }
    
    /// Array is circular. Array can contain duplicates.
    ///
    /// Input: nums = [2, 5, 6, 0, 0, 1, 2], target = 0
    /// Input: nums = [2, 5, 6, 0, 0, 1, 2], target = 3
    ///
    /// Idea:
    /// 1. Find if its left sorted or right sorted
    /// 2. Check target lies bw range
    func searchElement(_ array: [Int], target: Int) -> Int {
        var left = 0
        var right = array.count - 1
        while left <= right {
            let mid = left + (right - left) / 2
            /// Check if the target is found
            if array[mid] == target {
                return mid
            }
            // Handle duplicates: Skip if both ends and mid are equal
            if array[left] == array[mid] && array[mid] == array[right] {
                left += 1
                right -= 1
                continue
            }
            /// Determine if the left half is sorted
            if array[left] <= array[mid] {
                /// Check if the target is in the sorted left half
                if array[left] <= target && target <= array[mid] {
                    right = mid - 1
                } else { /// left is sorted, but the target is in the right sorted half.
                    left = mid + 1
                }
            } else {
                /// Otherwise, the right half is sorted
                if array[mid] <= target && target <= array[right] {
                    left = mid + 1
                } else {
                    right = mid - 1
                }
            }
        }
        return -1
    }
    
    /// array[left] <= array[mid] -> left sorted
    /// array[mid] <= array[right] -> right sorted
    
    /// Input: [2,3,3,4,4,4,6,8]
    /// Target: 4
    /// Idea: 4,4,4 => on this assume the middle is the second 4.
    func findFirstOccuranceOfElement(_ array: [Int], _ target: Int) -> Int {
        var left = 0
        var right = array.count - 1
        while left <= right {
            let mid = left + (right - left) / 2
            if mid > 0, array[mid] == target && array[mid-1] != target {
                // found the first starting position (left)
                break
            }
            /// If we are reaching here means, even target found,
            /// that wasn't at the first position.
            /// so inorder to go to the first half, we took mid >= target
            /// only when mid > target, we can go to the first half by shrinking.
            if array[mid] >= target {
                right = mid - 1
            } else {
                left = mid + 1
            }
        }
        return -1
    }
    
    func findLastOccuranceOfElement(_ array: [Int], _ target: Int) -> Int {
        var left = 0
        var right = array.count - 1
        while left <= right {
            let mid = left + (right - left) / 2
            if mid < array.count && array[mid] == target && array[mid+1] != target {
                /// found the last poistion (right)
                break
            }
            /// if we are reaching here, even target found,
            /// that couln't be the last position.
            /// so inorder to go to the second half, we took mid <= target
            if array[mid] <= target {
                left = mid + 1
            } else {
                right = mid - 1
            }
        }
        return -1
    }
    
    func findMedianInSortedArrays(_ num1: [Int], _ num2: [Int]) -> Double {
        let array = mergeTwoSortedArray(num1, num2)
        /// findout the median (for odd length n is the median, for even the avg of n and n-1)
        let n = array.count
        let isEven = n % 2 == 0 // assume n = 4
        if isEven {
            return Double(array[(n/2)-1] + array[n/2]) / 2.0 // avg
        } else {
            return Double(array[n/2])
        }
    }
}

// - MARK: Subsequence
extension LeetCode {
 
    /// NOTE: A subset is any `selection of elements` from the array.
    /// The elements of a subset `need not to be contiguous .
    func subsets(_ nums: [Int]) -> [[Int]] {
        var result = [[Int]]()
        result.append([])
        
        for num in nums {
            result += result.map { $0 + [num] }
        }
        return result
    }
}

// K-way merge
// merge intervals
// bitwise manipulation
