//
//  Leetcode+SlidingWindow.swift
//  iOSInterviewGuide
//
//  Created by Karthik on 27/03/24.
//

import Foundation

/// - NOTE:
/// Substring - contagious
/// SubSequeunce - not really a contagious one.
extension LeetCode {

    /// - Discussion: Find the max number of times 1 appears consecutively (continiously).
    ///  The numbers in an array would be 0, 1's. Eg: [0, 1, 1, 1, 0, 0, 1]
    /// - Returns: Maximum number of times 1 appears consecutively
    /// - Complexity: O(n)
    /// - Seealso: Sliding Window, Kadane's Algorithm
    func findMaxConsecutiveOnces(_ nums: [Int]) -> Int {

        var maximum: Int = 0
        var sum: Int = 0

        for num in nums {
            sum = (num == 0) ? 0 : (sum+1)
            maximum = max(sum, maximum)
        }
        return maximum
    }

    /// Subarray Product Less Than K
    /// Given an array of integers nums and an integer k, return the number of contiguous subarrays where the product of all the elements in the subarray is strictly less than k.
    ///
    /// Product is nothing but multiplication
    func numSubarrayProductLessThanK(_ nums: [Int], _ k: Int) -> Int {
        guard k > 1 else { return 0 } // If k is less than or equal to 1, the product will always be less than k

        var count = 0
        var product = 1
        var left = 0

        for right in 0..<nums.count {
            product *= nums[right]

            // Shrink the window from the left until the product is less than k
            while product >= k {
                product /= nums[left]
                left += 1
            }

            // Each subarray ending at `right` with a product less than k contributes `right - left + 1` subarrays
            // accumulate the count of valid subarrays and return it as the result.
            count += right - left + 1
        }
        return count
    }

    /// Longest Substring Without Repeating Characters
    ///
    /// OJ: https://leetcode.com/problems/longest-substring-without-repeating-characters/description/
    ///
    /// - seealso: Sliding window
    func lengthOfLongestSubstring(_ s: String) -> Int {
        let chars = Array(s)
        var maxLength = 0

        var charSet = Set<Character>()
        var left = 0 // boundaries
        var right = 0 // boundaris

        while right < chars.count {
            let char = chars[right]
            if charSet.contains(char) {
                charSet.remove(chars[left])
                left += 1
            } else {
                charSet.insert(char)
                maxLength = max(maxLength, right - left + 1)
                right += 1
            }
        }

        return maxLength
    }

    /// Using kadane's algorithm: The idea of Kadane’s algorithm is to maintain a variable max_ending_here
    /// that stores the maximum sum contiguous subarray ending at current index and
    /// a variable max_so_far stores the maximum sum of contiguous subarray found so far,
    /// Everytime there is a positive-sum value in max_ending_here
    /// compare it with max_so_far and update max_so_far if it is greater than max_so_far.
    /// - Complexity: O(n)
    /// - Seealso: Sliding Window, Kadane's Algorithm
    func findSumOfMaxSubArray(_ array: [Int]) {

        var maximum: Int = 0
        var sum: Int = 0

        var startIndex: Int = 0
        var endIndex: Int = 0

        for (index, element) in array.enumerated() {
            /// starting point
            if sum == 0 {
                startIndex = index
            }
            sum += element
            /// if sum goes -ve, it has to be resetted.
            if sum < 0 {
                sum = 0
            }
            /// Updating max and endIndex
            if sum > maximum {
                maximum = sum
                endIndex = index
            }
        }

        debugPrint(array[startIndex...endIndex])
    }
}
