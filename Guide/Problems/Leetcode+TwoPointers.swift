//
//  Leetcode+TwoPointers.swift
//  Algorithms
//
//  Created by Karthik on 24/03/24.
//

import Foundation

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
            } else if vowels.contains(first) {
                endIndex -= 1
            } else {
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
    ///
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

    /// Given a non-negative integer c, decide whether there're two integers a and b such that a2 + b2 = c.
    /// As we get only the integer, we should think of using binary search.
    func judgeSquareSum(_ c: Int) -> Bool {
        var first: Int = 0 // 0
        var second: Int = Int(sqrt(Double(c))) //

        while first < second {
            let sum = (first * first) + (second * second)
            if sum == c {
                return true
            } else if sum < c { // tricky
                first += 1
            } else {
                second -= 1 // tricky
            }
        }
        return false
    }

    func numRescueBoats(_ people: [Int], _ limit: Int) -> Int {

        let sortedPeople = people.sorted()
        var startIndex: Int = 0
        var endIndex: Int = people.count - 1
        var boats: Int = 0

        while startIndex <= endIndex {
            // if within the limit, then give one boat
            if sortedPeople[startIndex] + sortedPeople[endIndex] <= limit {
                startIndex += 1
            }
            endIndex -= 1 // if not give one boat for the right side people.
            boats += 1
        }
        return boats
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

    /// Flipping an Image
    ///
    /// Given an n x n binary matrix image, flip the image horizontally, then invert it, and return the resulting image.
    func flipAndInvertImage(_ image: [[Int]]) -> [[Int]] {

        var flipped = [[Int]]()

        func reverse(array: inout [Int]) {
            var startIndex: Int = 0
            var endIndex: Int = array.count - 1

            while startIndex <= endIndex {
                array.swapAt(startIndex, endIndex)
                startIndex += 1
                endIndex -= 1
            }
        }

        func flip(array: inout [Int]) {
            for i in 0..<array.count {
                let flipped = array[i] == 0 ? 1 : 0
                array[i] = flipped
            }
        }

        for (index, element) in image.enumerated() {
            var array = element
            reverse(array: &array)
            flip(array: &array)
            flipped.insert(array, at: index)
        }

        debugPrint("flipped: \(flipped)")
        return flipped
    }

     /// NOTE: This will work only for sorted array.
    /// The given array must be sorted like [-2, -1, 0, 1, 2, 3]
    /// So that we can travers with via start and end 
    func sortedSquares(_ A: [Int]) -> [Int] {
        var ret = [Int](repeating: 0, count: A.count)
        var startIndex = 0
        var endIndex = A.count - 1
        // By Keeping K as end of the array.
        var k = endIndex

        while startIndex <= endIndex {
            if abs(A[startIndex]) > abs(A[endIndex]) {
                ret[k] = A[startIndex] * A[startIndex]
                startIndex += 1
            } else {
                ret[k] = A[endIndex] * A[endIndex]
                endIndex -= 1
            }
            k -= 1
        }
        debugPrint("sorted square: \(ret)")
        return ret
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
                // Moving the start only if its even
                startIndex += 1
            } else {
                array.swapAt(startIndex, endIndex)
                endIndex -= 1
            }
        }
        return array
    }

    /// Sort Array By Parity II
    ///
    /// Given an array of integers nums, half of the integers in nums are odd, and the other half are even.
    /// Sort the array so that whenever nums[i] is odd, i is odd, and whenever nums[i] is even, i is even.
    ///
    /// Return any answer array that satisfies this condition.
    func sortArrayByParityII(_ nums: [Int]) -> [Int] {
        var array = nums
        var evenIndex = 0
        var oddIndex = 1

        /// Idea is going forward by assuming 0, and 1 as indeces
        /// Incrementing by 2 can give the next odd or even index 
        while evenIndex < array.count && oddIndex < array.count {
            if array[evenIndex] % 2 != 0 { // If even index contains an odd number
                if array[oddIndex] % 2 == 0 { // If odd index contains an even number
                    array.swapAt(evenIndex, oddIndex)
                    evenIndex += 2
                    oddIndex += 2
                } else {
                    // Move to the next odd index until it contains an even number
                    oddIndex += 2
                }
            } else {
                // Move to the next even index
                evenIndex += 2
            }
        }
        return array
    }

    func reversePrefix(_ word: String, _ ch: Character) -> String {

        func rotate(_ array: inout [Character], start: Int, end: Int) {
            var startIndex: Int = start
            var endIndex: Int = end

            while startIndex <= endIndex {
                array.swapAt(startIndex, endIndex)
                startIndex += 1
                endIndex -= 1
            }
        }

        var array: [Character] = Array(word)

        for (index, char) in array.enumerated() {
            if char == ch {
                rotate(&array, start: 0, end: index)
                break
            }
        }
        debugPrint("reverse prefix: \(String(array))")
        return String(array)
    }

    func reverseStr(_ s: String, _ k: Int) -> String {

        var array: [Character] = Array(s)
        let length: Int = array.count
        var startIndex: Int = 0

        func rotate(_ array: inout [Character], _ start: Int, _ end: Int) {
            var startIndex: Int = start
            var endIndex: Int = end

            while startIndex <= endIndex {
                array.swapAt(startIndex, endIndex)
                startIndex += 1
                endIndex -= 1
            }
        }

        /// K-1 is to adjust the index, and we are taking minmum as we are checking with total count too.
        while startIndex < length {
            let endIndex = min(startIndex + k - 1, length - 1) // should not exceed total as well
            rotate(&array, startIndex, endIndex)
            startIndex += (2 * k)
        }
        return String(array)
    }

    /// Minimum Length of String After Deleting Similar Ends
    ///
    /// https://leetcode.com/problems/minimum-length-of-string-after-deleting-similar-ends/description/
    func minimumLength(_ s: String) -> Int {

        let array: [Character] = Array(s)
        var startIndex: Int = 0
        var endIndex: Int = array.count - 1

        while startIndex < array.count {
            // Skip matching characters from the left
            while startIndex < array.count && array[startIndex] == array[startIndex + 1] {
                startIndex += 1
            }
            // Skip matching characters from the right
            while endIndex < array.count, array[endIndex] == array[endIndex - 1] {
                endIndex -= 1
            }
            // If characters at left and right pointers match, remove prefix and suffix
            if array[startIndex] == array[endIndex] {
                startIndex += 1
                endIndex -= 1
            } else {
                break //Imp: If characters don't match, exit loop
            }
        }
        return endIndex - startIndex + 1
    }

    /// String Compression
    ///
    /// OJ: https://leetcode.com/problems/string-compression/description/
    ///
    /// - seealso: Two pointers
    func compress(_ chars: inout [Character]) -> Int {
        var slow = 0 // Pointer to read original characters
        var fast = 0 // Pointer to write compressed characters

        while slow < chars.count {
            let currentChar = chars[slow]
            var nextIndex = slow + 1
            var count = 0

            // Count consecutive occurrences of the current character
            while nextIndex < chars.count, chars[nextIndex] == currentChar {
                count += 1
                nextIndex += 1
            }

            // Write the current character
            chars[fast] = currentChar
            fast += 1

            // Write the count if greater than 1
            if count > 0 {
                chars[fast] = Character(String(count + 1))
                fast += 1
            }
            // Move to the next character
            slow = nextIndex
            debugPrint("char \(String(chars))")
        }
        return fast
    }

    /// Remove Duplicates from Sorted Array
    ///
    /// OJ: https://leetcode.com/problems/remove-duplicates-from-sorted-array/description/
    ///
    /// Using slow and fast for removing duplicates
    /// Collecting non duplicates items in the front
    /// given array must be sorted
    /// [0,0,1,1,1,2,2,3,3,4]
    func removeDuplicates(_ array: inout [Int]) -> Int {
        if array.isEmpty { return 0 } // Handle edge case

        var slow = 0
        var fast = 1

        while fast < array.count {
            if array[fast] != array[slow] {
                slow += 1
                array[slow] = array[fast]
            }
            fast += 1
        }

        // The unique elements are from index 0 to slow (inclusive)
        return slow + 1
    }

    func duplicateZeros(_ arr: inout [Int]) {

        var start: Int = 0

        while start < arr.count {
            let element = arr[start]
            if element == 0 {
                arr.removeLast()
                arr[start+1] = 0
                start += 1
            }
            start += 1
        }
    }

    // Subarray, subsequence, substring 
}
