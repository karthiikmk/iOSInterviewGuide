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
    
    func runArray() {
        // reverse([1,2,3,4,5])
        sortedSquares([-2, -1, 0, 1, 2, 3])
        // maxSumOfSubarray()
        // minSumOfSubArray()
        // maxSumOfSubarray(arr: [5,4,3,1,8], size: 3)
    }
}

extension LeetCode {

    /// NOTE: Reverse using auxilary index
    @discardableResult
    func reverse(_ arr: [Int]) -> [Int] {
        var array: [Int] = arr
        let startIndex: Int = 0 // remains same
        let endIndex: Int = array.count-1 // remains same
        var index: Int = 0

        while startIndex+index < endIndex-index {
            array.swapAt(startIndex+index, endIndex-index)
            index += 1
        }
        print("Reversed: \(array)")
        return array
    }
    
    /// NOTE: Recommended way
    func reverseUsingRotate<T>(array: inout [T]) -> [T] {
        var start: Int = 0
        var end: Int = array.count - 1
        while start < end {
            array.swapAt(start, end)
            start += 1
            end -= 1
        }
        return array
    }

    // let d = 3 // index
    // let arr = [1, 2, 3, 4, 5]
    func rotateLeft(arr: [Int], d: Int) -> [Int] {
        let endIndex = arr.count-1
        var array: [Int] = arr

        func rotate(_ start: Int, _ end: Int) {
            var startIndex = start
            var endIndex = end
            while startIndex < endIndex {
                array.swapAt(start, end)
                startIndex += 1
                endIndex -= 1
            }
        }
        rotate(0, d-1)
        rotate(d, endIndex)
        rotate(0, endIndex)
        return array
    }

    /// - NOTE: Merge two sorted list into a single sorted list
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

    /// - NOTE: same thing we can do for the above as well.
    func mergeUnsortedArray(a: [Int], b: [Int]) -> [Int] {
        return (a + b).sorted()
    }

    /// NOTE: This will work only for `sorted array`.
    /// The given array must be sorted like [-2, -1, 0, 1, 2, 3]
    /// So that we can travers with via start and end
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

    /// Remove Element, lenth of the array after removing the value
    /// Eg: [0,1,2,2,3,0,4,2], val = 2
    /// Idea: is to move the element which is equal to the value to the right side pointer (endIndex)
    func removeElement(_ nums: inout [Int], _ val: Int) -> Int {

        var startIndex: Int = 0
        var endIndex: Int = nums.count - 1

        while startIndex <= endIndex {
            // Switch only if first index is not same as value
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

    /// - NOTE: Array is sorted, so use binary search
    func search(_ nums: [Int], _ target: Int) -> Int {
        var startIndex: Int = 0
        var endIndex: Int = nums.count - 1

        /// Need to check the endIndex value as well.
        while startIndex <= endIndex {
            let middleIndex = startIndex + (endIndex - startIndex) / 2
            let middleValue = nums[middleIndex]
            
            if target == middleValue {
                return middleIndex // result index
            } else if target < middleValue {
                endIndex = middleIndex - 1
            } else {
                startIndex = middleIndex + 1
            }
        }
        return -1
    }

    /// Input: [9, 9]
    /// Output: [1, 0, 0]
    /// Explanation: The array represents the integer 99. Adding one results in 100, so the output is [1, 0, 0].
    func plusOne(_ digits: [Int]) -> [Int] {
        let result = digits.reduce(0) { $0 * 10 + $1 }
        let incrementedResult = result + 1
        let array = String(incrementedResult).compactMap(\.wholeNumberValue)
        debugPrint("plush one \(array)")
        return array
    }

    /// Sort Array By Parity
    ///
    /// Given an integer array nums, `move all the even integers at the beginning` of the array followed by all the odd integers.
    /// Return any array that satisfies this condition.
    ///
    /// Input: nums = [3,1,2,4]
    /// Output: [2,4,3,1]
    /// Explanation: The outputs [4,2,3,1], [2,4,1,3], and [4,2,1,3] would also be accepted.
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
        
        while index < array.count - 1 {
            if array[index] - index != difference {
                return index + difference  // missing element
            }
            index += 1
        }
        return nil
    }

    /// - NOTE: `Array must be sorted`.
    /// IDEA: The idea is to compare the current and next index
    /// If both are same the duplidated, the update the hashtable with count
    func findDuplicatesInSortedArray(in array: [Int]) -> [Int: Int] {
        var duplicates = [Int: Int]()
        var startIndex: Int = 0
        let endIndex: Int = array.count - 1
        
        while startIndex < endIndex { // ** we need next element to check, < endIndex.
            if array[startIndex] == array[startIndex+1] {
                duplicates[array[startIndex], default: 1] += 1
            }
            startIndex += 1
        }
        return duplicates
    }
    
    /// NOTE: Array need not to be sorted.
    /// Return all the elements which appears more than once.
    func findDuplicates(in array: [Int]) -> [Int: Int] {
        
        var duplicates = [Int: Int]()
        var visiteds = Set<Int>()
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
            if visited.contains(num) {
                duplicates.insert(num)
            } else {
                visited.insert(num)
            }
        }
        debugPrint("duplicates: \(duplicates)")
        return Array(duplicates)
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
    /// Tip: This only applicable for consicutive duplicates.
    /// Return the lenght of the non duplicate values
    func removeDuplicates(_ array: inout [Int]) -> Int {
        if array.isEmpty { return 0 } // Handle edge case

        var slow = 0
        var fast = 1 // ** important

        while fast < array.count {
            if array[fast] != array[slow] { // important
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
    func removeDuplicatesInUnsortedArray(_ array: inout [Int]) -> Int {
        
        var visiteds: Set<Int> = []
        var left = 0 // treat as write index
        var right = 0  // iterator
        
        while right < array.count {
            let element = array[right]
            if !visiteds.contains(element) {
                visiteds.insert(element)
                array[left] = array[right]
                left += 1
            }
            right += 1 // loop
        }
        return left
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
    func rearrangePositiveAndNegative(_ array: inout [Int]) -> [Int] {

        var startIndex: Int = 0
        var endIndex: Int = array.count - 1

        while startIndex < endIndex {
            
            while array[startIndex] < 0 { // find the +ve poistion here
                startIndex += 1
            }
            
            while array[endIndex] > 0 { // find the negative position
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
        
        for (index, vehicle) in array.enumerated() {
            guard vehicle == ">" else { continue }
            var start = index + 1 // looking for pairs from the next elements
            while start < array.count {
                if array[start] == "<" {
                    count += 1
                    break
                }
                start += 1
            }
        }
        return count
    }

    /// - Discussion: Find the max number of times 1 appears consecutively (continiously).
    ///  The numbers in an array would be 0, 1's. Eg: [0, 1, 1, 1, 0, 0, 1]
    /// - Returns: Maximum number of times 1 appears consecutively
    /// - Complexity: O(n)
    func findMaxConsecutiveOnces(_ nums: [Int]) -> Int {
        
        var maximum = 0
        var left = 0 // track where its started, to find the length
        var right = 0 // iterate through the array
        
        while right < nums.count {
            if nums[right] == 1 {
                let lenght = right - left + 1 // 2 - 1 + 1 = 2
                maximum = max(maximum, lenght)
            } else {
                left = right + 1
            }
            right += 1
        }
        return maximum
    }
    
    /// OJ: https://leetcode.com/problems/majority-element/description/
    /// Write down and think how it works.
    /// - seealso: incrementing decrementing
    /// Hint: we can also solve this by num_count cache. then looking for the bigger one there.
    func majorityElement(_ nums: [Int]) -> Int {
        var element = nums[0]
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
        //    var nums_count = [Int: Int]()
        //    for num in nums {
        //        nums_count[num, default: 0] += 1
        //    }
        //    print(nums_count)
        //    // which ever the count is maximum return that number
        //    var max = Int.min
        //    var number: Int = -1
        //    for (_number, count) in nums_count {
        //        if count > max {
        //            number = _number
        //            max = count
        //        }
        //    }
        //    return number
    }
}

// MARK: - SubArray (Sliding Window)
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
        var ourPrice = Int.max
        var maxProfit: Int = 0

        for price in prices {
            if price < ourPrice { // buy
                ourPrice = price
            } else { // sell
                let profilt = price - ourPrice
                maxProfit = max(maxProfit, profilt)
            }
        }
        return maxProfit
    }

    func maxProfitMultipleBuySell(_ prices: [Int]) -> Int {
        var maxProfit: Int = 0

        /// We need previous day price, in order to take decesion.
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
                midIndex += 1
            } else if array[midIndex] == 1 {
                midIndex += 1
            } else {
                array.swapAt(midIndex, highIndex) // swapping middle to high
                highIndex -= 1
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
            number_index[number] = index
        }
        return []
    }

    /// Two Sum II - Input Array Is Sorted
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
            let sum = numbers[startIndex] + numbers[endIndex] // ***
            if sum == target {
                return [startIndex + 1, endIndex + 1] // 1 Indexed array.
            } else if sum < target {
                startIndex += 1
            } else {
                endIndex -= 1
            }
        }
        
        return []
    }
}

extension LeetCode {

    func kthSmallest(_ array: [Int], _ k: Int) -> Int? {
        guard !array.isEmpty else { return nil }
        guard k > 0 && k <= array.count else { return nil } // valid index
        let sortedArray = array.sorted()  // Sort in ascending order
        return sortedArray[k - 1]
    }

    func kthLargest(_ array: [Int], _ k: Int) -> Int? {
        guard !array.isEmpty else { return nil }
        guard k > 0 && k <= array.count else { return nil } // valid index
        let sortedArray = array.sorted(by: >)  // Sort in descending order
        return sortedArray[k - 1]
    }

    func kthLargestUsingHeap(_ array: [Int], _ k: Int) -> Int? {
        var minHeap = array.prefix(k)
        minHeap.sort() // asc sorting

        for index in k..<array.count {
            if array[index] > minHeap[0] {
                minHeap[0] = array[index]
                minHeap.sort()
            }
        }
        return minHeap[0]
    }

    func kthSmallestUsingHeap(_ array: [Int], _ k: Int) -> Int? {
        guard k > 0 && k <= array.count else { return nil }

        // Create a max-heap with the first `k` elements
        var maxHeap = Array(array.prefix(k))
        maxHeap.sort(by: >) // Desc sorting

        for i in k..<array.count {
            if array[i] < maxHeap[0] { // ** update only if smaller number found than heap.
                maxHeap[0] = array[i]
                maxHeap.sort(by: >)
            }
        }
        return maxHeap[0]
    }
}

// - MARK: Sliding Window
extension LeetCode {
    
    func findASubArrays(_ array: [Int]) -> [[Int]] {
        guard !array.isEmpty else { return [] }
        
        var subArrays = [[Int]]()
        var start = 0 // update if we needed for particular start and end
        var end = array.count - 1
        
        for i in start...end {
            for j in i...end {
                let subArray = array[i...j]
                subArrays.append(Array(subArray))
            }
        }
        return subArrays
    }
     
    /// NOTE: Find the maximum length of a subarray whose sum is `greater than or equal` to a given value k.
    /// Eg: [5,4,3,1,8] where k = 8
    /// Idea: Start enlarging the window, and start shrinking as soon as we found the subarray
    /// Returnt the length of the sub array.
    @discardableResult
    func maxSumOfSubarray(arr: [Int] = [5,4,3,1,8], k: Int = 8) -> Int {
        
        var maxlength = Int.min // ***
        var runningSum = 0
        var subArrayStartIndex = 0
        
        var left = 0
        var right = 0
        
        /// [5,4,3,1,8]
        while right < arr.count {
            /// Enlarging the window
            runningSum += arr[right]
            
            while runningSum >= k {
                /// Lenght calculation
                let length = right - left + 1
                if length > maxlength {
                    maxlength = length
                    subArrayStartIndex = left
                }
                /// Shrinking the window, as we found the subarray
                runningSum -= arr[left]
                left += 1
            }
            ///
            right += 1
        }
        let subArray = Array(arr[subArrayStartIndex..<subArrayStartIndex+maxlength])
        print("Max subarray: \(subArray) - lenght: \(maxlength)")
        return maxlength
    }
    
        /// NOTE: Find the minimum length of a subarray whose sum is `greater than or equal` to a given value k.
    @discardableResult
    func minSumOfSubArray(arr: [Int] = [5,4,3,1,8], k: Int = 8) -> Int {
        
        var subArray: [Int] = []
        var miniumSum = Int.max // ***
        var currentSum = 0
        
        var left = 0
        var right = 0
        
        while right < arr.count {
            /// Maximizing the window
            currentSum += arr[right]
             
            while currentSum >= k { // ** important
                /// Length calculation
                let length = right - left + 1
                if length < miniumSum {
                    miniumSum = length
                    subArray = Array(arr[left...right])
                }
                /// Shrink the window as soon as we found the subarray
                currentSum -= arr[left]
                left += 1
            }
            ///
            right += 1
        }
        print("Min subArray: \(subArray) - lenght: \(miniumSum)")
        return miniumSum
    }
    
    /// NOTE: Find the sum of a continuous subarray of `size k`.
    /// HINT: Sub array size should be equal to k, which is also called as fixed size subarray
    @discardableResult
    func maxSumOfSubarray(arr: [Int], size k: Int = 3) -> Int {
        
        var maximumSum = Int.min
        var currentSum = 0
        
        var left = 0
        var right = 0
        var subArrayStartIndex: Int = 0
        
        /// Iterate the initial window size
        while right < k {
            currentSum += arr[right]
            right += 1
        }        
        maximumSum = currentSum
        subArrayStartIndex = left
        
        while right < arr.count {
            /// Shrink the window from left side
            currentSum += arr[right] - arr[left]
            /// Length Calculation
            if currentSum > maximumSum {
                maximumSum = currentSum
                subArrayStartIndex = left + 1
            }
            left += 1
            right += 1
        }
        print("Max subArray of size \(k): \(arr[subArrayStartIndex..<(subArrayStartIndex+k)])")
        return maximumSum
    }
    
    /// Eg:  [-2, 1, -3, 4, -1, 2, 1, -5, 4]
    /// Output: [4, -1, 2, 1]
    /// Hint: No need to shrink the window.
    /// Important.
    func findSumOfMaxSubArray(_ array: [Int]) {
        
        var maximumSum: Int = Int.min
        var runningSum: Int = 0
        
        var start = 0 // start of the window
        var end = 0 // end of the window
        var index = 0
        
        while index < array.count {
            /// Set the starting point
            if runningSum == 0 {
                start = index
            }
            runningSum += array[index]
            /// if some becomes negative, reset it
            if runningSum < 0 { // *** very important
                runningSum = 0
            }
            if runningSum > maximumSum {
                maximumSum = runningSum
                end = index // *** right, not left
            }
            index += 1
        }
        print(array[start...end])
    }
    
    /// NOTE: longest consecutive sequence
    /// We need to find consequitve number, but it doesn't need to be in sequence
    /// Eg: [100, 4, 200, 1, 3, 2], Op: [1,2,3,4]
    /// Idea is take the number, and check if that is fresh start,
    /// then check the number set for the consective numbers using counter.
    /// if there is previous number then its not fresh start.
    func longestConsecutiveNumbers(_ nums: [Int]) -> [Int] {
        
        var maxLength: Int = Int.min
        var sequence = [Int]()
        let numberSet = Set(nums)
        var index = 0
        
        while index < nums.count {
            let number = nums[index]
            /// Looking for the fresh start.
            if !numberSet.contains(number-1) {
                var runningNumber = number
                var length = 1
                
                while numberSet.contains(runningNumber+1) {
                    length += 1
                    runningNumber += 1
                }
                if length > maxLength {
                    maxLength = length
                    sequence = Array(number...runningNumber) // ** creating sequence using `running number` not with lenght.
                }
            }
            /// Next loop
            index += 1
        }
        return sequence
    }
    
    /// NOTE: return the `number of contiguous subarrays` where the product of all the elements in the subarray is strictly `less than k`.
    /// Eg: [10, 5, 2, 6], k = 100
    func subArrayWithProduct(_ nums: [Int], _ k: Int) -> Int {
        guard !nums.isEmpty else { return 0 }
        
        var count = 0
        var runningProduct = 1 /// ** since its multiplication
        
        var left = 0
        var right = 0
        
        while right < nums.count {
            /// Enlarnging the window
            runningProduct *= nums[right]
            ///
            while runningProduct >= k { // ** while is very important
                /// Shrinking the window
                runningProduct /= nums[left]
                left += 1
            }
            /// Each subarray ending at `right` with a product less than k is valid subarray
            /// The place is very much important in calculating the count
            count += right - left + 1
            ///
            right += 1
        }
        return count
    }
}
