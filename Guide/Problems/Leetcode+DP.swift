//
//  Leetcode+DP.swift
//  iOSInterviewGuide
//
//  Created by Karthik on 10/10/24.
//

import Foundation


/*
 longestPalindromeSubstring - diagnol filling. 0 for char not equal
 longestPalindromeSubsequce - diagnol, take max of diagnol when char not same.
 lengthOfLongestCommonSubstring - normal filling. but starting from 1 to m
 lengthOfLongestCommonSubsequence - normal filling. starting from 1
*/
extension LeetCode {
    
    /// https://www.youtube.com/watch?v=CFQk7OQO_xM&list=PLrmLmBdmIlpsHaNTPP_jHHDx_os9ItYXr&index=31
    /// - complexity:: O(n)
    func climbStairs(_ n: Int) -> Int {
        // Base cases: 0 ways to climb 0 or 1 step, 1 way to climb 2 steps
        if n == 0 || n == 1 || n == 2 { return n } // ** important.
        return climbStairs(n - 1) + climbStairs(n - 2)
    }
    
    /// NOTE: https://www.youtube.com/watch?v=fxwvVnBMN6I
    /*
     Diagnal Iteration
     We need a difference to iterate and fill the dp table diagnolly.
     
     for diff in 0..<5 {
        for i in 0..<(5-diff) {
            let j = i+diff
            print("(\(i), \(j))")
        }
     }
    */
    /// Eg: aabaa
    /// In a string, every char is a palindrome (so in diagnal, setting 1 for single char by default)
    func longestPalindromeSubstring(_ s: String) -> String {
        
        var longestPalindrome = ""
        var maxLength = Int.min
        
        /// we gonna fill the array diagnoly
        let array = Array(s)
        let n = array.count
        var dp = Array(repeating: Array(repeating: 0, count: n), count: n)

        /// using diff, we can easily iterate diagnally
        /// if diff == 1, then its 2 chars check.
        for diff in 0..<n {
            for i in 0..<(n-diff) {
                let j = i+diff
                
                if i == j { // single char is valid palindrome
                    dp[i][j] = 1
                } else if diff == 1 { // for 2 chars
                    dp[i][j] = array[i] == array[j] ? 2 : 0
                } else {
                    if array[i] == array[j] && dp[i+1][j-1] > 0 { // we need to make sure there is valid palindrom diagonal.
                        dp[i][j] = dp[i+1][j-1] + 2
                    } else {
                        dp[i][j] = 0 // this is where subsequnce is differing 
                    }
                }
                // finding the max length
                // same subsequence method also can be applied to calc the substring
                if dp[i][j] > maxLength {
                    maxLength = dp[i][j]
                    longestPalindrome = String(array[i...j])
                }
            } // End of loop
        } // End of loop
        
        return longestPalindrome
    }
    
    /// NOTE: palindrom `need not to be contagious`
    /// https://www.youtube.com/watch?v=_nCsPn7_OgI
    /// Eg: agbdba
    func longestPalindromeSubsequce(_ s: String) -> String {
        
        /// we gonna fill the array diagnoly
        let array = Array(s)
        let n = array.count
        var dp = Array(repeating: Array(repeating: 0, count: n), count: n)
        
        /// using diff, we can easily iterate diagnally
        for diff in 0..<n {
            for i in 0..<(n-diff) {
                let j = i+diff
                
                if i == j { // single char is valid palindrome
                    dp[i][j] = 1
                } else if diff == 1 {
                    dp[i][j] = (array[i] == array[j])
                    ? 2
                    : max(dp[i + 1][j], dp[i][j - 1]) // **important
                } else {
                    dp[i][j] = (array[i] == array[j])
                    ? dp[i+1][j-1] + 2
                    : max(dp[i + 1][j], dp[i][j - 1]) // **important
                }
            }
        }
        
        // Reconstruct the longest palindromic subsequence
        var i = 0
        var j = n - 1
        var left = ""
        var right = ""
        
        /// Start comparign first and last char for palindrome
        while i <= j {
            if array[i] == array[j] {
                if i == j {
                    left.append(array[i])
                } else {
                    left.append(array[i])
                    right.insert(array[j], at: right.startIndex) // **
                }
                i += 1 // for diagonal lookup
                j -= 1 // for diagonal lookup
            } else if dp[i + 1][j] > dp[i][j - 1] {
                i += 1
            } else {
                j -= 1
            }
        }        
        return left + right
    }
    
    /// https://www.youtube.com/watch?v=UtGtF6nc35g&list=PLrmLmBdmIlpsHaNTPP_jHHDx_os9ItYXr&index=32&pp=iAQB
    /// NOTE: Non-Adjacent (not to each other.)
    /// Topic: Dynamic programming.
    func maxSumOfNonAdjacentElements(_ nums: [Int]) -> Int {
        
        var incl = nums[0] // including inclusive what is the sum.
        var excl = 0 // excluding inclusive, this will give the sum.
        
        for i in 1..<nums.count {
            let temp = incl
            incl = max(incl, excl+nums[i])
            excl = temp
        }
        return incl
    }
    
    /// NOTE: Given two text, find the common longest `substring` (should be contagious)
    /// Eg: abcdaf, gbcdf, Op: bcd
    /// Topic: Dynamic programming
    func lengthOfLongestCommonSubstring(_ text1: String, _ text2: String) -> Int {
        
        let m = text1.count
        let n = text2.count
        if m == 0 || n == 0 { return 0 }
        
        let text1Array = Array(text1)
        let text2Array = Array(text2)
        
        // DP table where dp[i][j] holds the length of the longest common substring ending at text1[i-1] and text2[j-1]
        var dp = Array(repeating: Array(repeating: 0, count: n + 1), count: m + 1)
        var maxLength = 0
        var longestSubstring = ""
        
        // Fill the DP table
        for i in 1...m {
            for j in 1...n {
                // Proceeding only if the char are same.
                if text1Array[i - 1] == text2Array[j - 1] {
                    // filling
                    dp[i][j] = dp[i - 1][j - 1] + 1
                    // Update maximum length and ending position
                    if dp[i][j] > maxLength {
                        maxLength = dp[i][j]
                        let endPosition = i
                        let startPosition = endPosition - maxLength
                        longestSubstring = String(text1Array[startPosition..<endPosition])
                    }
                } else {
                    dp[i][j] = 0
                }
            }
        }
        
        // Extract the longest common substring
        // let startPosition = endPosition - maxLength
        // let longestSubstring = String(text1Array[startPosition..<endPosition])
        print("length of longest substrign: \(maxLength), substring: \(longestSubstring)")
        return maxLength
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
    func lengthOfLongestCommonSubsequence(_ text1: String, _ text2: String) -> Int {
        
        let m = text1.count
        let n = text2.count
        
        /// To compare each char, we need arrays
        let firstArray = Array(text1)
        let secondArray = Array(text2)
        
        var dp = Array(repeating: Array(repeating: 0, count: n+1), count: m+1)
        
        /// filling the table
        for i in 1...text1.count {
            for j in 1...text2.count {
                if firstArray[i-1] == secondArray[j-1] { // char are equal
                    dp[i][j] = dp[i-1][j-1] + 1 // diagnal value (refer the video)
                } else {
                    dp[i][j] = max(dp[i-1][j], dp[i][j-1]) // max of left or up value
                }
            }
        }
        
        var i = m
        var j = n
        var result: [Character] = []
        
        /// Start comparing bacwards in both text
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
        return dp[m][n]
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
    
    /// find the `subarray` which has `max sum`
    /// Eg:  [-2, 1, -3, 4, -1, 2, 1, -5, 4]
    /// Output: [4, -1, 2, 1]
    func maxSubArray(_ array: [Int]) {
        
        /// dp keep tracks of maxSum at each index.
        /// dp[i] represents the maximum sum of any subarray ending at index i
        /// the maximum sum we can achieve by including that index in a subarray ending there
        var dp = Array(repeating: 0, count: array.count)
        dp[0] = array[0]
        var maxSum: Int = array[0]
        
        var tempStart = 0
        var start = 0
        var end = 0
        
        /// tempStart only marks the beginning of a potential maximum subarray.
        /// We only set start to tempStart when we actually find a new maximum sum.
        for i in 1..<array.count {
            
            /// Old method.
            /// dp[i] = max(dp[i-1]+array[i], array[i])
            /// maxSum = max(maxSum, dp[i])
            let currentValue = array[i]
            let previousSum = dp[i-1]
            
            if currentValue > previousSum+currentValue { /// fresh start
                dp[i] = currentValue
                tempStart = i
            } else {
                dp[i] = previousSum+currentValue
            }
        
            /// Here is what the subarray is expanding
            if dp[i] > maxSum {
                maxSum = dp[i]
                start = tempStart
                end = i
            }
        }
        
        let subarray = array[start...end]
        print("subarray: \(subarray)")
        print("maxsum: \(maxSum)")
    }
}
