//
//  Leetcode+TwoPointers.swift
//  Algorithms
//
//  Created by Karthik on 24/03/24.
//

import Foundation

extension LeetCode {

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

    /// Minimum Length of String After Deleting Similar Ends
    ///
    /// https://leetcode.com/problems/minimum-length-of-string-after-deleting-similar-ends/description/
    func minimumLength(_ s: String) -> Int {

        let array: [Character] = Array(s)
        var startIndex: Int = 0
        var endIndex: Int = array.count - 1

        while startIndex < array.count {
            // Skip matching characters from the left
            // Need to make sure the index is there. eg for array with only one element.
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
}
