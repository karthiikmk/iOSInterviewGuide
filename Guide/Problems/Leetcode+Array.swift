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

    // let d = 3 // index
    // let arr = [1, 2, 3, 4, 5]
    func rotateLeft(d: Int, arr: [Int]) -> [Int] {
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
        return endIndex + 1
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
        return start
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
}

// MARK: - Two Pointers
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

        for (index, price) in prices.enumerated() {
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
}
