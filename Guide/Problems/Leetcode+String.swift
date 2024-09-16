//
//  Leetcode+String.swift
//  Algorithms
//
//  Created by Karthik on 22/03/24.
//

import Foundation

/*
 26. Check if a string is a palindrome
 36. Find the longest palindrome substring in a string.
 33. Find all permutations of a string.
 27. Check if two strings are anagrams of each other.
*/
extension LeetCode {

    /// Valid Palindrome
    ///
    /// A phrase is a palindrome if, after converting all uppercase letters into lowercase letters and removing all non-alphanumeric characters,
    /// it reads the same forward and backward. Alphanumeric characters include letters and numbers.
    /// Given a string s, return true if it is a palindrome, or false otherwise.
    ///
    /// Eg: racecar, madam
    func validPalindrome(string: String) -> Bool {

        let array = Array(string)
        var startIndex = 0
        var endIndex = array.count - 1

        while startIndex < endIndex {
            if array[startIndex] != array[endIndex] {
                return false
            }
            startIndex += 1
            endIndex -= 1
        }
        return true
    }

    func reverse(string: String) -> String {

        var stringArray = Array(string)
        var startIndex = 0
        var endIndex = stringArray.count - 1

        while startIndex < endIndex {
            stringArray.swapAt(startIndex, endIndex)
            startIndex += 1
            endIndex -= 1
        }

        return String(stringArray)
    }

    func reverseString(_ s: String, _ k: Int) -> String {

        var array: [Character] = Array(s)
        let endIndex: Int = array.count - 1

        func rotate(_ start: Int, _ end: Int) {
            var startIndex: Int = start
            var endIndex: Int = end

            while startIndex <= endIndex {
                array.swapAt(startIndex, endIndex)
                startIndex += 1
                endIndex -= 1
            }
        }

        rotate(0, k - 1)
        rotate(k, endIndex)
        rotate(0, endIndex)

        return String(array)
    }

    /// NOTE: Think about the bus number rolling board. where number continously comes and goes off
    /// So each char goes and and the same comes again at the end
    func rotateString(_ s: String, _ goal: String) -> Bool {

        var array = Array(s)
        let endIndex = array.count - 1

        func rotate(start: Int, end: Int) {
            var left = start
            var right = end

            while left < right {
                array.swapAt(left, right)
                left += 1
                right -= 1
            }
        }
        // Bustand
        for _ in 0..<array.count {
            // These two rotation required to complete the entire string rotation
            // Think about moving a chat from first to last position, considered as a single rotation.
            rotate(start: 1, end: endIndex)
            rotate(start: 0, end: endIndex)

            let string = String(array)
            debugPrint("rotated string: \(string)")
            if string == goal {
                return true
            }
        }
        return false
    }

    /// Reverse String
    ///
    /// Write a function that reverses a string. The input string is given as an array of characters s.
    /// You must do this by modifying the input array in-place with O(1) extra memory.
    func reverseString(_ s: inout [Character]) {

        var startIndex: Int = 0
        var endIndex: Int = s.count - 1

        while startIndex < endIndex {
            s.swapAt(startIndex, endIndex)
            startIndex += 1
            endIndex -= 1
        }

        debugPrint("chars: \(s)")
    }

    /// NOTE: Split the string by space
    /// Reverse each word like normal reverse
    /// Merge the reversed word array and append it in new string
    func reverseWords(_ s: String) -> String {
        let array: [String] = s.components(separatedBy: " ")
        var newSentence: String = ""

        for word in array {
            var wordArray = Array(word)
            var startIndex: Int = 0
            var endIndex: Int = wordArray.count - 1
            while startIndex <= endIndex {
                wordArray.swapAt(startIndex, endIndex)
                startIndex += 1
                endIndex -= 1
            }
            let space = newSentence.isEmpty ? "" : " "
            newSentence += (space + "\(String(wordArray))")
        }
        debugPrint(newSentence)
        return newSentence
    }

    /// Reverse Vowels of a String
    ///
    /// Given a string s, reverse only all the vowels in the string and return it.
    /// The vowels are 'a', 'e', 'i', 'o', and 'u', and they can appear in both lower and upper cases, more than once.
    /// - important: increment/decrement the index only if not a vowel.
    /// - Complexity: O(n)
    func reverseVowels(_ s: String) -> String {
        let vowels: Set<Character> = ["a", "e", "i", "o", "u"]
        var array = Array(s)

        var startIndex: Int = 0
        var endIndex: Int = array.count - 1

        while startIndex <= endIndex {
            let first = array[startIndex]
            let last = array[endIndex]

            // IMP: Moving foward only if its not vowel
            if vowels.contains(first) && vowels.contains(last) {
                array.swapAt(startIndex, endIndex)
                startIndex += 1
                endIndex -= 1
            } else if vowels.contains(first) { // looking for the next vowlels in backwards to swap
                endIndex -= 1
            } else { // looking for the next vowel in forward forward to swap
                startIndex += 1
            }
        }
        debugPrint("reverse vowels: \(String(array))")
        return String(array)
    }

    /// Reverse Only Letters
    ///
    /// Given a string s, reverse the string according to the following rules:
    /// 1. All the characters that are not English letters remain in the same position.
    /// 2. All the English letters (lowercase or uppercase) should be reversed.
    func reverseOnlyLetters(_ s: String) -> String {

        var array: [Character] = Array(s)
        var startIndex: Int = 0
        var endIndex: Int = array.count - 1

        while startIndex <= endIndex {
            let start = array[startIndex]
            let end = array[endIndex]

            if start.isLetter && end.isLetter {
                array.swapAt(startIndex, endIndex)
                startIndex += 1
                endIndex -= 1
            } else if start.isLetter {
                endIndex -= 1
            } else {
                startIndex += 1
            }
        }
        debugPrint(String(array))
        return String(array)
    }

    ///
    /// - complexity: O(n)
    func firstUniqChar(_ s: String) -> Int {

        var mapCharToIndex = [Character: Int]()

        // Mapping characters with their count
        for (_, char) in s.enumerated() {
            mapCharToIndex[char, default: 0] += 1
        }
        for (index, char) in s.enumerated() {
            if mapCharToIndex[char] == 1 {
                return index
            }
        }
        return -1
    }

    /// -seealso: Hashmap, order of index
    func firstUniqCharUsingHashMap(_ s: String) -> Int {

        var mapCharWithCount = [Character: Int]()
        var mapCharToIndex = [Character: Int]()

        for (index, char) in s.enumerated() {
            if mapCharWithCount[char] == nil { // nothing avalialbe
                mapCharWithCount[char] = 1
                mapCharToIndex[char] = index
            } else {
                mapCharWithCount[char]! += 1 // duplidated
                mapCharToIndex[char] = nil
            }
        }

        var minIndex: Int = s.count
        for (_, index) in mapCharToIndex {
            minIndex = min(minIndex, index)
        }
        return minIndex
    }

    /// NOTE:
    /// Trick: We can iterate the string directly rather converting as array.
    func findDuplicates(inString string: String) -> [String: Int] {
        var duplicates = [String: Int]()
        var visiteds = Set<Character>()

        for char in string {
            if visiteds.contains(char) {
                duplicates[String(char), default: 0] += 1
            } else {
                visiteds.insert(char)
            }
        }
        return duplicates
    }

    /// Check if two strings are anagrams of each other
    ///
    /// Anagrams are words or phrases formed by rearranging the letters of another word or phrase,
    /// listen" and "silent" are anagrams because they contain the same letters  ('l', 'i', 's', 't', 'e', 'n') in the same quantity, just rearranged differently.
    /// - precondition: strings length must be same
    /// - Returns: true or false
    /// - Complexity: O(n)
    /// - Seealso: Hashing, Frequency Counting
    func areAnagrams(_ s: String, _ t: String) -> Bool {
        // Convert both strings to arrays of characters
        let sArray = Array(s)
        let tArray = Array(t)

        // BaseCondition: Check if the lengths of the two strings are different
        if sArray.count != tArray.count {
            return false
        }
        // Create dictionaries to store the frequency of characters in both strings
        var sFreq = [Character: Int]()
        var tFreq = [Character: Int]()

        // Count the frequency of characters in the first string
        for char in sArray {
            sFreq[char, default: 0] += 1
        }
        // Count the frequency of characters in the second string
        for char in tArray {
            tFreq[char, default: 0] += 1
        }
        // Compare the frequency of characters in both dictionaries
        return sFreq == tFreq
    }

    /// Find all permutations of a string.
    ///
    /// Number of ways in which the string can be arrianged
    /// Learnign about how permutation works t
    /// - seealso: recurssion
    func permutations(of string: String) -> [String] {

        var result = [String]()
        let array = Array(string)

        /// - NOTE: We are not iterating each char in the array, rather iteration the while string n tiems.
        func permute(array: [Character], startIndex: Int, endIndex: Int, result: inout [String]) {
            // Basecondtion, which reaching the leaf
            if startIndex == endIndex {
                result.append(String(array))
            } else {
                for index in startIndex...endIndex  { // iterating each character
                    var str = array
                    str.swapAt(startIndex, index) // swap start to the index
                    permute(array: str, startIndex: startIndex + 1, endIndex: endIndex, result: &result)
                }
            }
        }
        permute(array: array, startIndex: 0, endIndex: array.count - 1, result: &result)
        return result
    }

    func rotateStringUsingConcadination(_ s: String, _ goal: String) -> Bool {
        let hasSameLenghth = s.count == goal.count
        let isEmpty = s.count == 0 && goal.count == 0
        let containsGoal = (s+s).contains(goal) // forms cicular behaviour
        return hasSameLenghth && !isEmpty && containsGoal
    }

    /// Remove All Adjacent Duplicates In String
    ///
    /// You are given a string s consisting of lowercase English letters. A duplicate removal consists of choosing two adjacent and equal letters and removing them.
    /// We repeatedly make duplicate removals on s until we no longer can.
    /// Return the final string after all such duplicate removals have been made. It can be proven that the answer is unique.
    ///
    /// Input: s = "abbbaca"
    /// Output: "ca"
    ///
    /// - seealso: stack
    /// Tips: only two adjacent, not more than that.
    func removeDuplicates(inString s: String) -> String {
        let stack = Stack<Character>()
        for character in s {
            if !stack.isEmpty && character == stack.peek() {
                stack.pop()
            } else {
                stack.push(character)
            }
        }
        return String(stack.storage)
    }

    /// Shuffle String
    ///
    /// You are given a string s and an integer array indices of the same length. 
    /// The string s will be shuffled such that the character at the ith position moves to indices[i] in the shuffled string.
    ///
    /// Input: s = "codeleet", indices = [4,5,6,7,0,2,1,3]
    /// Output: "leetcode"
    /// Explanation: As shown, "codeleet" becomes "leetcode" after shuffling.
    ///
    /// Return the shuffled string.
    func restoreString(_ s: String, _ indices: [Int]) -> String {

        var result = Array<Character>(repeating: " ", count: indices.count)
        for (index, char) in s.enumerated() {
            let locationIndex = indices[index]
            result[locationIndex] = char
        }
        debugPrint("shuffled string \(String(result))")
        return String(result)
    }
}

extension LeetCode {

    /// Longest Substring Without Repeating Characters
    ///
    /// OJ: https://leetcode.com/problems/longest-substring-without-repeating-characters/description/
    ///
    /// Eg: abcabcbb
    /// - seealso: Sliding window
    /// The idea is to have the visited entires to enloarge the range.
    /// if already visited, then we should start sliding the window as its starts repeating.
    func lengthOfLongestSubstring(_ s: String) -> Int {
        let chars = Array(s)
        var maxLength = 0
        var startIndexOfMaxSubstring = 0

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
                if (right - left + 1) > maxLength {
                    maxLength = right - left + 1
                    startIndexOfMaxSubstring = left
                }
                /// Next loop
                right += 1
            }
        }

        let longestSubstring = String(chars[startIndexOfMaxSubstring..<(startIndexOfMaxSubstring + maxLength)])
        print(longestSubstring)
        return maxLength
    }

    // Eg: abbaa, answer is aaaa
    /// NOTE: The idea is to check for the left and right equalance
    func lengthOfLongestConsecutiveSubstring(_ s: String = "aaabbbbaaaa") {

        let array = Array(s)
        var maxLength = 0
        var substringStartPostion = 0

        var left = 0 // 7
        var right = 0 // 7

        while right < array.count {
            if array[right] == array[left] { // a == a
                if (right - left + 1) >= maxLength { // 10 - 7 + 1 = 3
                    maxLength = right - left + 1 // 4
                    substringStartPostion = left // 3
                }
                right += 1 // 11 - exit
            } else {
                left = right // 7
            }
        }

        let substring = String(array[substringStartPostion..<(substringStartPostion+maxLength)])
        print(substring)
    }
}

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
