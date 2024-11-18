//
//  Leetcode+String.swift
//  Algorithms
//
//  Created by Karthik on 22/03/24.
//

import Foundation

/*
 Blind 75: Strings
 
 Longest Substring Without Repeating Characters - done (visiteds)
 Longest Repeating Character Replacement - done (arr[left] == arr[right])
 Minimum Window Substring
 Valid Anagram - done (char freq)
 Group Anagrams - done (sort)
 Valid Parentheses - done ( using stack )
 Valid Palindrome - done
 Longest Palindromic Substring - done (dynamic programming)
 Palindromic Substrings - done
 Encode and Decode Strings (Leetcode Premium)
*/
extension LeetCode {
    
    func runString() {
        // isPalindrome("A man, a plan, a canal: Panama")
        // allSubstrings("abc")
        // countSubstrings("aaa")
        // characterReplacement("AABABBA", 1)
        // groupAnagrams()
        // groupAnagramsUsingSort()
    }

    func reverse(string: String) -> String {

        var arr = Array(string)
        var startIndex = 0
        var endIndex = arr.count - 1

        while startIndex < endIndex {
            arr.swapAt(startIndex, endIndex)
            startIndex += 1
            endIndex -= 1
        }

        return String(arr)
    }

    /// Eg: abcdef -> badcfe
    /// reversing by offsets (eg, by 2 chars in entire string)
    func reverseString(_ s: String, by offset: Int) -> String {
        
        var array = Array(s)
        func reverse(start: Int, end: Int) {
            var startIndex = start
            var endIndex = end
            while startIndex < endIndex {
                array.swapAt(startIndex, endIndex)
                startIndex += 1
                endIndex -= 1
            }
        }
        
        var index = 0
        while index < array.count {
            let startIndex = index
            let endIndex = min(index+offset-1, array.count-1) // inorder to avoid out of bounds.
            reverse(start: startIndex, end: endIndex)
            
            index += offset // NextLoop
        }
        return String(array)
    }
    
    func rotateString(_ s: String, position: Int) -> String {
        
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
        
        rotate(0, position - 1)
        rotate(position, endIndex)
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
    ///
    /// Idea: Find vowel from left to right
    /// find vwel from right to left
    /// swap both of them
    func reverseVowels(_ s: String) -> String {
        let vowels: Set<Character> = ["a", "e", "i", "o", "u"]
        var array = Array(s)

        var startIndex: Int = 0
        var endIndex: Int = array.count - 1
        
        func isVowel(_ index: Int) -> Bool {
            return vowels.contains(array[index])
        }
        
        while startIndex < endIndex {
            /// Step1: finding the vowel from left to right
            while startIndex < array.count && !isVowel(startIndex) {
                startIndex += 1
            }
            /// Step2: finding the vowel from right to left
            while endIndex >= 0 && !isVowel(endIndex) {
                endIndex -= 1
            }
            /// Swapping the found index (index should be valid)
            if startIndex < endIndex {
                array.swapAt(startIndex, endIndex)
            }
            /// Important
            startIndex += 1
            endIndex -= 1
        }
        print("reverse vowels: \(String(array))")
        return String(array)
    }

    /// Reverse Only Letters
    ///
    /// Given a string s, reverse the string according to the following rules:
    /// 1. All the characters that are not English letters remain in the same position.
    /// 2. All the English letters (lowercase or uppercase) should be reversed.
    func reverseOnlyLetters(_ s: String) -> String {
        var arr: [Character] = Array(s)
        var startIndex: Int = 0
        var endIndex: Int = arr.count - 1

        while startIndex <= endIndex {
            if arr[startIndex].isLetter && arr[endIndex].isLetter {
                arr.swapAt(startIndex, endIndex)
                startIndex += 1
                endIndex -= 1
            } else if arr[startIndex].isLetter {
                endIndex -= 1
            } else {
                startIndex += 1
            }
        }
        debugPrint(String(arr))
        return String(arr)
    }
    
    /// Idea: find the index of a given charactor
    /// do the normal reverse upto the found index
    func reversePrefix(_ word: String, _ ch: Character) -> String {
        
        var array: [Character] = Array(word)
        func rotate(start: Int, end: Int) {
            var startIndex: Int = start
            var endIndex: Int = end
            
            while startIndex <= endIndex {
                array.swapAt(startIndex, endIndex)
                startIndex += 1
                endIndex -= 1
            }
        }
        for (index, char) in array.enumerated() {
            if char == ch {
                rotate(start: 0, end: index)
                break
            }
        }
        debugPrint("reverse prefix: \(String(array))")
        return String(array)
    }

    /// - complexity: O(n)
    /// If unique char means, that char should be found only once.
    /// To compare that we need a collection
    func firstUniqChar(_ s: String) -> Int {

        var char_count = [Character: Int]()

        // Mapping characters with their count
        for (_, char) in s.enumerated() {
            char_count[char, default: 0] += 1
        }
        for (index, char) in s.enumerated() {
            if char_count[char] == 1 {
                return index
            }
        }
        return -1
    }

    /// NOTE:
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
        // BaseCondition: Check if the lengths of the two strings are different
        if s.count != t.count { return false }
        // Create dictionaries to store the frequency of characters in both strings
        var sFreq = [Character: Int]()
        var tFreq = [Character: Int]()

        // Count the frequency of characters in the first string
        for char in s {
            sFreq[char, default: 0] += 1
        }
        // Count the frequency of characters in the second string
        for char in t {
            tFreq[char, default: 0] += 1
        }
        // Compare the frequency of characters in both dictionaries
        return sFreq == tFreq
    }
        
    /// Idea: Take one, check visited state.
    /// if not visited, then take that as anagram, and check the other anagrams using inner loop
    @discardableResult
    func groupAnagrams(_ strs: [String] = ["eat","tea","tan","ate","nat","bat"]) -> [[String]] {
        var result = [[String]]()
        var visiteds = Set<String>()
        
        for (index, str) in strs.enumerated() {
            guard !visiteds.contains(str) else { continue }
            var anagrams = [String]()
            visiteds.insert(str)
            anagrams.append(str)
            /// Inner loop excluding the anagram.
            var startIndex = index + 1
            while startIndex < strs.count {
                let innerStr = strs[startIndex]
                if areAnagrams(str, innerStr) {
                    visiteds.insert(innerStr)
                    anagrams.append(innerStr)
                }
                /// Next loop
                startIndex += 1
            }
            result.append(anagrams)
        }
        print("result: \(result)")
        return result
    }
    
    /// NOTE: Another nice idea is using sort.
    /// Key: sorted string, Value: Acutal String
    /// [SortedString: ActualString]
    func groupAnagramsUsingSort(_ strs: [String] = ["eat","tea","tan","ate","nat","bat"]) -> [[String]] {
        var anagrams = [String: [String]]()
        for str in strs {
            let anagram = String(str.sorted())
            anagrams[anagram, default: []] += [str]
        }
        let result = Array(anagrams.values)
        print("result: \(result)")
        return result
    }
    
    /// https://leetcode.com/problems/valid-parentheses/
    /// Idea: Using `stack datastructre`,
    /// Pushing into the stack if open braces
    /// Peaking and poping if the braces is closing.
    func isValidParentheses(_ string: String = "([]))") -> Bool {
        let openBrackets = Set<Character>(["(", "{", "["])
        let brackets: [Character: Character] = ["(": ")", "[": "]", "{": "}"]
        let stack = Stack<Character>()
        
        for bracket in string {
            if openBrackets.contains(bracket) {
                stack.push(bracket)
            } else {
                /// Checking.
                if let openBracket = stack.pop() {
                    let closeBracket = brackets[openBracket]
                    /// if stack is empty, but there is closing bracket means its invalid.
                    /// if closing bracket is not equal then its invalid.
                    if stack.isEmpty || bracket != closeBracket {
                        return false
                    }
                }
            }
        }
        return stack.isEmpty // important
    }

    func rotateStringUsingConcadination(_ s: String, _ goal: String) -> Bool {
        let hasSameLenghth = s.count == goal.count
        let isEmpty = s.count == 0 && goal.count == 0
        let containsGoal = (s+s).contains(goal) // forms cicular behaviour
        return hasSameLenghth && !isEmpty && containsGoal
    }

    /// Remove All `Adjacent Duplicates` In String
    ///
    /// You are given a string s consisting of lowercase English letters.
    /// A duplicate removal consists of choosing `two adjacent` and `equal letters` and removing them.
    /// We repeatedly make duplicate removals on s until we no longer can.
    /// Return the final string after all such duplicate removals have been made. It can be proven that the answer is unique.
    ///
    /// Input: s = "abbaca"
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
    /// Input: s = "codeleet", indices = [4,5,6,7,0,1,2,3]
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

// - MARK: Palindrome
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
    
    /// https://leetcode.com/problems/valid-palindrome/
    func isPalindrome(_ s: String) -> Bool {
        let lowercased = s.lowercased()
        /// Removing non alpha numeric characters 
        let string = lowercased.filter { $0.isLetter || $0.isNumber } // **
        return validPalindrome(string: string)
    }
    
    /// https://leetcode.com/problems/longest-palindromic-substring/
    /// Find the longest palindrome `substring` in a string (shoud be contagious)
    ///
    /// - precondition: string shoult not be empty, indides should be in the limit
    /// - returns: longest palindrome substring
    /// - seealso: kadanes algorithm, Dynamic programming (alternative way)
    func longestPalindrome(in string: String) -> String? {
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
            let currentPalindrome = String(array[left+1...right-1])
            if currentPalindrome.count > (longestPalindrome?.count ?? 0) {
                longestPalindrome = currentPalindrome
            }
        }
        debugPrint(longestPalindrome ?? "nil")
        return longestPalindrome
    }
}

// - MARK: Substring
extension LeetCode {
    
    /// `Substring` is a contiguous sequence of characters within the string.
    /// For eg: "abc" - a,ab,abc,b,bc,c (sub strings)
    func allSubstrings(_ s: String) -> [String] {
        let array = Array(s)
        var subStrings = [String]()
        for i in 0..<s.count {
            for j in i..<s.count {
                let subString = array[i...j]
                subStrings.append(String(subString))
            }
        }
        print("Substrings: \(subStrings)")
        return subStrings
    }
        
    /// https://leetcode.com/problems/palindromic-substrings/
    /// Given a string s, return the number of palindromic substrings in it.
    func countSubstrings(_ s: String) -> Int {
        let subStrings = allSubstrings(s)
        var count: Int = 0
        
        for subString in subStrings where validPalindrome(string: subString) {
            print("Valid palindrome substring: \(subString)")
            count += 1
        }
        return count
    }

    /// Longest Substring Without Repeating Characters
    ///
    /// OJ: https://leetcode.com/problems/longest-substring-without-repeating-characters/description/
    ///
    /// Eg: abcabcbb
    /// - seealso: Sliding window
    ///
    /// Idea: Have the visited entires to enlarge the range.
    /// if already visited, then we should start sliding the window as its starts repeating.
    /// Window is not to calculate the length.
    /// Calculate the length while inserting (where its enlarging the window)
    func lengthOfLongestSubstringWithoutRepeatingCharacters(_ s: String) -> Int {
        let arr = Array(s)
        var maxLength = 0
        var substringStartIndex = 0

        var visiteds = Set<Character>()
        var left = 0 // boundaries
        var right = 0 // boundaris

        while right < arr.count {
            let char = arr[right]
            if !visiteds.contains(char) { // ** important
                visiteds.insert(char)
                
                let length = right - left + 1
                if length > maxLength {
                    maxLength = length
                    substringStartIndex = left
                }
                /// Next loop
                right += 1
            } else {
                visiteds.remove(arr[left])
                left += 1
            }
        }
        let longestSubstring = String(arr[substringStartIndex..<(substringStartIndex + maxLength)])
        print(longestSubstring)
        return maxLength
    }

    // Eg: abbaa, answer is aaaa
    /// NOTE: The idea is to check for the left and right equalance
    /// lengthOfLongestSubStringWithSameCharacters, arr[right] == arr[left]
    /// Idea: Take the left and compare it with right
    /// Topi: Sliding window
    func lengthOfLongestConsecutiveSubstring(_ s: String = "aaabbbbaaaa") {
        let array = Array(s)
        var maxLength = 0
        var substringStartIndex = 0

        var left = 0
        var right = 0

        while right < array.count {
            if array[left] == array[right] { // ** important
                let length = right - left + 1
                if length >= maxLength {
                    maxLength = length
                    substringStartIndex = left
                }
                right += 1
            } else {
                left = right
            }
        }

        let substring = String(array[substringStartIndex..<(substringStartIndex+maxLength)])
        print(substring)
    }
    
    /// Minimum Length of String After Deleting Similar Ends
    ///
    /// https://leetcode.com/problems/minimum-length-of-string-after-deleting-similar-ends/description/
    /// Eg: "aabccabba"
    /// Output: 3 (cca)
    func minimumLength(_ s: String) -> Int {
        let arr: [Character] = Array(s)
        var left: Int = 0
        var right: Int = arr.count - 1
        
        while left < right {
            guard arr[left] == arr[right] else { break } // making sure both left and right side similar char
            let charToRemove = arr[left]
            
            while left <= right && arr[left] == charToRemove {
                left += 1
            }
            // This check wont allow endIndex to cross the startIndex
            while left <= right && arr[right] == charToRemove {
                right -= 1
            }
        }
        return right - left + 1
    }
    
    /// https://leetcode.com/problems/longest-repeating-character-replacement/
    /// Longest Repeating Character Replacement
    /// Idea: track how many times each char is available
    /// Among those the max freq char
    func characterReplacement(_ s: String, _ k: Int) -> Int {
        
        let arr = Array(s)
        var charFreq = [Character: Int]()
        var maxLength = 0
        var maxFreq = 0
        
        var left = 0
        var right = 0
        
        // AABABBA
        while right < arr.count {
            let char = arr[right]
            // Update frequency map for the current character
            charFreq[char, default: 0] += 1
            // Find the max frequency character in the current window
            maxFreq = max(maxFreq, charFreq[char]!)
            /// (right - left + 1) - maxCount represents how many characters you would need to change
            /// to turn all the characters in the window into the most frequent character.
            if (right - left + 1) - maxFreq > k {
                charFreq[arr[left]]! -= 1
                left += 1
            }
            /// Update the maximum length of a valid window
            if right - left + 1 > maxLength {
                maxLength = right - left + 1
                print("SubString: \(String(arr[left...right])), maxLength: \(maxLength)")
            }
            right += 1
        }
        
        return maxLength
    }
}

// - MARK: Pattern Matching
extension LeetCode {
    
    /// NOTE: return starting index if pattern is matched
    /// Timecomplexity: O(m*n*)
    /// m is lenth of the text, n is the lenght of the pattern
    func naivePatternSearch(text: String, pattern: String) -> Int? {
    
        let textArray = Array(text)
        let patternArray = Array(pattern)
        
        let m = textArray.count
        let n = patternArray.count
        
        for i in 0...(m-n) {
            var j = 0
            /// j should be lesser than the pattern count
            while j < n && textArray[i+j] == patternArray[j] {
                j += 1
            }
            if j == n {
                return i // we reached pattern
            }
        }
        return nil
    }
}
