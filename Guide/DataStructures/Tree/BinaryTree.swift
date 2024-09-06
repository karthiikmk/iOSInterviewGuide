//
//  BinaryTree.swift
//  Algorithms
//
//  Created by Karthik on 17/03/24.
//

import Foundation

/// A binary tree is a hierarchical data structure in which each node has at most two children, referred to as the left child and the right child.
/// The structure of a binary tree allows for efficient insertion, deletion, and traversal operations.
/// In a binary tree, there are no specific rules or constraints on the arrangement of nodes. Nodes can be inserted in any order, and the tree might not necessarily be sorted.
///
/// Time Complexity:
/// Search: O(n)
/// Insertion: O(n)
/// Deletion: O(n)
/// Storage Complexity: O(n)
///
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
