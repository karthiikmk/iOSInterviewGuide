//
//  HackerRank+DataStructure.swift
//  Algorithms
//
//  Created by Karthik on 12/7/20.
//

import Foundation

class HackerRankDataStructure {

	// Complete the hourglassSum function below.
	func hourglassSum(arr: [[Int]]) -> Int {
		var sum: [Int] = []
		// iterating 4 times, since we need 3 elements in an array.
		// in 6 x 6 matrix, 4th array contains 5 and last. so we should use only 4 iteration.
		// it applies for both rows and colomns
		for r in 0..<arr.count-2 {
			for c in 0..<arr.count-2 {
				let value = arr[r][c]+arr[r][c+1]+arr[r][c+2]+arr[r+1][c+1]+arr[r+2][c]+arr[r+2][c+1]+arr[r+2][c+2]
				sum.append(value)
			}
		}
		return sum.max() ?? 0
	}
			
	/*
	* Complete the 'dynamicArray' function below.
	*
	* The function is expected to return an INTEGER_ARRAY.
	* The function accepts following parameters:
	*  1. INTEGER n
	*  2. 2D_INTEGER_ARRAY queries
	*/
	func dynamicArray(n: Int, queries: [[Int]]) -> [Int] {
		
		var sequences: [[Int]] = Array(repeating: [], count: n)
		var lastAnswer = 0
		var answers = [Int]()
		for query in queries {
			let (queryType, x, y) = (query[0], query[1], query[2])
			switch queryType {
				case 1:
					let seq = (x ^ lastAnswer) % n
					sequences[seq].append(y)
				case 2:
					let seq = (x ^ lastAnswer) % n
					let index = y % sequences[seq].count
					lastAnswer = sequences[seq][index]
					print(lastAnswer)
					answers.append(lastAnswer)
				default:
					fatalError("Bad query type")
			}
		}
		return answers
	}
	
	// let queries = ["abcede", "sdaklfj", "asdjf", "na", "basdn"]
	// let string = ["abcde", "sdaklfj", "asdjf", "na", "basdn"]
	func matchingStrings(strings: [String], queries: [String]) -> [Int] {
		var result: [Int] = []
		for query in queries {
			let count = strings.filter{ $0 == query }.count
			result.append(count)
		}
        
        // let result = queries.map { query in strings.filter { $0 == query }.count }        
		return result
	}
	
	//	let queries = [[1, 2, 100], [2, 5, 100], [3, 4, 100]]
	//	print(arrayManipulation(n: 10, queries: queries))
	func arrayManipulation(n: Int, queries: [[Int]]) -> Int {
		var array: [Int] = Array(repeating: 0, count: n+1)
		for query in queries {
			let (a, b, k) = (query[0]-1, query[1], query[2])
			array[a] += k
			array[b] -= k
			print(array, terminator: "\n")
		}
		// prefix sum
		var maxValue: Int = 0
		var running: Int = 0
		for i in array {
			running += i
			maxValue = max(running, maxValue)
		}
		return maxValue
	}
}
