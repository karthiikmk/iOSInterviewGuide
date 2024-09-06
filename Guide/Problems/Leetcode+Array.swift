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

    func reverse(array: [Int]) -> [Int] {
        var reversedArray: [Int] = array
        let endIndex: Int = reversedArray.count-1
        let startIndex: Int = 0
        var index: Int = 0

        while startIndex+index < endIndex-index {
            reversedArray.swapAt(index, endIndex-index)
            index += 1
        }
        return reversedArray
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
    func mergeTwoSortedArray(_ a: [Int], _ b: [Int]) -> [Int] {
        var c = [Int]()

        var i: Int = 0
        var j: Int = 0

        let m = a.count
        let n = b.count

        /// if any one array reaches the end, we should stop copiying.
        while i < m && j < n {
            if a[i] < b[j] {
                c.append(a[i])
                i += 1
            } else {
                c.append(b[j])
                j += 1
            }
        }

        // Copy the remaining elements
        while i < m {
            c.append(a[i])
            i += 1
        }

        while j < n {
            c.append(b[j])
            j += 1
        }

        return c
    }

    /// - NOTE: same thing we can do for the above as well.
    func mergeUnsortedArray(a: [Int], b: [Int]) -> [Int] {
        return (a + b).sorted()
    }

    /// NOTE: This will work only for sorted array.
    /// The given array must be sorted like [-2, -1, 0, 1, 2, 3]
    /// So that we can travers with via start and end
    func sortedSquares(_ A: [Int]) -> [Int] {
        var ret = [Int](repeating: 0, count: A.count)
        var startIndex = 0
        var endIndex = A.count - 1
        // By Keeping K as end of the array.
        var k = endIndex

        while startIndex <= endIndex {
            if abs(A[startIndex]) > abs(A[endIndex]) {
                ret[k] = A[startIndex] * A[startIndex]
                startIndex += 1
            } else {
                ret[k] = A[endIndex] * A[endIndex]
                endIndex -= 1
            }
            k -= 1
        }
        debugPrint("sorted square: \(ret)")
        return ret
    }

    /// Remove Element
    ///
    /// Little tricky. idea behind this is, swapping all the endIndex to startIndex
    /// Only reducing the endIndex, so startIndex will update only if its not same.
    /// [0,1,2,2,3,0,4,2], val = 2
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
    func searchInsert(_ nums: [Int], _ target: Int) -> Int {

        var start: Int = 0
        var end: Int = nums.count

        while start < end {
            let midIndex = start + (end - start) / 2
            if target == nums[midIndex] {
                return midIndex
            } else if target < nums[midIndex] {
                end = midIndex - 1
            } else {
                start = midIndex + 1
            }
        }
        debugPrint("index: \(start)")
        return start // not sure why start
    }

    func plusOne(_ digits: [Int]) -> [Int] {

        var result: Int = 0
        /// flattening digits into integer
        for digit in digits {
            result = result * 10 + digit
        }

        var incrementedResult = result + 1
        var array: [Int] = []

        /// Reversing an integer
        while incrementedResult > 0 {
            let temp = incrementedResult % 10
            array.insert(temp, at: 0)
            incrementedResult /= 10
        }
        debugPrint("plush one \(array)")
        return array
    }

    /// Sort Array By Parity
    ///
    /// Given an integer array nums, move all the even integers at the beginning of the array followed by all the odd integers.
    /// Return any array that satisfies this condition.
    ///
    /// Input: nums = [3,1,2,4]
    /// Output: [2,4,3,1]
    /// Explanation: The outputs [4,2,3,1], [2,4,1,3], and [4,2,1,3] would also be accepted.
    func sortArrayByParity(_ nums: [Int]) -> [Int] {
        guard nums.count > 1 else { return nums }

        var array: [Int] = nums
        var startIndex: Int = 0
        var endIndex: Int = array.count - 1

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
    /// first index should be taken as differentiator
    /// each index should equalise the same
    func findMissingElement(array: [Int]) -> Int? {

        let difference = array[0]

        for (index, element) in array.enumerated() {
            if (element - index) != difference { // 13 - 6 != 6
                return index + difference // missing element
            }
        }

        return nil
    }

    /// - NOTE: Array must be sorted.
    /// IDEA: The idea is to compare the current and next index
    /// If both are same the duplidated, the update the hashtable with count
    func findDuplicates(in array: [Int]) -> [Int: Int] {

        var duplicates = [Int: Int]()
        var start: Int = 0
        /// -1 is needed as we dont have the next element for the last element
        let end: Int = array.count - 1
        while start < end {
            let first = array[start]
            let next = array[start+1]
            if first == next {
                duplicates[first, default: 1] += 1
            }
            start += 1
        }
        return duplicates
    }

    /// Given an integer array nums of length n where all the integers of nums are in the range [1, n]
    /// and each integer appears once or twice, return an array of all the integers that appears twice.
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
    func removeDuplicates(_ array: inout [Int]) -> Int {
        if array.isEmpty { return 0 } // Handle edge case

        var slow = 0
        var fast = 1 // important

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
}

// MARK: - Two Pointers
extension LeetCode {

    /// - Complexity: O(n)
    func rearrangePositiveAndNegative(_ array: inout [Int]) -> [Int] {

        var left: Int = 0
        var right: Int = array.count - 1

        while left < right { // itrating till the middle element

            // find the +ve poistion here
            while array[left] < 0 {
                left += 1
            }

            // find the negative position
            while array[right] > 0 {
                right -= 1
            }

            // if negative position is > positive position, then swap it.
            if left < right {
                array.swapAt(left, right)
                left += 1 // important to increment after the swap
                right -= 1 // important to decrement after the swap
            }
        }

        return array
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

        var commonPrefix: String = ""

        for (i, char) in strs.first!.enumerated() {
            debugPrint("\(char)")
            for j in 1..<strs.count {
                let currentString = strs[j]
                let stringArray = Array(currentString)
                /// at times first string count could be larger.
                let isValidIndex = i < stringArray.count
                if !isValidIndex || stringArray[i] != char {
                    return commonPrefix
                }
            }
            commonPrefix.append(char)
        }
        return ""
    }

    /// - NOTE: The trick is, sell can happen only if we bought
    /// So its liks moving in foward direction
    /// if the current prices is less than the previous by then buy
    /// if we didn't buy for an index, try to check the selling profit in that index
    func maxProfitSingeBuySell(_ prices: [Int]) -> Int {

        var minPrice = Int.max
        var maxProfit: Int = 0

        for (_, price) in prices.enumerated() {
            if price < minPrice { // buying
                minPrice = price
            } else if price - minPrice > maxProfit { // selling
                maxProfit = price - minPrice
            }
        }
        return maxProfit
    }

    func maxProfitMultipleBuySell(_ prices: [Int]) -> Int {
        var maximumProfit: Int = 0

        for day in 1..<prices.count {
            let currentDayPrice = prices[day]
            let previousDayPrice = prices[day - 1]
            if currentDayPrice > previousDayPrice { // sell only if
                maximumProfit += currentDayPrice - previousDayPrice
            }
        }

        return maximumProfit
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
    func twoSum(_ array: [Int], target: Int) -> [Int] {

        var number_index = [Int: Int]()

        for (index, number) in array.enumerated() {
            let difference = target - number // 9 - 2 = 7

            // Find 7 is in the map, if so 2 + 7 can create the target.
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
    func twoSum(_ numbers: [Int], _ target: Int) -> [Int] {

        var startIndex: Int = 0
        var endIndex: Int = numbers.count - 1

        while startIndex <= endIndex {
            let sum = numbers[startIndex] + numbers[endIndex]
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

    /// NOTE: In a sorted array, find the kth position.
    func kthLargest(_ array: [Int], _ k: Int) -> Int? {
        guard !array.isEmpty else { return nil }
        guard k >= 0 && k < array.count else { return nil } // valid index

        let sortedArray = array.sorted()
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

    func kthSmallest(_ array: [Int], _ k: Int) -> Int? {
        guard k > 0 && k <= array.count else { return nil }

        // Create a max-heap with the first `k` elements
        var maxHeap = Array(array.prefix(k))
        maxHeap.sort(by: >) // Desc sorting

        for i in k..<array.count {
            if array[i] < maxHeap[0] {
                maxHeap[0] = array[i]
                maxHeap.sort(by: >)
            }
        }
        return maxHeap[0]
    }
}
