//
//  BinarySearchUsingRecurssion.swift
//  Algorithms
//
//  Created by Karthik on 19/03/24.
//

import Foundation

class BinarySearchUsingRecurssion {

    let array: [Int]

    init(array: [Int]) {
        self.array = array
    }

    func search(value: Int) -> Int?  {
        return search(
            value: value,
            startIndex: 0,
            endIndex: array.count-1
        )
    }

    private func search(value: Int, startIndex: Int, endIndex: Int ) -> Int? {
        // BaseCondition
        guard !array.isEmpty else { return nil }
        // BaseCondition
        guard startIndex <= endIndex else { return nil }

        let midIndex = startIndex + (endIndex - startIndex) / 2
        if value == array[midIndex] {
            return midIndex
        } else if value < array[midIndex] {
            return search(value: value, startIndex: startIndex, endIndex: midIndex - 1)
        } else {
            return search(value: value, startIndex: midIndex + 1, endIndex: endIndex)
        }
    }
}
