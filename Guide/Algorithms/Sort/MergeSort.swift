//
//  MergeSort.swift
//  Algorithms
//
//  Created by Karthik on 12/2/20.
//

import Foundation

//class MergeSort {
//	
//	var unsortedArray: [Int] = []
//	init(_ array: [Int]) {
//		self.unsortedArray = array
//	}
//	// Divide = Chunk
//	// combine = merge
//	func divide(_ array: [Int]) -> ([Int], [Int]) {
//		let startIndex = 0
//		let endIndex = array.count-1
//		let middleIndex = (startIndex+endIndex)/2
//		return (Array(array[startIndex..<middleIndex]), Array(array[middleIndex..<endIndex]))
//	}
//	
//	func TwoWayMerging(_ firstArray: [Int], _ secondArray: [Int]) -> [Int] {
//		var i: Int = 0
//        var j: Int = 0
//
//		let firstEndIndex: Int = firstArray.count - 1
//		let secondEndIndex: Int = secondArray.count - 1
//		var thirdArray: [Int] = []
//		
//		while i <= firstEndIndex && j <= secondEndIndex {
//			if firstArray[i] < secondArray[j] {
//				thirdArray.append(firstArray[i])
//				i += 1
//			} else {
//				thirdArray.append(secondArray[j])
//				j += 1
//			}
//		}
//		
//		// there will be some remaining
//		while i <= firstEndIndex {
//			thirdArray.append(firstArray[i])
//			i += 1
//		}
//		
//		while j <= secondEndIndex {
//			thirdArray.append(secondArray[j])
//			j += 1
//		}
//		return thirdArray
//	}
//	
//	func mergeSort(_ array: [Int]) -> [Int] {
//		guard array.count > 1 else { return array } // Base case
//		let (first, second) = divide(array)
//		return TwoWayMerging(mergeSort(first), mergeSort(second))
//	}
//}

class InPlaceMergeSort {
	
	func mergeSort(input: inout [Int], startIndex: Int, endIndex: Int) {
        /// BaseCondition
		guard startIndex < endIndex else { return }
		let middleIndex = (endIndex + startIndex) / 2
		mergeSort(input: &input, startIndex: startIndex, endIndex: middleIndex) // first half sorting
		mergeSort(input: &input, startIndex: middleIndex+1, endIndex: endIndex) // second half sorting
		merge(array: &input, startIndex: startIndex, middleIndex: middleIndex, endIndex: endIndex)
	}
	
	private func merge(array: inout [Int], startIndex: Int, middleIndex: Int, endIndex: Int) {
		let first = Array(array[startIndex...middleIndex])
		let second = Array(array[middleIndex+1...endIndex])
		print("\(first) - \(second)")

		var i = 0
        var j = 0
        var k = startIndex // This cannot be zero

        while i < first.count && j < second.count {
			if first[i] < second[j] {
				array[k] = first[i]
				i += 1
			} else {
				array[k] = second[j]
				j += 1
			}
			k += 1
		}
		
        while i < first.count {
			array[k] = first[i]
			k += 1
			i += 1
		}
		
        while j < second.count {
			array[k] = second[j]
			k += 1
			j += 1
		}
	}
}

class MergeSort { 

    func mergeSort(_ array: [Int]) -> [Int] {

        func _divide(_ array: [Int]) -> (first: [Int], second: [Int]) {
            let startIndex: Int = 0
            let endIndex: Int = array.count - 1
            let middleIndex: Int = (endIndex+startIndex) / 2 // Imp
            return (Array(array[startIndex..<middleIndex]), Array(array[middleIndex...endIndex]))
        }

        func _merge(_ first: [Int], _ second: [Int]) -> [Int] {
            var sortedArray = [Int]() // New Array
            var i: Int = 0
            var j: Int = 0

            while i < first.count && j < second.count {
                if first[i] < second[j] {
                    sortedArray.insert(first[i], at: i)
                    i += 1
                } else {
                    sortedArray.insert(second[j], at: j)
                    j += 1
                }
            }

            while i < first.count {
                sortedArray.insert(first[i], at: i)
                i += 1
            }

            while j < second.count {
                sortedArray.insert(second[j], at: j)
                j += 1
            }

            return sortedArray
        }

        func _mergeSort(_ array: [Int]) -> [Int] {
            /// BaseCondition
            guard array.count > 1 else { return array }
            let (first, second) = _divide(array)
            return _merge(_mergeSort(first), _mergeSort(second))

        }
        return _mergeSort(array)
    }
}
