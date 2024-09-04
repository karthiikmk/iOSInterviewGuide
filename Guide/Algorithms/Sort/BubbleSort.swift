//
//  BubbleSort.swift
//  Algorithms
//
//  Created by Karthik on 12/2/20.
//

import Foundation

class BubbleSort {

    /// Bubble Sort is a simple sorting algorithm that repeatedly steps through the list, compares adjacent (next) elements, 
    /// and swaps them if they are in the wrong order. The pass through the list is repeated until the list is sorted.
    func sort(array: inout [Int]) {
        let length = array.count

        /// we always need next element to make a comparisiion.
        for i in 0..<length {
			for j in 0..<length-i-1 {
				if array[j] > array[j+1] {
                    array.swapAt(j, j+1)
				}
			}
		}
	}
}
