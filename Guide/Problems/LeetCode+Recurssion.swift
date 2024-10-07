//
//  LeetCode+Fib.swift
//  Algorithms
//
//  Created by Karthik on 24/03/24.
//

import Foundation

extension LeetCode {
    
    func runRecurrsion() {
        // permutations(of: "123")
        // permutations(for: [1,2,3])
        nextPermutationUsingBruteForce(of: 123)
    }
}

extension LeetCode {

    ///  Find the fibonacci value for the given number.
    ///
    /// The Fibonacci sequence is a series of numbers where each number is the sum of the two preceding ones, usually starting with 0 and 1.<##>
    /// The given fib is a excessive recursion. Draw the tree for the given number so that we can understant that the fib is excessively called
    /// for same number in multiple places.
    ///
    /// factorial eg: 0, 1, 1, 2, 3, 5, 8, 13
    /// - complexity: O(2^n)
    func fib(_ position: Int) -> Int {
        // BaseCase
        if position == 0 || position == 1 {
            return position
        }
        return fib(position - 2) + fib(position - 1) // order is important here.
    }

    /// excessive fibonacci can be improved by caching the result of the fib
    ///
    func fibUsingMemoization(_ position: Int) -> Int {
        var cache = Array(repeating: -1, count: position + 1)

        func fib(_ position: Int) -> Int {
            if position == 0 || position == 1 {
                return position
            }
            // check the cache
            if cache[position] != -1 {
                return cache[position]
            }
            let fib = fib(position - 2) + fib(position - 1)
            cache[position] = fib
            return fib
        }
        return fib(position)
    }

    /// - complexity:: O(n)
    func climbStairs(_ n: Int) -> Int {
        // Base cases: 0 ways to climb 0 or 1 step, 1 way to climb 2 steps
        if n == 0 || n == 1 || n == 2 { return n } // ** important.
        return climbStairs(n - 2) + climbStairs(n - 1)
    }

    /// sum(n) = 1 + 2 + 3 + ... + n
    /// sum(n) = sum(n-1)+n
    /// Addition should be done on returning time, not on exuction time.
    /// - complexity:: O(n)
    func sum(for number: Int) -> Int {
        guard number > 0 else { return 0 }
        return sum(for: number-1) + number // order is very important here.
    }

    /// Factorial is based upon mulitplication
    ///
    /// factorial of 0 or 1 is 1
    /// fact(n) = 1 * 2 * 3 * ... * n
    /// fact(n) = fact(n-1) * n
    /// mulitiplication should be done on returning time, not on exuction time.
    /// The product of all positive intergers less than or equal to a given positive integer.
    /// - complexity:: O(n), space: O(n)
    func factorial(of number: Int) -> Int {
        /// BaseCondtion
        guard number > 0 else { return 1 } // as it multiplication, should not return 0
        return factorial(of: number - 1) * number // order is very important here.
    }

    /// pow(m, n) = m * m * m * ... * n times
    /// pow(m, n) = pow(m, n-1) * m
    func power(of m: Int, n: Int) -> Int {
        guard n > 0 else { return 1 } // as its multiplication, should not return 0
        return power(of: m, n: n - 1) * m // order is improtant here.
    }

    /// Even power = 2^8 = (2 * 2)^(n/2)
    /// Odd power = 2^9 = 2 * power(2 * 2)^(n-1/2)
    func powerMethod2(of m: Int, n: Int) -> Int {
        if n == 0 {
            return 1
        }
        if n % 2 == 0 { // is even power
            return powerMethod2(of: (m * m), n: n / 2)
        } else {
            return m * powerMethod2(of: m * m, n: (n - 1) / 2)
        }
    }
}

extension LeetCode {

    /// Tower of Hanoi
    ///
    /// Understand the idea behind this first before reading code.
    ///  Condition 1: Only one disk can be moved at a time
    ///  Condition 2: No larger disk can be placed on top of smaller disk
    ///
    /// Time complexity calculation = (1+2+2^2+2^3+....2^n) - 1
    /// - complexity: O(2^n)
    func TOH(n: Int, a: Int, b: Int, c: Int) {
        // BaseCondition
        guard n > 0 else { return }
        TOH(n: n - 1, a: a, b: c, c: b) // Moving a -> b using c
        debugPrint("(\(a) -> \(c))", terminator: ",")
        TOH(n: n - 1, a: b, b: a, c: c) // Moving b -> c using a
    }
}

// - MARK: Permutation
extension LeetCode {
    
    /// NOTE: In general for n elements, the number of permutations is n! (factorial of n)
    /// Eg: [1,2,3], the perumation is 6
    @discardableResult
    func permutations(for array: [Int]) -> [Int] {
        
        var result = [Int]()
        var arr = array
        
        func permute(_ startIndex: Int) {
            /// Collect the permutation
            if startIndex == arr.count {
                result.append(arr.toInt())
                return
            }
            
            for index in startIndex..<arr.count {
                arr.swapAt(startIndex, index)
                permute(startIndex + 1)
                arr.swapAt(startIndex, index) // resetting the org position
            }
        }
        permute(0)
        print("Permuation: \(result)")
        return result
    }
        
    /// Find all permutations of a string.
    ///
    /// Number of ways in which the string can be arrianged
    /// Learnign about how permutation works
    /// - seealso: recurssion
    func permutations(of string: String) -> [String] {
        
        var result = [String]()
        var array = Array(string)
        
        /// - NOTE: We are not iterating each char in the array, rather iteration the while string n tiems.
        func permute(_ startIndex: Int) {
            // Basecondtion, which reaching the leaf
            if startIndex == array.count {
                result.append(String(array))
                return
            }
            for index in startIndex..<array.count  {
                array.swapAt(startIndex, index) // actual swapping
                permute(startIndex + 1)
                array.swapAt(startIndex, index) // resettign back to orignal
            }
        }
        permute(0)
        print("String permuatation: \(result)")
        return result
    }
    
    /// Brute force approace
    ///  - Find out all the permuation, among which find the smallest one which is larger than the given
    func nextPermutationUsingBruteForce(of number: Int) -> String {
        let array = number.toArray()
        let permuations = permutations(for: array)
        var result = Int.max
        
        for permutation in permuations {
            if permutation > number && permutation < result {
                result = permutation
            }
        }
        print("Next permuation using brute force: \(String(result))")
        return String(result)
    }
    
    // We start by finding the rightmost pair of digits where the first digit is smaller than the second.
    // This is because the digits on the right side of the number are in descending order, which is the largest possible arrangement for those digits.
    // Therefore, the first point where a smaller digit is followed by a larger digit is the first place where we can make the number larger.
    /// Idea is to have `pivotIndex` and `successorIndex`
    func nextPermuation(of number: Int) -> String {
        var array = Array(String(number))
        
        /// Find the pivotIndex
        var pivotIndex = array.count - 2 // this is very important 
        while pivotIndex >= 0 && array[pivotIndex] >= array[pivotIndex+1] {
            pivotIndex -= 1
        }
        // Here pivot value is lesser than the next index value
        if pivotIndex == -1 {
            return "not possible"
        }
        /// Find the smallest number from right side where its larger than the pivot
        /// As right side already in descending, find the first one from right side should work.
        var successorIndex = array.count - 1
        while successorIndex > pivotIndex && array[successorIndex] <= array[pivotIndex] {
            successorIndex -= 1
        }
        /// Swap
        array.swapAt(pivotIndex, successorIndex)
        /// Sort
        let left = array[0...pivotIndex]
        let right = array[(pivotIndex+1)...].sorted() // Asc sort inorder to create next smallest number.
        
        let nextNumber = String(left + right)
        print("Next permuation: \(nextNumber)")
        return nextNumber
    }
}
