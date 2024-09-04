//
//  BalanceBinarySearchTree.swift
//  Algorithms
//
//  Created by Karthik on 13/03/24.
//

import Foundation

/// - NOTE: LeetCode sum https://www.youtube.com/watch?v=aNlZKXwnzuo
///

// MARK: - Traversal
extension BinaryTreeNode {

    func traverseInOrder(_ process: @escaping ((_ value: T) -> Void)) {
        left?.traverseInOrder(process)
        process(value)
        right?.traverseInOrder(process)
    }

    func traversePreOrder(_ process: @escaping ((_ value: T) -> Void)) {
        process(value)
        left?.traversePreOrder(process)
        right?.traversePreOrder(process)
    }

    func traversePostOrder(_ process: @escaping ((_ value: T) -> Void)) {
        left?.traversePostOrder(process)
        right?.traversePostOrder(process)
        process(value)
    }
}

extension BinaryTreeNode: CustomStringConvertible {

    var description: String {
        var s = ""
        if let left {
            s += "\(left.description) <-"
        }
        s += "\(value)"
        if let right {
            s += " -> \(right.description)"
        }
        return s
    }
}

class BalanceBinarySearchTree {

    /// - NOTE: For thie given node,
    /// Use one traversal method to flatten it to array.
    /// Then use divide and conquer mechanisim to build the BST
    func balanceBST(_ root: BinaryTreeNode<Int>?) -> BinaryTreeNode<Int>? {
        guard let root else { return nil } // basecase

        var nodeArray: [Int] = [Int]()
        _inOrderTraversal(root, paths: &nodeArray)
        debugPrint("traversed array: \(nodeArray)")
        return buildBST(nodeArray, startIndex: 0, endIndex: nodeArray.count - 1)
    }

    /// - NOTE: Converting node into an array, kind of flattening
    /// InOrder traverse gives array from low to high.
    /// doing divide and coqure on top of it can help to build binary tree.
    func _inOrderTraversal(_ node: BinaryTreeNode<Int>?, paths: inout [Int]) {
        // BaseCondition
        guard let node else { return }
        _inOrderTraversal(node.left, paths: &paths)
        paths.append(node.value)
        _inOrderTraversal(node.right, paths: &paths)
    }

    /// - NOTE: Creating new node using divide and conqure
    func buildBST(_ array: [Int], startIndex: Int, endIndex: Int) -> BinaryTreeNode<Int>?  {
        guard startIndex < endIndex else { return nil } // BaseCondition

        let middleIndex = startIndex + (endIndex - startIndex) / 2
        let finalNode = BinaryTreeNode(value: array[middleIndex])
        finalNode.left = buildBST(array, startIndex: startIndex, endIndex: middleIndex - 1)
        finalNode.right = buildBST(array, startIndex: middleIndex + 1, endIndex: endIndex)
        return finalNode
    }
}
