//
//  BinaryTree.swift
//  Algorithms
//
//  Created by Karthik on 13/03/24.
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

/// A binary search tree is a specific type of binary tree that follows a particular property: for each node,
///  all elements in its left subtree are less than the node's value, and
///  all elements in its right subtree are greater than the node's value.
///
///  This property allows for efficient searching, insertion, and deletion operations.
///  It ensures that the tree remains sorted in a way that enables fast search operations.
///
///  Because of the sorted nature of a binary search tree, the inorder traversal of the tree yields the elements in sorted order.
///
/// Time Complexity (Worst-case, unbalanced):
///  Search: O(n)
///  Insertion: O(n)
///  Deletion: O(n)
/// Time Complexity (Average-case, balanced):
///  Search: O(log n)
///  Insertion: O(log n)
///  Deletion: O(log n)
/// Storage Complexity: O(n)

/*
 Non linear, tree based datastructure 

 Binary Search Trees (BSTs) and AVL trees both serve the purpose of maintaining elements in a sorted order
 to facilitate efficient search, insertion, and deletion operations.

 While AVL trees are a type of self-balancing binary search tree that guarantees O(log n) 
 time complexity for these operations by maintaining a balanced height
*/

/*
 A binary tree is a tree where each node has 0, 1, or 2 children.

 A binary search tree is a special kind of binary tree (a tree in which each node has at most two children)
 that performs insertions and deletions such that the tree is always sorted.

 Each left child is smaller than its parent node, and each right child is greater than its parent node.
 This is the key feature of a binary search tree.

 There is always only one possible place where the new element can be inserted in the tree.
 Finding this place is usually pretty quick. It takes O(h) time, where h is the height of the tree.

 Pre-order: first look at a node, then its left and right children.
 In-order (or depth-first): first look at the left child of a node, then at the node itself, and finally at its right child.
 Post-order: first look at the left and right children and process the node itself last.

 A tree is balanced if depth of the two subtrees of every node never differs by not more than 1
 in an Unbalanced BST, the height of the tree can be upto n which is same as linked list. in such case insert, delete and search can take O(n)

 Pros: BST - insert, delete, lookup - O(log n)
           - this is much better than linear time O(n) eg. linked list
 Cons: Slower than arry on lookup,
       can be imbalanced, to prevent we should introduce self balancing techniques like AVL Tree, ore red-black tree.
*/

/*
 Pre-requsite:
 - A binary search tree is a special kind of binary tree (a tree in which each node has at most two children)
 - Each left child is smaller than its parent node, and each right child is greater than its parent node.
 - insert, remove can start performing from the root 
*/

/// - NOTE: will have only two children<##>
class BinaryTreeNode<T> {

    var value: T
    var parent: BinaryTreeNode?
    var left: BinaryTreeNode<T>?
    var right: BinaryTreeNode<T>?

    var isRoot: Bool { parent == nil }
    var isLeaf: Bool { left == nil && right == nil }
    var count: Int { (left?.count ?? 0) + 1 + (right?.count ?? 0) }
    var isLeftChild: Bool { parent?.left === self }
    var isRightChild: Bool { parent?.right === self }

    var hasLeftChild: Bool { left != nil }
    var hasRightChild: Bool { right != nil }
    var hasAnyChild: Bool { hasLeftChild || hasRightChild }
    var hasBothChildern: Bool { hasLeftChild && hasRightChild }

    init(value: T) {
        self.value = value
    }
}

class BinarySearchTree<T: Comparable> {

    var root: BinaryTreeNode<T>? = nil // Use this

    init(_ value: T) {
        self.root = BinaryTreeNode(value: value)
    }

    convenience init(array: [T]) {
        precondition(array.count > 0)
        self.init(array[0])
        for i in 1..<array.count {
            insert(value: array[i])
        }
    }

    func insert(value: T) {
        guard let root = root else {
            self.root = BinaryTreeNode(value: value)
            return
        }
        insert(root, value: value)
    }

    // Search for a value in the tree
    func search(value: T) -> BinaryTreeNode<T>? {
        return search(root, value: value)
    }

    func remove(value: T) {
        guard let node = search(value: value) else { return }
        return removeNode(node)
    }
}

extension BinarySearchTree {

    func height(of node: BinaryTreeNode<T>?) -> Int {
        guard let node else { return 0 }
        return 1 + max(height(of: node.left), height(of: node.right))
    }

    /// Going upwards towards parent
    func depth(of node: BinaryTreeNode<T>?) -> Int {
        var depth: Int = 0
        var currentNode = node

        // if no parents, then root is reached.
        while let parent = currentNode?.parent {
            depth += 1
            currentNode = parent
        }
        return depth
    }

    /// NOTE: Find the node which has minium value
    /// As its binary search tree, the minimum always found on the left hand side
    func findMin(of node: BinaryTreeNode<T>) -> BinaryTreeNode<T> {
        var currentNode = node
        while let left = currentNode.left {
            currentNode = left
        }
        return currentNode
    }

    /// NOTE: Find the node which has minium value
    /// As its binary search tree, the minimum always found on the left hand side
    func findMaxNode(of node: BinaryTreeNode<T>?) -> BinaryTreeNode<T>? {
        guard let node else { return nil }
        var currentNode = node
        while let righ = currentNode.right {
            currentNode = righ
        }
        return currentNode
    }
}

// MARK: - Insert
extension BinarySearchTree {

    private func insert(_ node: BinaryTreeNode<T>, value: T) {
        if value < node.value {
            if let leftChild = node.left {
                insert(leftChild, value: value)
            } else {
                let newNode = BinaryTreeNode(value: value)
                newNode.parent = node
                node.left = newNode
            }
        } else if value > node.value {
            if let rightChild = node.right {
                insert(rightChild, value: value)
            } else {
                let newNode = BinaryTreeNode(value: value)
                newNode.parent = node
                node.right = newNode
            }
        }
    }
}

// MARK: - Search
extension BinarySearchTree {

    /// BST Search
    private func search(_ node: BinaryTreeNode<T>?, value: T) -> BinaryTreeNode<T>? {
        guard let node = node else { return nil }

        if value == node.value {
            return node // Basecase
        } else if value < node.value {
            return search(node.left, value: value)
        } else {
            return search(node.right, value: value)
        }
    }
}

// MARK: - Removal
extension BinarySearchTree {

    func remove(node: T) {
        guard let nodeToRemove = search(value: node) else { return }
        removeNode(nodeToRemove)
    }

    private func removeNode(_ node: BinaryTreeNode<T>) {
        // Case 1: Node has no children (Leaf)
        if node.left == nil && node.right == nil {
            reconnectParent(node, for: nil)
        }
        // Case 2: Node has one child (left or right)
        else if let left = node.left, node.right == nil {
            reconnectParent(node, for: left)
        } else if let right = node.right, node.left == nil {
            reconnectParent(node, for: right)
        }
        // Case 3: Node has two children
        else if let right = node.right, let left = node.left {
            let successor = findMin(of: right)
            removeNode(successor)
            // left
            successor.left = left
            left.parent = successor
            // Right
            if right !== successor {
                successor.right = right
                right.parent = successor
            } else {
                successor.right = nil
            }
            // Reconnecting with parent
            reconnectParent(node, for: successor)
        }
    }

    // Helper to reconnect parent node
    private func reconnectParent(_ node: BinaryTreeNode<T>, for replacement: BinaryTreeNode<T>?) {
        if let parent = node.parent {
            if parent.left === node {
                parent.left = replacement
            } else if parent.right === node {
                parent.right = replacement
            }
        }
        replacement?.parent = node.parent
    }
}

// MARK: - Traversal
extension BinarySearchTree {

    /// - NOTE: time 0(n), space 0(n)
    func traversePreOrder(_ process: @escaping ((T) -> Void)) {
        _traversePreOrder(root, process: process)
    }

    private func _traversePreOrder(_ node: BinaryTreeNode<T>?, process: (T) -> Void) {
        guard let node = node else { return }
        process(node.value)
        _traversePreOrder(node.left, process: process)
        _traversePreOrder(node.right, process: process)
    }

    func traverseInOrder(_ process: (T) -> Void) {
        _traverseInOrder(root, process: process)
    }

    private func _traverseInOrder(_ node: BinaryTreeNode<T>?, process: (T) -> Void) {
        guard let node = node else { return }
        _traverseInOrder(node.left, process: process)
        process(node.value)
        _traverseInOrder(node.right, process: process)
    }

    func traversePostOrder(_ process: (T) -> Void) {
        _traversePostOrder(root, process: process)
    }

    /// - NOTE: time 0(n), space 0(n)
    private func _traversePostOrder(_ node: BinaryTreeNode<T>?, process: (T) -> Void) {
        guard let node = node else { return }
        _traversePostOrder(node.left, process: process)
        _traversePostOrder(node.right, process: process)
        process(node.value)
    }
}

extension BinarySearchTree: CustomStringConvertible {

    var description: String {
        treeDescription(root)
    }

    private func treeDescription(_ node: BinaryTreeNode<T>?) -> String {
        guard let node = node else { return "" }
        var s = ""
        if let left = node.left {
            s += "(\(treeDescription(left))) <- "
        }
        s += "\(node.value)"
        if let right = node.right {
            s += " -> (\(treeDescription(right)))"
        }
        return s
    }
}
