//
//  LeetCode.swift
//  Algorithms
//
//  Created by Karthik on 20/03/24.
//

import Foundation

class LeetCode {

    func run() {
        // brushUp()
    }
    
    /// NOTE: Before learning about ALDS, do this brushups
    /// Stack - LIFO
    /// Queue - FIFO
    /// To sort an array, we need atleast 2 elements, which means count > 1
    /// How to find out subarrays in array 
    func brushUp() {
        intBasics()
        stringBasics()
    }
    
    private func intBasics() {
        let number = 123
        let numberToString = String(number)
        print("Number to string \(numberToString)")
        
        let numberToStringArray = Array(String(number))
        print("Number to string array \(numberToStringArray)")
        
        let numberToIntArray = String(number).compactMap(\.wholeNumberValue)
        print("Number to int array \(numberToIntArray)")
        
        let digitsInNumber = String(number).count
        print("Digits in number: \(digitsInNumber)")
        
        let isEvenNumber = number % 2 == 0
        print("isEven: \(isEvenNumber)")
        
        let addNumbersInArray = numberToIntArray.reduce(0) { $0 + $1 }
        print("Add numbers in array: \(addNumbersInArray)")
    }
    
    private func stringBasics() {
        
        let string = "Hello"
        /// String can be iterated directly
        for char in string { print("char: \(char)") }
        /// Enumurated gives both index and value
        for (index, char) in string.enumerated() { print("index: \(index) - char: \(char)") }
        
        let numberString = "123"
        let stringToInt = Int(numberString) ?? -1
        print("String to int: \(stringToInt)")
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
    
    /// [123,1,1234, 22]
    func findEvenDigitNumbers(_ nums: [Int]) -> [Int] {
        /// Iterate linear linly
        /// find isEven, then update the result
        var result = [Int]()
        var start = 0
        
        while start < nums.count {
            /// Logical implmentation
            let number = nums[start]
            let count = String(number).count
            if count % 2 == 0 {
                result.append(number)
            }
            ///
            start += 1
        }
        return result
    }

    // Converting Int to String,
    // then creating whole number from string wholeNumberValue.
    // then reducing that array into single Int
    func addTwoDigits(n: Int) -> Int {
        return String(n)
            .compactMap { $0.wholeNumberValue }
            .reduce(0) { $0 + $1 } // Summing whole array indices
    }
}
