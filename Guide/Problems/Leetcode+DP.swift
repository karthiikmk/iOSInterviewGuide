//
//  Leetcode+DP.swift
//  iOSInterviewGuide
//
//  Created by Karthik on 10/10/24.
//

import Foundation

extension LeetCode {
    
    /// https://www.youtube.com/watch?v=CFQk7OQO_xM&list=PLrmLmBdmIlpsHaNTPP_jHHDx_os9ItYXr&index=31
    /// - complexity:: O(n)
    func climbStairs(_ n: Int) -> Int {
        // Base cases: 0 ways to climb 0 or 1 step, 1 way to climb 2 steps
        if n == 0 || n == 1 || n == 2 { return n } // ** important.
        return climbStairs(n - 1) + climbStairs(n - 2)
    }
    
    /// https://www.youtube.com/watch?v=UtGtF6nc35g&list=PLrmLmBdmIlpsHaNTPP_jHHDx_os9ItYXr&index=32&pp=iAQB
    /// NOTE: Non-Adjacent (not to each other.)
    /// Topic: Dynamic programming.
    func maxSumOfNonAdjacentElements(_ nums: [Int]) -> Int {
        
        var incl = nums[0] // including inclusive what is the sum.
        var excl = 0 // excluding inclusive, this will give the sum.
        
        for num in nums {
            let temp = incl
            incl = max(incl, num+excl)
            excl = temp
        }
        return incl
    }
    
    /// https://leetcode.com/problems/longest-common-subsequence/
    /// https://www.youtube.com/watch?v=jHGgXV27qtk
    /// NOTE: The goal is to find the length of the longest subsequence that is present
    /// in both strings in the same order, but not necessarily consecutively.
    /// Topics: Dynamic programming
    /// Idea: if first and second char are same, then 1 + diagnal value
    /// if not, then max of the dp[i-1][j] or dp[i][j-1]
    /// Input: text1 = "abcde", text2 = "ace"
    /// Output: 3
    func longestCommonSubsequence(_ text1: String, _ text2: String) -> Int {
        
        var m = text1.count
        var n = text2.count
        
        /// To compare each char, we need arrays
        var firstArray = Array(text1)
        var secondArray = Array(text2)
        
        var dp = Array(repeating: Array(repeating: 0, count: n+1), count: m+1)
        
        for i in 1...text1.count {
            for j in 1...text2.count {
                if firstArray[i-1] == secondArray[j-1] { // char are equal
                    dp[i][j] = dp[i-1][j-1] + 1 // diagnal value (refer the video)
                } else {
                    dp[i][j] = max(dp[i-1][j], dp[i][j-1]) // max of left or up value
                }
            }
        }
        
        let length = dp[m][n]
        var i = m
        var j = n
        var result: [Character] = []
        
        /// Now lets find out the sequence by iterating from right.
        while i > 0 && j > 0 {
            if firstArray[i-1] == secondArray[j-1] {
                result.append(firstArray[i-1])
                i -= 1
                j -= 1
            } else if dp[i-1][j] > dp[i][j-1] {
                // Move up if the value above is larger
                i -= 1
            } else {
                // Move left if the value on the left is larger or equal
                j -= 1
            }
        }
        let sequence = String(result.reversed())
        print("subsequence: \(sequence)")
        return length
    }
    
    /// NOTE: Given two text, find the common longest `substring` (should be contagious)
    /// Topic: Dynamic programming
    func longestCommonSubstring(_ text1: String, _ text2: String) -> Int {
        
        let m = text1.count
        let n = text2.count
        if m == 0 || n == 0 { return 0 }
        
        let text1Array = Array(text1)
        let text2Array = Array(text2)
        
        // DP table where dp[i][j] holds the length of the longest common substring ending at text1[i-1] and text2[j-1]
        var dp = Array(repeating: Array(repeating: 0, count: n + 1), count: m + 1)
        var maxLength = 0
        var endPosition = 0
        
        // Fill the DP table
        for i in 1...m {
            for j in 1...n {
                if text1Array[i - 1] == text2Array[j - 1] {
                    dp[i][j] = dp[i - 1][j - 1] + 1
                    
                    // Update maximum length and ending position
                    if dp[i][j] > maxLength {
                        maxLength = dp[i][j]
                        endPosition = i // Track the ending position of the longest common substring
                    }
                }
            }
        }
        
        // Extract the longest common substring
        let startPosition = endPosition - maxLength
        let longestSubstring = String(text1Array[startPosition..<endPosition])
        print("length of longest substrign: \(maxLength), substring: \(longestSubstring)")
        return maxLength
    }
    
    /// https://leetcode.com/problems/longest-increasing-subsequence/
    /// Input: nums = [10,9,2,5,3,7,101,18]
    /// Output: 4
    func lengthOfLongestIncreasingSequence(_ nums: [Int]) -> Int {
        
        var dp = Array(repeating: 1, count: nums.count) // DP array to store the length of LIS at each index
        var idx = Array(repeating: -1, count: nums.count) // To track the indices of the previous element in the subsequence
        
        for i in 1..<nums.count {
            for j in 0..<i {
                if nums[i] > nums[j] {
                    if (dp[j] + 1) >= dp[i] {
                        dp[i] = dp[j] + 1
                        idx[i] = j // if we use max, then this will create ovverriden problem
                    }
                }
            }
        }
        /// Calculating the sequence.
        var index = nums.count-1
        var result = [Int]()
        
        while index != -1 {
            let prevIndex = idx[index]
            let value = nums[index]
            result.append(value)
            index = prevIndex
        }
        print("idx: \(idx)")
        print("subseq: \(Array(result.reversed()))")
        return dp.max() ?? 1
    }
    
    /// Check if any subsequence has the given target
    /// Topics: Dynamic programming
    func isSubsetSum(_ array: [Int], _ target: Int) -> Bool {
        let n = array.count
        // Create a DP table with size (n+1) x (target+1)
        var dp = Array(repeating: Array(repeating: false, count: target + 1), count: n + 1)
        
        // Initialize the first column, since we can always make sum 0 by selecting no elements
        for i in 0...n {
            dp[i][0] = true
        }
        
        // Fill the DP table
        for i in 1...n {
            for j in 1...target {
                if j < array[i - 1] {
                    // If the current element is greater than the sum, we can't include it
                    dp[i][j] = dp[i - 1][j]
                } else {
                    // Either exclude the current element or include it
                    dp[i][j] = dp[i - 1][j] || dp[i - 1][j - array[i - 1]]
                }
            }
        }
        // The answer will be at dp[n][target]
        return dp[n][target]
    }
    
    /// Eg:  [-2, 1, -3, 4, -1, 2, 1, -5, 4]
    /// Output: [4, -1, 2, 1]
    func maxSubArray(_ array: [Int]) {
        /// dp keep tracks of maxSum at each index.
        var dp = Array(repeating: 0, count: array.count)
        dp[0] = array[0]
        var maxSum: Int = array[0]
        
        for i in 1..<array.count {
            /// Adding current number with previous sum and see if its big.
            dp[i] = max(dp[i-1]+array[i], array[i])
            maxSum = max(maxSum, dp[i])
        }
        print("maxsum: \(maxSum)")
    }
}
