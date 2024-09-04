//
//  BinaryTreeNode.swift
//  Algorithms
//
//  Created by Karthik on 15/03/24.
//

import Foundation

/// - NOTE: will have only two children<##>
class BinaryTreeNode<T> {

    let value: T
    var left: BinaryTreeNode<T>?
    var right: BinaryTreeNode<T>?

    init(value: T) {
        self.value = value
    }
}

class TraversalWitoutRecurssion {

    init() { }

    /// - NOTE: Idea behind this
    /// node will have left and child
    /// inserting left and
    func preOrderTraverse(for root: BinaryTreeNode<Int>) -> [Int] {

        var array: [Int] = [Int]()
        let stack = Stack<BinaryTreeNode<Int>>() // enqueu dequeue happens at the last position
        stack.push(root) // settign the root into stack

        /// - NOTE: Kind of recurrsion
        while !stack.isEmpty {
            let last = stack.pop()!
            array.append(last.value)
            if let right = last.right {
                stack.push(right)
            }
            // left at the last because, enqueue happen at the last.
            // for preorder, we need all the left to be printed first
            if let left = last.left {
                stack.push(left)
            }
        }
        return array
    }
}
