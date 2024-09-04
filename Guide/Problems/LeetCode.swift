//
//  LeetCode.swift
//  Algorithms
//
//  Created by Karthik on 20/03/24.
//

import Foundation

class LeetCode {

    /// - NOTE: To complete this, need to understand how modulo and division works.
    /// Modulo returns remainder, whereas division returns the quotient.
    ///
    /// In each iteration, extract the last digit of the number using the modulo operator %.
    /// Append the extracted digit to the result variable by multiplying result by 10 and adding the digit.
    /// Update the number by removing the last digit using integer division /.
    func reverse(_ x: Int) -> Int {
        var number = x
        var result: Int = 0

        while number != 0 {
            let digit = number % 10 // 123 % 10 = 3
            result = result * 10 + digit // 0 * 10 + 3 = 3
            number /= 10 // 123 / 10 = 12 - preparing for next iteration
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

    /// A prime number is a natural number greater than 1 that has no positive divisors other than 1 and itself.
    func isPrime(_ number: Int) -> Bool {
        // 1 is not a prime number
        guard number > 1 else { return false }

        // Handle 2 separately since it's the only even prime number
        if number == 2 {
            return true
        }

        // Check if the number is even
        if number % 2 == 0 {
            return false
        }

        // Check for divisibility by odd numbers starting from 3 up to the square root of the number
        let sqrtNumber = Int(sqrt(Double(number)))
        for divisor in stride(from: 3, through: sqrtNumber, by: 2) {
            if number % divisor == 0 {
                return false
            }
        }

        // If no divisors were found, the number is prime
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
