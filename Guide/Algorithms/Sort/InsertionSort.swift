//
//  InsertionSort.swift
//  Algorithms
//
//  Created by Karthik on 12/2/20.
//

import Foundation

/*
TimeComplexty:
Best: nlogn
Avg: n2
worst: n2

Space Complexity:
O(1)

Method: Partitioning
Taking the first index, comparing with previous elements of an array.
if previous element is big, then swaing the index.

Forward Sorting:
on forward sorting, we take 0th element and tries to compare with other element in forward direction
so swapping can be done in bw 0th index to endIndex
once swapping done, index will be incremented

Backward Sorting:
on backward sorting, we take 1st index element, and tries to compare with previous element for soring.
so swapping can be done, if index > 0 and previous value greater than the value.
once swapping done, index will be decremented

RealLife Example:
1. Pile of cards. take one and insert into the correct position
2. Dress hanger, sort by the correct size order
*/

/// Reference: https://medium.com/@karthikmk/swift-ads-insertion-sort-f002197014b5
///
class InsertionSort {

	func sort(array: inout [Int]) -> [Int] {
		guard array.count > 1 else { return array }

        for i in 1..<array.count {
            let current = array[i]
            var j = i
            // if previous is greater, then swap
            while j > 0 && array[j-1] > current {
                array.swapAt(j, j-1)
                j -= 1
            }
            // Insert the current element at the correct position
            array[j] = current
        }

        return array
	}
}
