//
//  QuickSort.swift
//  Algorithms
//
//  Created by Karthik on 12/2/20.
//

import Foundation

/// Inplace quicksort
///
/// Reference: https://www.youtube.com/watch?v=QN9hnmAgmOc&t=1019s
///
/// Eg: [7, 6, 10, 5, 9, 2, 1, 15, 7]
class InPlaceQuickSort {

    var array: [Int]

    init(array: [Int]) {
        self.array = array
    }

    /// This partition function serves as a fundamental step in the quicksort algorithm. It is designed to partition an array segment by selecting the first element as the pivot.
    ///
    /// The partition function operates by arranging all elements that are lesser or equal to the pivot on the left side, and all elements greater than the pivot on the right side. This ensures that after partitioning, the pivot element is in its final sorted position within the array.
    ///
    /// It's important to understand the mechanics of this partitioning process, as it forms the core logic of the quicksort algorithm and significantly influences its overall efficiency.
    func partition(_ low: Int, _ high: Int) -> Int {

        let pivot = array[low] // 1
        var left = low
        var right = high

        while left < right {
            /// Valid index check is very important, <= is important here.
            while left <= high && array[left] <= pivot { // 2
                left += 1
            }
            /// valid index check is very important
            while right >= low && array[right] > pivot {
                right -= 1
            }
            if left < right {
                array.swapAt(left, right)
            }
        }
        /// Final swap, this can give right partition
        array.swapAt(low, right) // 3
        return right
    }

    func quickSort(startIndex: Int, endIndex: Int) {
        guard startIndex < endIndex else { return }
        let pivotIndex = partition(startIndex, endIndex)
        quickSort(startIndex: startIndex, endIndex: pivotIndex-1) // 4 (pivotIndex-1)
        quickSort(startIndex: pivotIndex + 1, endIndex: endIndex) // 5
    }

    func sort() {
        quickSort(startIndex: 0, endIndex: array.count-1)
        debugPrint("sorted array \(array)")
    }
}

/// - NOTE: Sort an array from low to high (or high to low).
///
/// Array splits it up into three parts based on a "pivot" variable.
/// Here, the pivot is taken to be the element in the middle of the array
///
/// All the elements less than the pivot go into a new array called less.
/// All the elements equal to the pivot go into the equal array.
/// All elements greater than the pivot go into the third array, greater
///
/// Three arrays, recursively sorts the less array and the right array,
/// then glues those sorted subarrays back together with the equal array to get the final result
///
/// Reference: https://medium.com/swlh/sorting-algorithms-implementing-quick-sort-using-swift-457a4dbb1bba
/// Reference: https://victorqi.gitbooks.io/swift-algorithm/content/quicksort.html
///
class RawQuickSort {

    typealias UnsortedArray = [Int]
    typealias SortedArray = [Int]

    let array: UnsortedArray
    init(_ array: UnsortedArray) {
        self.array = array
    }

    func quickSort() -> SortedArray {
        return quickSort(array)
    }

    private func quickSort(_ array: UnsortedArray) -> SortedArray {
        // base value
        guard array.count > 1 else { return array }

        var less: [Int] = []
        var equals: [Int] = []
        var largers: [Int] = []
        /// Considering first element as the pivot element.
        let pivot = array[0]

        for item in array {
            if item < pivot {
                less.append(item)
            } else if item == pivot {
                equals.append(item)
            } else {
                largers.append(item)
            }
        }

        return quickSort(less) + equals + quickSort(largers)
    }

    /// - complexity: O(n^2)
    func quickSortTwo(_ array: UnsortedArray) -> SortedArray {
        /// BaseCase
        guard array.count > 1 else { return array }

        /// Considering the center element as the pivot element.
        let pivot = array[array.count/2]
        let less = array.filter { $0 < pivot }
        let equals = array.filter { $0 == pivot }
        let largers = array.filter { $0 > pivot }
        return quickSortTwo(less) + equals + quickSortTwo(largers)
    }
}
