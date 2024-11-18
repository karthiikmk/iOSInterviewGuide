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

/// Default size, and count is very very important to build the fixed size array.
/// But the thing is the `order is not guarnteed` here.
/// While removing, we gonna put the end index value to the removing and reducing the count.
class FixedSizeArray<T>: CustomStringConvertible {
    
    let maxSize: Int
    let defaultValue: T
    var array: [T]
    
    /// - NOTE: as array.count always provides the max value,
    /// so we need additional counter to track how much data inserted.
    private var count: Int = 0
    private var endIndex: Int { count - 1 }
    
    init(max: Int, defaultValue: T) {
        self.maxSize = max
        self.defaultValue = defaultValue
        self.array = Array(repeating: defaultValue, count: max)
    }
    
    func append(_ item: T) {
        guard count < maxSize else {
            print("array reached max size, new item can't be inserte")
            return
        }
        array[count] = item
        count += 1
    }
    
    /// - NOTE: Won't maintian the index order.<##>
    func remove(at index: Int) -> T {
        precondition(index >= 0 && index < count)
        
        let result = array[index]
        array[index] = array[endIndex] // moving the last element to remvoing index
        array[endIndex] = defaultValue // resettig the last index to deafult value
        count -= 1
        return result
    }
    
    /// - NOTE: Resetting all index to the default value. <##>
    func removeAll() {
        for i in 0..<count {
            self.array[i] = defaultValue
        }
        count = 0
    }
    
    var description: String {
        "\(array)"
    }
}
