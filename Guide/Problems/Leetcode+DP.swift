//
//  Leetcode+DP.swift
//  iOSInterviewGuide
//
//  Created by Karthik on 10/10/24.
//

import Foundation


/*
 Top-k
 overlapping intervals
 modified binary search
 traversal
    inorder - to retrive the vlues in binary saerch tree in SORTED ORDER
    preorder - to create a copy of a tree (serialization)
    postorder - want to process the child nodes before the parent node
    level order - need to explore all nodes at current level before the next
 matirx traversal
 backtracking
   - perumutation
   - combinations
   - generate all possible subsets
 Dynamic programming
 
 longest consecutive subsequence
 
 subset sum problems
 matrix chain mutiplication
 
 longestPalindromeSubstring - diagnol filling. 0 for char not equal
 longestPalindromeSubsequce - diagnol, take max of diagnol when char not same.
 lengthOfLongestCommonSubstring - normal filling. but starting from 1 to m
 lengthOfLongestCommonSubsequence - normal filling. starting from 1
 0/1 knapsack
*/

/// https://blog.algomaster.io/p/20-patterns-to-master-dynamic-programming
extension LeetCode {
    
    /// https://www.youtube.com/watch?v=CFQk7OQO_xM&list=PLrmLmBdmIlpsHaNTPP_jHHDx_os9ItYXr&index=31
    /// - complexity:: O(n)
    func climbStairs(_ n: Int) -> Int {
        // Base cases: 0 ways to climb 0 or 1 step, 1 way to climb 2 steps
        if n == 0 || n == 1 || n == 2 { return n } // ** important.
        return climbStairs(n - 1) + climbStairs(n - 2)
    }
    
    /// NOTE: https://www.youtube.com/watch?v=fxwvVnBMN6I

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
}

// - MARK: DP Table (One dimensional)
extension LeetCode {
    
    /// - Discussion: Find the max number of times 1 appears consecutively (continiously).
    ///  The numbers in an array would be 0, 1's. Eg: [0, 1, 1, 1, 0, 0, 1]
    /// - Returns: Maximum number of times 1 appears consecutively
    /// - Complexity: O(n)
    /// Idea: Using dynamic programming to accumulate the sum
    fileprivate func findMaxConsecutiveOnces(_ array: [Int]) -> Int {
        
        var dp = Array(repeating: 0, count: array.count)
        dp[0] = array[0]
        
        var maxOnes = dp[0]
        
        for i in 1..<array.count {
            if array[i] == 1 {
                dp[i] = dp[i-1] + 1 // previous + 1
                maxOnes = max(maxOnes, dp[i])
            } else {
                dp[i] = 0
            }
        }
        return maxOnes
    }
    
    /// find the `subarray` which has `max sum`
    /// Eg:  [-2, 1, -3, 4, -1, 2, 1, -5, 4]
    /// Output: [4, -1, 2, 1]
    func findMaxSubArraySum(_ array: [Int]) {
        
        /// dp keep tracks of maxSum at each index.
        /// `dp[i]` represents the `maximum sum of any subarray ending at index i`
        /// the maximum sum we can achieve by including that index in a subarray ending there
        var dp = Array(repeating: 0, count: array.count)
        dp[0] = array[0]
        
        var maxSum: Int = array[0]
        var start = 0
        
        /// tempStart only marks the beginning of a potential maximum subarray.
        /// We only set start to tempStart when we actually find a new maximum sum.
        for i in 1..<array.count {
            /// Old method.
            /// dp[i] = max(dp[i-1]+array[i], array[i])
            /// maxSum = max(maxSum, dp[i])
            if array[i] > dp[i-1] + array[i] { // fresh start as this element is max
                dp[i] = array[i]
                start = i
            } else {
                dp[i] = dp[i-1] + array[i]
            }
            /// Here is what the subarray is expanding
            if dp[i] > maxSum {
                maxSum = dp[i]
                print("subArray: \(array[start...i])")
            }
        }
        print("maxsum: \(maxSum)")
    }
    
    /// https://leetcode.com/problems/longest-increasing-subsequence/
    /// Input: nums = [10,9,2,5,3,7,101,18]
    /// Output: 4
    func longestIncreasingSubSequence(_ array: [Int]) -> Int {
        
        // DP array to store the length of LIS at each index
        // Each element lenght is 1, that itself a subsequence, so cloing with 1
        var dp = Array(repeating: 1, count: array.count)
        var idx = Array(repeating: -1, count: array.count) // To track the indices of the previous element in the subsequence
        
        for i in 1..<array.count {
            for j in 0..<i { // j starts from 0 and goes till i, reset again from start.
                if array[j] < array[i] {
                    /// Length alone
                    /// dp[i] = max(dp[i], array[j]+1)
                    if (dp[j] + 1) >= dp[i] {
                        dp[i] = dp[j] + 1
                        idx[i] = j
                    }
                }
            }
        }
        /// Calculating the sequence.
        /// Traversing from right to left
        var index = array.count-1
        var result = [Int]()
        
        while index != -1 {
            let goToIndex = idx[index]
            let value = array[index]
            result.append(value)
            index = goToIndex
        }
        print("idx: \(idx)")
        print("subseq: \(Array(result.reversed()))")
        return dp.max() ?? 1
    }
    
    /// NOTE: longest consecutive sequence
    /// We need to find consequitve number, but it `doesn't need` to be in sequence
    /// Eg: [100, 4, 200, 1, 3, 2], Op: [1,2,3,4]
    /// Idea is take the number, and check if that is fresh start,
    /// then check the number set for the consective numbers using counter.
    /// if there is previous number then its not fresh start.
    func longestConsecutiveSubsequence(_ nums: [Int]) -> [Int] {
        
        var maxLength: Int = Int.min
        var sequence = [Int]()
        let numberSet = Set(nums)
        var index = 0
        
        while index < nums.count {
            let number = nums[index]
            /// Looking for the fresh start.
            if !numberSet.contains(number-1) {
                var runningNumber = number // why becoz we cant say its always 1. it can be any number, from there the sequence.
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
}

// - MARK: DP Table (Two dimensional)
extension LeetCode {
    
    /*
     Diagnal Iteration
     We need a difference to iterate and fill the dp table diagnolly.
     
     for diff in 0..<n {
     for i in 0..<(n-diff) {
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
        for diff in 0..<n { // 0, 1, 2, 3, 4
            for i in 0..<(n-diff) { // 0, 1, 2, 3, 4
                let j = i+diff
                
                /// array: aabaa
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
    /// https://leetcode.com/problems/delete-operation-for-two-strings/description/
    /// https://leetcode.com/problems/shortest-common-supersequence/description/
    ///
    /// https://www.youtube.com/watch?v=jHGgXV27qtk
    /// NOTE: The goal is to find the length of the longest subsequence that is present
    /// in both strings in the same order, but not necessarily consecutively.
    /// Topics: Dynamic programming
    /// Idea: if first and second char are same, then 1 + diagnal value
    /// if not, then max of the dp[i-1][j] or dp[i][j-1]
    /// Input: text1 = "abcde", text2 = "ace"
    /// Output: 3
    func longestCommonSubsequence(_ text1: String, _ text2: String) -> Int {
        
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
    
    /// https://leetcode.com/problems/number-of-longest-increasing-subsequence/description/
    func findNumberOfLongestIncreasingSubsequence(_ nums: [Int]) -> Int {
        return -1
    }
}

// - MARK: DP on Grid
extension LeetCode {
    
}
