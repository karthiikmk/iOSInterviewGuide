//
//  BinarySearch.swift
//  Algorithms
//
//  Created by Karthik on 13/03/24.
//

import Foundation

/// - NOTE: Suppose you have an array of numbers and you need to ascertain whether a specific number is present in the array, and if so, at which index.
///
/// The Divide and Conquer approach - A classic method to expedite this task involves employing binary search. This technique involves repeatedly dividing the array in half until the target value is located.
///
/// While binary search offers significant advantages, there's a caveat: the array must be sorted in ascending or descending order for binary search to work effectively.
///
///Binary search truly excels in scenarios where you sort the array just once and subsequently conduct multiple searches, making it an efficient solution for large datasets.
class BinarySearch {

    let array: [Int]

    init(array: [Int]) {
        self.array = array
    }

    /// - NOTE: Using simple while loop
    func search(_ searchValue: Int) -> Int? {

        var startIndex: Int = 0
        var endIndex: Int = array.count

        while startIndex < endIndex {
            let middleIndex = startIndex + (endIndex - startIndex) / 2
            if array[middleIndex] == searchValue {
                return middleIndex // BaseCase
            } else if array[middleIndex] < searchValue {
                startIndex = middleIndex - 1
            } else {
                endIndex = middleIndex + 1
            }
        }
        return nil
    }
}
