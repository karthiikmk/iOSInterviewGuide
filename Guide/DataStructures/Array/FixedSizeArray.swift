//
//  FixedSizeArray.swift
//  Algorithms
//
//  Created by Karthik on 12/03/24.
//

import Foundation

// https://victorqi.gitbooks.io/swift-algorithm/content/fixed_size_array.html

/*
 - Pros: simple, fast and predicatable
 - Cons: leaves room for out of bound errors

 - append is 0(1)
 - inserting and deleting is expensive
 - Deleting needs to move the old indeces to new position
*/
struct FixedSizeArray<T> {

    let maxSize: Int
    let defaultValue: T
    var array: [T]

    /// - NOTE: as array.count always provides the max value,
    /// so we need additional counter to track how much data inserted.
    private var count: Int = 0

    init(max: Int, defaultValue: T) {
        self.maxSize = max
        self.defaultValue = defaultValue
        self.array = Array(repeating: defaultValue, count: max)
    }

    mutating func append(item: T) {
        guard count < maxSize else {
            debugPrint("array reached max size, new item can't be inserte")
            return
        }
        self.count += 1
        self.array.append(item)
    }

    /// - NOTE: Won't maintian the index order.<##>
    mutating func remove(at index: Int) -> T {
        assert(index >= 0)
        assert(index < count)
        self.count -= 1 // works like total array count;

        let result = array[index]
        array[index] = array[count] // moving the last element to remvoing index
        array[count] = defaultValue // resettig the last index to deafult value
        return result
    }

    /// - NOTE: Resetting all index to the default value. <##>
    mutating func removeAll() {
        for i in 0..<count {
            self.array[i] = defaultValue
        }
        count = 0
    }
}
