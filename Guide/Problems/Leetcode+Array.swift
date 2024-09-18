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
        reverse([1,2,3,4,5])
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

    /// NOTE: This will work only for sorted array.
    /// The given array must be sorted like [-2, -1, 0, 1, 2, 3]
    /// So that we can travers with via start and end
    func sortedSquares(_ array: [Int]) -> [Int] {
        var result = [Int](repeating: 0, count: array.count) // ***
        var startIndex = 0
        var endIndex = array.count - 1
        var k = endIndex // By Keeping K as end of the array.

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

    /// NOTE: Do the binary search (divide & conquer)
    func binarySearch(_ value: Int, array: [Int]) -> Bool {
        var startIndex = 0
        var endIndex = array.count - 1

        while startIndex < endIndex {
            let middleIndex = startIndex + (endIndex - startIndex) / 2
            let middleValue = array[middleIndex]
            if value == middleIndex {  // found
                return true
            } else if value < middleValue {
                endIndex = middleIndex - 1
            } else {
                startIndex = middleIndex + 1
            }
        }
        return false
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


    /// - NOTE: Given a one-dimensional array representing a single lane with vehicles moving in either directions,
    /// Write a function to determine how many `pairs` of vehicles are moving towards each other.
    /// Uses two-pointer technique
    func findPairs() -> Int {
        let array: [String] = [">", "<", ">", ">", "<"]
        var left = 0
        var right = 0
        var count = 0

        // Move the left pointer until it finds a ">"
        while left < array.count {
            if array[left] == ">" {
                // Move the right pointer from the current position of the left pointer
                right = left + 1

                // Move the right pointer until it finds a "<" or reaches the end of the array
                while right < array.count && array[right] != "<" {
                    right += 1
                }

                // If a "<" is found, increment the count by the number of "<"s found between the pointers
                if right < array.count && array[right] == "<" {
                    count += 1
                }
            }
            left += 1
        }
        return count
    }

    /// - Discussion: Find the max number of times 1 appears consecutively (continiously).
    ///  The numbers in an array would be 0, 1's. Eg: [0, 1, 1, 1, 0, 0, 1]
    /// - Returns: Maximum number of times 1 appears consecutively
    /// - Complexity: O(n)
    func findMaxConsecutiveOnces(_ nums: [Int]) -> Int {
        var left = 0 // track where its started, to find the length
        var right = 0 // iterate through the array
        var result = 0

        while right < nums.count {
            if nums[right] == 1 {
                let lenght = right - left + 1 // 2 - 1 + 1 = 2
                result = max(result, lenght)
            } else {
                left = right + 1
            }
            right += 1
        }
        return result
    }
    
    /// OJ: https://leetcode.com/problems/majority-element/description/
    /// Write down and think how it works.
    /// - seealso: incrementing decrementing
    func majorityElement(_ nums: [Int]) -> Int { // [2,2,1,1,1,2,2]
        var element = nums[0]
        var count: Int = 0
        for num in nums {
            if num == element {
                count += 1
            } else if count == 0 {
                element = num
                count += 1
            } else {
                count -= 1
            }
        }
        return element
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
            for j in 1..<strs.count {
                let currentString = strs[j]
                let stringArray = Array(currentString)
                /// at times first string count could be larger.
                /// We should make sure, i (parent) is lesser than the current array count.
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

        var price = Int.max
        var maxProfit: Int = 0

        for currentPrice in prices {
            if currentPrice < price { // buy
                price = currentPrice
            } else { // sell
                let profilt = currentPrice - price
                maxProfit = max(maxProfit, profilt)
            }
        }
        return maxProfit
    }

    func maxProfitMultipleBuySell(_ prices: [Int]) -> Int {
        var maxProfit: Int = 0

        /// We need previous day price, in order to take decesion.
        for day in 1..<prices.count {
            let currentDayPrice = prices[day]
            let previousDayPrice = prices[day - 1]
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
    /// Idea: Using Two pointer (but only applicable for sorted)
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
            if array[i] < maxHeap[0] {
                maxHeap[0] = array[i]
                maxHeap.sort(by: >)
            }
        }
        return maxHeap[0]
    }
}

// - MARK: Sliding Window
extension LeetCode {
     
    /// NOTE: Find the maximum length of a subarray whose sum is `greater than or equal` to a given value k.
    /// Eg: [5,4,3,1,8] where k = 8
    /// Idea: Start enlarging the window, and start shrinking as soon as we found the subarray
    @discardableResult
    func maxSumOfSubarray(arr: [Int] = [5,4,3,1,8], k: Int = 8) -> Int {
        var subArray = [Int]()
        var maxlength = Int.min // ***
        var runningSum = 0
        
        var left = 0
        var right = 0
        
        /// [5,4,3,1,8]
        while right < arr.count {
            /// Enlarging the window
            runningSum += arr[right]
            /// Shrinking the window
            while runningSum >= k {
                /// Lenght calculation
                let length = right - left + 1
                if length > maxlength {
                    maxlength = length
                    subArray = Array(arr[left...right])
                }
                /// Shrinking the window, as we found the subarray
                runningSum -= arr[left]
                left += 1
            }
            ///
            right += 1
        }
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
            
            while currentSum >= k {
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
        
        var startIndex: Int = 0
        var maximumSum = Int.min
        var currentSum = 0
        
        var left = 0
        var right = 0
        
        /// Iterate the initial window size
        while right < k {
            currentSum += arr[right]
            right += 1
        }        
        maximumSum = currentSum
        startIndex = left
        
        while right < arr.count {
            /// Shrink the window from left side
            currentSum += arr[right] - arr[left]
            /// Length Calculation
            if currentSum > maximumSum {
                maximumSum = currentSum
                startIndex = left + 1
            }
            left += 1
            right += 1
        }
        print("Max subArray of size \(k): \(arr[startIndex..<(startIndex+k)])")
        return maximumSum
    }
    
    /// Eg:  [-2, 1, -3, 4, -1, 2, 1, -5, 4]
    /// Output: [4, -1, 2, 1]
    /// Hint: No need to shrink the window.
    func findSumOfMaxSubArray(_ array: [Int]) {
        
        var maximumSum: Int = Int.min
        var runningSum: Int = 0
        
        var left = 0
        var right = 0
        var index = 0
        
        while index < array.count {
            /// Set the starting point
            if runningSum == 0 {
                left = index
            }
            runningSum += array[index]
            /// if some becomes negative, reset it
            if runningSum < 0 {
                runningSum = 0
            }
            if runningSum > maximumSum {
                maximumSum = runningSum
                right = index // *** right, not left
            }
            index += 1
        }
        print(array[left...right])
    }
    
    
    /// NOTE: longest consecutive sequence
    /// We need to find consequitve number, but it doesn't need to be in sequence
    /// Eg: [100, 4, 200, 1, 3, 2], Op: [1,2,3,4]
    func longestConsecutiveNumbers(_ nums: [Int]) -> [Int] {
        
        /// linearly iterate
        /// Have a set to know what are all the number exist
        /// find the start of the sequence using the previous number
        /// expand the sequence by looking at the next number
        /// lenght calculation
        var maxLength: Int = 0
        var sequence: [Int] = []
        var numSet = Set(nums)
        
        for num in nums {
            // If num - 1 is not in the set, num is the start of a sequence
            if !numSet.contains(num-1) { // ***
                var runningNum = num
                var lenth = 1
                /// Expand the sequnce
                while numSet.contains(num+1) { // ***
                    lenth += 1
                    runningNum = num+1
                }
                if lenth > maxLength {
                    maxLength = lenth
                    sequence = Array(num...runningNum) // creating new sequence.
                }
            }
        }
                
        return sequence
    }
    
    /// NOTE: return the `number of contiguous subarrays` where the product of all the elements in the subarray is strictly `less than k`.
    /// Eg: [10, 5, 2, 6], k = 100
    func subArrayWithProduct(_ nums: [Int], _ k: Int) -> Int {
        
        var count = 0
        var runningProduct = 1 /// ** since its multiplication
        
        var left = 0
        var right = 0
        
        while right < nums.count {
            /// Enlarnging the window
            runningProduct *= nums[right]
            ///
            while runningProduct >= k {
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
