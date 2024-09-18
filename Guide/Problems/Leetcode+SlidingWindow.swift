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
}
