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

class BinaryTreeNode<T> {

    var value: T
    var left: BinaryTreeNode<T>?
    var right: BinaryTreeNode<T>?

    var isLeaf: Bool { left == nil && right == nil }
    var count: Int { (left?.count ?? 0) + 1 + (right?.count ?? 0) }

    init(value: T) {
        self.value = value
    }
}

class BinarySearchTree<T: Comparable> {

    var root: BinaryTreeNode<T>?

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

    // Insert a value in the tree
    func insert(value: T) {
        root = insert(value: value, node: root)
    }

    // Search for a value in the tree
    func search(value: T) -> BinaryTreeNode<T>? {
        search(value: value, node: root)
    }

    // Remove a value from the tree
    func remove(value: T) {
        root = remove(value: value, node: root)
    }
}

// MARK: - Insert
extension BinarySearchTree {

    /// NOTE: As its insert, we should create new node if there is no node found.
    /// And we should make sure that we aren't creating duplication
    private func insert(value: T, node: BinaryTreeNode<T>?) -> BinaryTreeNode<T> {
        guard let node = node else {
            return BinaryTreeNode(value: value)
        }
        if value < node.value {
            node.left = insert(value: value, node: node.left)
        } else if value > node.value {
            node.right = insert(value: value, node: node.right)
        } else {
            print("duplicate can't be inserted")
            // ** we aren't returning anything here.
        }
        return node
    }
}

// MARK: - Search
extension BinarySearchTree {
    private func search(value: T, node: BinaryTreeNode<T>?) -> BinaryTreeNode<T>? {
        guard let node = node else { return nil }
        if node.value == value {
            return node
        } else if value < node.value {
            return search(value: value, node: node.left)
        } else {
            return search(value: value, node: node.right)
        }
    }
}

// MARK: - Removal
extension BinarySearchTree {

    func remove(value: T, node: BinaryTreeNode<T>?) -> BinaryTreeNode<T>? {
        guard let node = node else { return nil }

        if value < node.value {
            // Reassign the left child after recursive deletion
            node.left = remove(value: value, node: node.left) 
        } else if value > node.value {
            // Reassign the right child after recursive deletion
            node.right = remove(value: value, node: node.right)
        } else { // Node to be removed is found
            if node.left == nil && node.right == nil {
                return nil // Case 1: Node has no children (leaf node)
            } else if node.left == nil {
                return node.right // Case 2: Node has only a right child
            } else if node.right == nil {
                return node.left // Case 2: Node has only a left child
            } else {
                // Case 3: Node has two children
                let successor = findMin(node.right!)
                node.value = successor.value // still this holds both left and right. just updating the value
                node.right = remove(value: successor.value, node: node.right)
            }
        }
        return node // ** important
    }

    private func findMin(_ node: BinaryTreeNode<T>) -> BinaryTreeNode<T> {
        var currentNode = node
        while let left = currentNode.left {
            currentNode = left
        }
        return currentNode
    }
}

// MARK: - Traversal
extension BinarySearchTree {

    // Pre-order traversal
    func traversePreOrder(_ process: (T) -> Void) {
        _traversePreOrder(root, process: process)
    }

    private func _traversePreOrder(_ node: BinaryTreeNode<T>?, process: (T) -> Void) {
        guard let node = node else { return }
        // Process the current node (root)
        process(node.value)
        // Recursively traverse the left subtree
        _traversePreOrder(node.left, process: process)
        // Recursively traverse the right subtree
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

    // Post-order traversal
    func traversePostOrder(_ process: (T) -> Void) {
        _traversePostOrder(root, process: process)
    }

    private func _traversePostOrder(_ node: BinaryTreeNode<T>?, process: (T) -> Void) {
        guard let node = node else { return }
        // Recursively traverse the left subtree
        _traversePostOrder(node.left, process: process)
        // Recursively traverse the right subtree
        _traversePostOrder(node.right, process: process)
        // Process the current node (root)
        process(node.value)
    }
}

extension BinarySearchTree: CustomStringConvertible {
    var description: String {
        return treeDescription(root)
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
