//
//  Leetcode+DynamicProgramming.swift
//  iOSInterviewGuide
//
//  Created by Karthik on 30/03/24.
//

import Foundation

extension LeetCode {

    /// Find the longest palindrome substring in a string
    ///
    /// - precondition: string shoult not be empty, indides should be in the limit
    /// - returns: longest palindrome substring
    /// - seealso: kadanes algorithm
    func findLongestPalindromSubstring(in string: String) -> String? {
        guard !string.isEmpty else { return nil }

        let array = Array(string)
        var longestPalindrome: String?

        /// Iterating all elements in an array.
        for (index, _) in array.enumerated() {
            // Initially setting left and right as 0
            var left = index
            var right = index
            // Expand outwards from the current center character(s)
            while left >= 0 && right < array.count, array[left] == array[right] {
                left -= 1 // exceeding to break the loop
                right += 1 // exceeding to break the loop
            }
            /// - NOTE: This is very important to calculate the length of current palindrome.
            let currentLength = right - left - 1 // IMP: [m, o, m] // start = -1, end = 3
            if currentLength > (longestPalindrome?.count ?? 0) {
                // adding and sub 1 becouse while loop fails only after exceeding condition
                longestPalindrome = String(array[left+1...right-1])
            }
        }
        debugPrint(longestPalindrome ?? "nil")
        return longestPalindrome
    }
}
