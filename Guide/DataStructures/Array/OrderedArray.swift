//
//  OrderedArray.swift
//  Algorithms
//
//  Created by Karthik on 12/03/24.
//

import Foundation

// MARK: Ordered Array using Binary Search
// Description: This is an array that is always sorted from low to high.
// Whenever you add a new item to this array, it is inserted in its sorted position.
// Time complexity will be O(n) in worst case.
class OrderedArray<T: Comparable>: CustomStringConvertible {

    private var storage: [T] = []

    init(_ items: [T]) {
        self.storage = items.sorted()
    }
    var isEmpty: Bool {
        return storage.isEmpty
    }
    var count: Int {
        return storage.count
    }
    var description: String {
        "\(self.storage.map { "\($0)"}.joined(separator: "\n"))"
    }

    func isValidIndex(_ index: Int) -> Bool {
        index >= 0 && index < count
    }

    public subscript(index: Int) -> T {
        assert(isValidIndex(index))
        return self.storage[index]
    }

    // Insert
    // Time complexity will be O(n) - since it has to iterate all the array once to find the element in worst case
    func insert(_ item: T) {
        for i in 0..<self.count {
            guard item <= self.storage[i] else { continue }
            // new item will be inserted before the index. so next item will be sitting next to the current
            self.storage.insert(item, at: i)
            break
        }
    }

    func insertUsingBinarySearch(_ newItem: T) {

        var start: Int = 0
        var end: Int = self.storage.count

        while start < end {
            let midIndex = start + (end - start) / 2 // first 0 to n, then first portion + rest portion middle, and so on ...
            let middleItem = self.storage[midIndex]

            if storage[midIndex] == middleItem {
                self.storage.insert(newItem, at: midIndex)
                return // Basecase
            } else if storage[midIndex] < newItem {
                start = midIndex + 1
            } else {
                end = midIndex // not by - 1 as its helps to insert
            }
        }
    }

    // Remove
    func remove(at index: Int) -> T {
        assert(isValidIndex(index))
        return self.storage[index]
    }

    func removeAll() {
        self.storage.removeAll()
    }
}
