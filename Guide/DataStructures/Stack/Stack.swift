//
//  File.swift
//  Algorithms
//
//  Created by Karthik on 13/03/24.
//

import Foundation

// ================================
// Last in first out (LIFO)
// ================================

// MARK: Stack Using Array (inverse handling)
// Description: This array time complexity will be O(1),
// Because all the insert and remove happens on the end of the array.
// Which doesn't require changing the index
class Stack<T> {

    var storage: [T] = []
    var isEmpty: Bool { storage.isEmpty }

    // It will always insert at the last
    func push(_ element: T) {
        storage.append(element)
    }

    @discardableResult 
    func pop() -> T? {
        return storage.popLast()
    }

    func peek() -> T? {
        return storage.last
    }
}

extension Stack: CustomStringConvertible {

    var description: String {
        return  "------ Begins ------ \n"
        + storage.map { "\($0)" }.joined(separator: "\n")
        + "\n-------- Ends -------- "
    }
}
