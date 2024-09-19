//
//  Leetcode+Sort.swift
//  iOSInterviewGuide
//
//  Created by Karthik on 19/09/24.
//

import Foundation

/*
 BubbleSort: Forward sorting - lookign for the next value and swap if its lesser
 InsertSort: Backward sorting - pick a card, check with previous values, find a right place and insert it
 QuickSort - Partition sort - Find a pivot, move all smaller to the left of the pivot and biggers to the right of the pivot
 MergeSort - Divide, Sort, And Merge togeather
*/

extension LeetCode {
    
    func runSort() {
        
    }
}

// - MARK: Bubble Sort
extension LeetCode {
    
    /// NOTE: Bubble sort repeatedly compares adjacent elements in the array.
    /// If the current element is larger than the next one, they are swapped.
    /// After each full pass through the array, the largest unsorted element “bubbles” to the correct position. (**)
    /// Eg: [5, 1, 4, 2, 8]:
    func bubbleSort(_ array: [Int]) -> [Int] {
        var result = array
        var swapped: Bool
        
        for i in 0..<result.count {
            swapped = false
            /// After each pass, the largest unsorted element will be placed at the correct position.
            /// Subtracting -i, as we got the largest number sorted at the last.
            /// Subtracting -1 , for next number comparision
            for j in 0..<result.count-i-1 { /// ***
                if result[j] > result[j+1] {
                    /// Swap if the current element is greater than the next one
                    result.swapAt(j, j+1)
                    swapped = true
                }
            }
            /// NOTE: Optimization (exit early)
            /// If there is no swap, then the array is already sorted.
            if !swapped {
                break
            }
        }
        print("BubbleSort: \(result)")
        return result
    }
}

// - MARK: Insertion Sort
extension LeetCode {
    
    /// NOTE: Take each item and insert it into its proper position among the previously sorted items.
    /// Idea: How playing card works, we sort by picking and inserting it into the right poisition
    /// Eg: [12, 11, 13, 5, 6]
    ///
    /// RealLife Example:
    /// 1. Pile of cards. take one and insert into the correct position
    /// 2. Dress hanger, sort by the correct size order
    ///
    /// Method: Partitioning
    /// Taking the first index, comparing with previous elements of an array.
    /// if previous element is big, then moving it one index ahead.
    ///
    /// TimeComplexty: Best: nlogn, Avg: n2, worst, n2
    /// Space Complexity: O(1)
    func insertionSort(_ arr: [Int]) -> [Int] {
        var array: [Int] = arr
        for i in 1..<array.count {
            let current = array[i]
            var j = i-1 // looking into previous cars
            /// Move elements of array[0...i-1] that are greater than current to one position ahead
            while j >= 0 && array[j] > current {
                array[j+1] = array[j]
                j -= 1
            }
            array[j+1] = current
        }
        return array
    }
}

// - MARK: Quick Sort
extension LeetCode {
    
    /// Quick Sort is a highly efficient sorting algorithm that uses the divide and conquer strategy to sort an array.
    /// It selects a “pivot” element, partitions the array around the pivot, and recursively sorts the subarrays.
    func quickSort(_ array: [Int]) -> [Int] {
        /// BaseCondition
        /// Array needs to have 2+ elements to sort
        guard array.count > 1 else { return array }
        
        /// Pivot (middle index as pivot)
        let pivotIndex = array.count/2
        let pivot = array[pivotIndex]
        let left = array.filter { $0 < pivot }
        let middle = array.filter { $0 == pivot } // No need of recurrsion
        let right = array.filter { $0 > pivot }
        
        return quickSort(left) + middle + quickSort(right)
    }
    
    /// This partition function serves as a fundamental step in the quicksort algorithm. It is designed to partition an array segment by selecting the first element as the pivot.
    /// The partition function operates by arranging all elements that are lesser or equal to the pivot on the left side,
    /// and all elements greater than the pivot on the right side. This ensures that after partitioning, the pivot element is in its final sorted position within the array.
    /// It's important to understand the mechanics of this partitioning process, as it forms the core logic of the quicksort algorithm and significantly influences its overall efficiency.
    /// Eg: [7, 6, 10, 5, 9, 2, 1, 15,
    /// Reference: https://www.youtube.com/watch?v=QN9hnmAgmOc&t=1019s
    func quickSortUsingPartition(_ array: inout [Int]) -> [Int] {
        
        func partition(_ array: inout [Int], _ start: Int, _ end: Int) -> Int {
            let pivotIndex = start
            let pivot = array[pivotIndex]
            
            var startIndex = start
            var endIndex = end
            
            while startIndex < endIndex {
                /// Valid index check is very important, <= is important here.
                while startIndex <= end && array[startIndex] <= pivot {
                    startIndex += 1
                }
                /// valid index check is very important
                while endIndex >= start && array[endIndex] > pivot {
                    endIndex -= 1
                }
                if startIndex < endIndex {
                    array.swapAt(startIndex, endIndex)
                }
            }
            /// Final swap, this can give right partition
            array.swapAt(pivotIndex, endIndex)
            return endIndex
        }
        /// Recurssion
        func quickSort(array: inout [Int], startIndex: Int, endIndex: Int) {
            guard startIndex < endIndex else { return } // BaseCondition
            let pivotIndex = partition(&array, startIndex, endIndex)
            quickSort(array: &array, startIndex: startIndex, endIndex: pivotIndex - 1)
            quickSort(array: &array, startIndex: pivotIndex + 1, endIndex: endIndex)
        }
        ///
        quickSort(array: &array, startIndex: 0, endIndex: array.count - 1)
        return array
    }

}

// - MARK: Merge Sort
extension LeetCode {
 
    func mergeSort(_ array: inout [Int]) {

        /// NOTE: Think in two array perspective 
        func merge(_ array: inout [Int], startIndex: Int, middleIndex: Int, endIndex: Int) {
            let left = Array(array[startIndex...middleIndex])
            let right = Array(array[middleIndex+1...endIndex])
            
            var i = 0
            var j = 0 // we aren't coming backwards.
            var k = startIndex // tracking the write index
            
            while i < left.count && j < right.count {
                if left[i] < right[j] {
                    array[k] = left[i]
                    i += 1
                } else {
                    array[k] = right[j]
                    j += 1
                }
                k += 1
            }
            // Remaining items on left array
            while i < left.count {
                array[k] = array[i]
                i += 1
                k += 1
            }
            // Remaining items on right array
            while j < right.count {
                array[k] = right[j]
                j += 1
                k += 1
            }
        }
        
        func sort(_ array: inout [Int], startIndex: Int, endIndex: Int) {
            guard startIndex < endIndex else { return } // Basecondition
            // divide
            let middleIndex = startIndex + (endIndex - startIndex) / 2
            sort(&array, startIndex: startIndex, endIndex: middleIndex)
            sort(&array, startIndex: middleIndex + 1, endIndex: endIndex)
            // Merge
            merge(&array, startIndex: startIndex, middleIndex: middleIndex, endIndex: endIndex)
        }
                
        sort(&array, startIndex: 0, endIndex: array.count-1)
    }
}
