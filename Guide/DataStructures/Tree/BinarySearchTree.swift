//
//  BinaryTree.swift
//  Algorithms
//
//  Created by Karthik on 13/03/24.
//

import Foundation

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

 In-order (or depth-first): first look at the left child of a node, then at the node itself, and finally at its right child.
 Pre-order: first look at a node, then its left and right children.
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

class BinarySearchTree<T: Comparable> {

    let value: T
    var parent: BinarySearchTree<T>? = nil
    var left: BinarySearchTree<T>? = nil // first child
    var right: BinarySearchTree<T>? = nil // second child

    fileprivate var isRoot: Bool { parent == nil }
    fileprivate var isLeaf: Bool { left == nil && right == nil }
    fileprivate var count: Int { (left?.count ?? 0) + 1 + (right?.count ?? 0) }
    fileprivate var isLeftChild: Bool { parent?.left === self }
    fileprivate var isRightChild: Bool { parent?.right === self }

    fileprivate var hasLeftChild: Bool { left != nil }
    fileprivate var hasRightChild: Bool { right != nil }
    fileprivate var hasAnyChild: Bool { hasLeftChild || hasRightChild }
    fileprivate var hasBothChildern: Bool { hasLeftChild && hasRightChild }

    init(_ value: T) {
        self.value = value
    }

    convenience init(array: [T]) {
        precondition(array.count > 0)
        self.init(array.first!)

        for v in array.dropFirst() {
            self.insert(value: v, with: self)
        }
    }

    // This will be added as child, so the parent is the current
    func insert(value: T) {
        insert(value: value, with: self)
    }

    func search(value: T) -> BinarySearchTree<T>? {
        if value < self.value {
            return left?.search(value: value)
        } else if value > self.value {
            return right?.search(value: value)
        } else {
            return self // Basecase
        }
    }

    func remove(value: T) -> BinarySearchTree<T>? {
        guard let tree = search(value: value) else { return nil }
        return tree.remove()
    }
}

extension BinarySearchTree {

    /// - NOTE: From root to the leaf
    func height() -> Int {
        if isLeaf {
            return 0 // BaseCondition
        } else {
            return 1 + max((left?.height() ?? 0), (right?.height() ?? 0))
        }
    }

    /// - NOTE: from root to the current node<##>
    func depth() -> Int {
        var node = self
        var edges = 0
        // if no parents, then root is reached.
        while case let parent? = node.parent {
            node = parent
            edges += 1
        }
        return edges
    }


    /// - NOTE: Recurssing all the left nodes to the end
    func minimum() -> BinarySearchTree<T> {
        var node = self
        while let next = node.left {
            node = next
        }
        return node
    }

    func maximum() -> BinarySearchTree<T> {
        var node = self
        while let next = node.right {
            node = next
        }
        return node
    }
}

// MARK: - Insert
extension BinarySearchTree {

    /// - NOTE: A recurive function
    private func insert(value: T, with parent: BinarySearchTree<T>) {
        // insert as left child
        if value < self.value {
            if let left = self.left {
                left.insert(value: value, with: left) // recurssion
            } else {
                self.left = BinarySearchTree(value)
                left?.parent = parent
            }
        } else if value > self.value {
            // insert as rigth child
            if let right = self.right {
                right.insert(value: value, with: right) // recurssion
            } else {
                self.right = BinarySearchTree(value)
                self.right?.parent = parent
            }
        } else {
            // duplicate value can't inserted.
        }
    }
}

// MARK: - Removal
extension BinarySearchTree {

    func reconnectParent(_ node: BinarySearchTree<T>?) {
        if let parent = self.parent { // self.parent is important
            if isLeftChild {
                parent.left = node
            } else {
                parent.right = node
            }
        }
        // if no parent, then that is root node.
        // so we should reset the nodes parent, else it might keep the old parent
        node?.parent = parent
    }

    /// - NOTE: Removing the current node
    func remove() -> BinarySearchTree? {
        var replacementNode: BinarySearchTree? = nil

        // This node has two children
        if let left = self.left {
            if let right = self.right {
                // find the smallest child that is larger than the node
                replacementNode = removeNodeWithTwoChildren(left, right)
            } else {
                // This node only has a left child. The left child replaces the node.
                replacementNode = left
            }
        } else if let right = self.right {
            // This node only has a right child. The right child replaces the node
            replacementNode = right
        } else {
            // This node has no children. We just disconnect it from its parent
            replacementNode = nil
        }

        reconnectParent(replacementNode)

        // resetting
        self.parent = nil
        self.left = nil
        self.right = nil
        return replacementNode
    }

    /// - NOTE: find the smallest child that is larger than the node
    private func removeNodeWithTwoChildren(_ left: BinarySearchTree<T>, _ right: BinarySearchTree<T>) -> BinarySearchTree {

        let successor = right.minimum() // right is the larger one, on that should find the least one.
        _ = successor.remove() // cleaning up so that node can be relocated.

        // reparing the left node
        successor.left = left
        left.parent = successor

        // reparing the right node
        if right !== successor { // minimum and larger node are not same
            successor.right = right
            right.parent = successor
        } else {
            successor.right = nil
        }

        return successor
    }
}

// MARK: - Traversal
extension BinarySearchTree {

    /// - NOTE: time 0(n), space 0(n)
    func traverseInOrder(_ process: @escaping ((T) -> Void)) {
        left?.traverseInOrder(process)
        process(value)
        right?.traverseInOrder(process)
    }

    /// - NOTE: time 0(n), space 0(n)
    func traversePreOrder(_ process: @escaping ((T) -> Void)) {
        process(value)
        left?.traversePreOrder(process)
        right?.traversePreOrder(process)
    }

    /// - NOTE: time 0(n), space 0(n)
    func traversePostOrder(_ process: @escaping ((T) -> Void)) {
        left?.traversePostOrder(process)
        right?.traversePostOrder(process)
        process(value)
    }
}

extension BinarySearchTree: CustomStringConvertible {

    var description: String {
        var s = ""
        if let left = self.left {
            s += "(\(left.description)) <- "
        }
        s += "\(value)"
        if let right = self.right {
            s += " -> \(right.description)"
        }
        return s
    }
}
