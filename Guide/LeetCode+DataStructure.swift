//
//  LeetCode.swift
//  Algorithms
//
//  Created by Karthik on 12/9/20.
//

import Foundation


class LeetCodeDataStructure {
	
//	Using Bubble Sort
//	func sortedSquares(_ nums: [Int]) -> [Int] {
//		var resultArray: [Int] = []
//		for i in 0..<nums.count {
//			resultArray.append(nums[i]*nums[i])
//		}
//		for i in 1..<resultArray.count {
//			let value = resultArray[i]
//			var index = i
//			while index > 0 && resultArray[index-1] > value {
//				resultArray[index] = resultArray[index-1]
//				index -= 1
//			}
//			resultArray[index] = value
//		}
//		return resultArray
//	}

	// Given an array nums of integers, return how many of them contain an even number of digits.
	func findNumbers(_ nums: [Int]) -> Int {
		guard nums.count != 0 else { return 0 }
		var evens: Int = 0
		for num in nums {
			var digits: Int = num/10
			var counter: Int = 1
			while digits != 0 {
				digits = digits/10
				counter += 1
			}
			if counter % 2 == 0 {
				evens += 1
			}
		}
		return evens
	}
	
	// Write a function that takes in an unsorted array of integers and returns the longest range or longest consecutive sequence.
	// [100, 4, 200, 1, 3, 2]
	func findLongestRange(in array: [Int]) -> String {
		
		guard array.count > 1 else {
			return "No Sequence Found"
		}
		
		var numbersDic = [Int: Bool]()
		
		var longestSequence = 0
		var recordInitialNumber = 0
		var recordLastNumber = 0
		
		// Adding the numbers as keys with Bool as the value in the dictionary
		for n in array {
			numbersDic[n] = false
		}
		
		for n in array {
			
			if let number = numbersDic[n], number {
				continue
			}
			
			var previousVal = n - 1
			var nextVal = n + 1
			numbersDic[n] = true
			
			while numbersDic[previousVal] != nil {
				numbersDic[previousVal] = true
				previousVal = previousVal - 1
			}
			
			//Checking if a next value is available
			while numbersDic[nextVal] != nil {
				numbersDic[nextVal] = true
				nextVal = nextVal + 1
			}
			
			let difference =  (nextVal - 1) - (previousVal + 1)
			
			if (difference > longestSequence) {
				longestSequence = difference
				recordInitialNumber = previousVal + 1
				recordLastNumber = nextVal - 1
			}
		}
		
		return "The longest sequence starts at \(recordInitialNumber) and ends at  \(recordLastNumber)"
	}
}
