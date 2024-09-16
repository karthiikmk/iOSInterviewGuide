//
//  LeetCode.swift
//  Algorithms
//
//  Created by Karthik on 20/03/24.
//

import Foundation

class LeetCode {

    func run() {        
        lengthOfLongestConsecutiveSubstring()
        doBasics()
    }

    func doBasics() {
        var array = [1,2,3,4]
        var startIndex = 0
        var endIndex = array.count - 1

        var result = [Int]()
        while startIndex <= endIndex {
            let index = endIndex - startIndex // reverse
            result.append(array[index])
            startIndex += 1
        }
        print("result: \(result)")
    }

    /// - NOTE: To complete this, need to understand how modulo and division works.
    /// Modulo returns remainder, whereas division returns the quotient.
    ///
    /// In each iteration, extract the last digit of the number using the modulo operator %.
    /// Append the extracted digit to the result variable by multiplying result by 10 and adding the digit.
    /// Update the number by removing the last digit using integer division /.
    func reverse(_ x: Int) -> Int {
        var number = x // 321 // 32 // 3
        var result: Int = 0 // 123

        while number != 0 {
            let digit = number % 10 // 321 % 10 = 1 // 32 % 10 = 2 // 3 % 10 = 3
            result = result * 10 + digit // 0 * 10 + 1 = 1 // 1 * 10 + 2 = 12 // 12 * 10 + 3 //
            number /= 10 // 321 / 10 = 32 // 32 / 10 = 3 // 3 /10 = 0
        }
        return result
    }

    /// - NOTE: Palindrome isa word, phrase, or a number which reads the same in backwords as forword.
    /// Eg 75257, 1234321
    ///
    /// Given an integer x, return true if x is a palindrome , and false otherwise.
    ///
    /// Idea, same as array rotation, we gonna increment from left side and decrement from right side.
    func isPalindrome(_ x: Int) -> Bool {
        let array = Array(String(x))
        var start = 0
        var end = array.count - 1

        while start < end {
            if array[start] != array[end] {
                return false
            }
            start += 1
            end -= 1
        }
        return true
    }
}

/// - NOTE: Miscellenous
extension LeetCode {

    func isPrime(_ number: Int) -> Bool {

        // 1 is not prime
        if number <= 1 { return false  }
        // 2 is prime
        if number == 2 { return true  }
        // even numbers are not prime numbers
        if number % 2 == 0 { return false }

        let squareRoot = Int(Double(number).squareRoot())
        /// for number, divisor come in pairs
        /// Eg 36, the pair is (1, 36)
        /// (2, 18) (3, 12) etc
        /// if we notice that the first element of each pair is always lesser than or equal to the squareroot of that number
        /// so if a number has a larger divisor, its pairs is always lesser than or equal to its square root
        ///
        /// by 2: Any even number which is greater than 2 is divisable by 2, so it cant be prime number
        /// so to check only the odd divisors we are striding by 2
        for divisor in stride(from: 3, through: squareRoot, by: 2) {
            if number % divisor == 0 {
                return false
            }
        }
        return true
    }

    // Converting Int to String,
    // then creating whole number from string wholeNumberValue.
    // then reducing that array into single Int
    func addTwoDigits(n: Int) -> Int {
        return String(n)
            .compactMap { $0.wholeNumberValue }
            .reduce(0) { $0 + $1 } // Summing whole array indices
    }

    /// - seealso: bitwise operator
    func singleNumber(_ nums: [Int]) -> Int {
        var result: Int = 0
        for num in nums {
            result ^= num
        }
        return result
    }
}
