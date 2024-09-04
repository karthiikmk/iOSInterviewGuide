//
//  OrderedArrayUsingBS.swift
//  Algorithms
//
//  Created by Karthik on 16/03/24.
//

import Foundation

/// - NOTE: This is an array that is always sorted from low to high.
/// Whenever you add a new item to this array, it is inserted in its sorted position.
/// https://victorqi.gitbooks.io/swift-algorithm/content/ordered_array.html
///  Note that using binary search doesn't change the worst-case running time complexity of insert().
/// The binary search itself takes only O(log n) time,
/// but inserting a new object in the middle of an array still involves shifting all remaining elements in memory.
/// So overall, the time complexity is still O(n). But in practice this new version definitely is a lot faster, especially on large arrays.
class OrderedArrayUsingBinarySearch {

    var array: [Int]

    init(array: [Int] = []) {
        self.array = array.sorted()
    }

    func insert(item: Int) {
        let index = findInsertionPoint(for: item)
        array.insert(item, at: index)
    }

    private func findInsertionPoint(for newItem: Int) -> Int {

        var startIndex: Int = 0
        var endIndex: Int = array.count

        while startIndex < endIndex {
            let midIndex = startIndex + (endIndex - startIndex) / 2

            if array[midIndex] == newItem {
                return midIndex //
            } else if array[midIndex] < newItem {
                startIndex = midIndex + 1
            } else {
                endIndex = midIndex //
            }
        }
        return startIndex // important
    }
}
