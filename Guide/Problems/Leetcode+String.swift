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

    func reverseWords(_ s: String) -> String {
        let array: [String] = s.components(separatedBy: " ")
        var newSentence: String = ""

        for word in array {
            var innerArray = Array(word)
            var startIndex: Int = 0
            var endIndex: Int = innerArray.count - 1
            while startIndex <= endIndex {
                innerArray.swapAt(startIndex, endIndex)
                startIndex += 1
                endIndex -= 1
            }
            let space = newSentence.isEmpty ? "" : " "
            newSentence += (space + "\(String(innerArray))")
        }
        debugPrint(newSentence)
        return newSentence
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

    func findDuplicates(inString string: String) -> [String: Int] {
        var duplicates = [String: Int]()
        var seenCharacters = Set<Character>()

        for char in string {
            if seenCharacters.contains(char) {
                // Increment count if character is already seen
                duplicates[String(char), default: 0] += 1
            } else {
                // Add character to the set if it's not already seen
                seenCharacters.insert(char)
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
        // 
        for _ in 0..<array.count {
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
    /// Input: s = "abbaca"
    /// Output: "ca"
    ///
    /// - seealso: stack
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

// MARK: - String + Subarray
extension LeetCode {

    //
}
