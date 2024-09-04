//
//  AVLTree.swift
//  Algorithms
//
//  Created by Karthik on 15/03/24.
//

import Foundation

/// An AVL tree is a self-balancing binary search tree named after its inventors Adelson-Velsky and Landis
/// Eeach node keep track of its height, and after insert or remove operation
/// Rotation will be performed if required to ensure that the height deference bw the left and right subtree of any given node not more than 1.
///
/// Time Complexity:
///  Search: O(log n)
///  Insertion: O(log n) (includes potential rebalancing)
///  Deletion: O(log n) (includes potential rebalancing)
/// Storage Complexity: O(n) + O(log n) for balance factor or height information at each node.

/*
 Balancefactor = height of left subtree - height of right subtree
 bf = hl - hr = { -1, 0, 1 }

 BalanceFactor:
 if balance factor > 1, then the tree is imbalanced.
 Rotation would be perfromed to balance the tree

 Rotation:
 LL - Rotation (single rotation) -
 RR - Rotation (single rotation)
 LR - Rotation (double rotation)
 RL - Rotation (double rotation)

 Rotation should be only performed over 3 nodes.
*/

class AVLNode<T: Comparable> {

    var value: T
    var left: AVLNode<T>?
    var right: AVLNode<T>?
    var height: Int = 1 // default height keeping as 1.

    init(value: T) {
        self.value = value
    }
}

class AVLTree<T: Comparable> {

    /// - NOTE: Tree can have only one root
    var root: AVLNode<T>? = nil

    init() { }

    func insert(value: T) { 
        self.root = insert(value: value, node: root)
    }

    func remove(value: T)  {
        self.root = remove(value: value, node: root)
    }

    func search(value: T) -> AVLNode<T>? { return nil }
}

// MARK: - Insert operation
extension AVLTree {

    /// - NOTE: Recurssive function
    private func insert(value: T, node: AVLNode<T>?) -> AVLNode<T> {
        /// If no node found
        guard let node = node else {
            return AVLNode(value: value) // creates 8
        }

        if value < node.value { // 8 < 10 || 8 < 9
            node.left = insert(value: value, node: node.left)
        } else if value > node.value {
            node.right = insert(value: value, node: node.right)
        } else {
            // Value already exists in the tree; don't insert duplicates.
            return node
        }
        // Update the height of this ancestor node.
        updateHeight(of: node)
        // Balance the node if needed.
        return balance(node: node)
    }

    func remove(value: T, node: AVLNode<T>?) -> AVLNode<T>? {
        guard let node else { return nil }
        
        if value < node.value {
            return remove(value: value, node: node.left)
        } else if value > node.value {
            return remove(value: value, node: node.right)
        } else {
            // found value, remove now
            if node.left == nil {
                return node.right
            } else if node.right == nil {
                return node.left
            }

            // Node with two children: Get the inorder successor (smallest in the right subtree).
            node.value = minimum(of: node.right!).value
            // Delete the inorder successor.
            node.right = remove(value: node.value, node: node.right)
        }
        // Update the height of this ancestor node.
        updateHeight(of: node)
        // Balance the node if needed.
        return balance(node: node)
    }
}

extension AVLTree {

    func balance(node: AVLNode<T>) -> AVLNode<T> {
        if balanceFactor(of: node) > 1 {
            if balanceFactor(of: node.left) < 0 {
                node.left = rotateLeft(node.left!)
            }
            return rotateRight(node)
        } else if balanceFactor(of: node) < -1 {
            if balanceFactor(of: node.right) > 0 {
                node.right = rotateRight(node.right!)
            }
            return rotateLeft(node)
        }
        // no imblance found
        return node
    }
}

// MARK: - Helpers
extension AVLTree {

    func minimum(of node: AVLNode<T>) -> AVLNode<T> {
        var _node = node
        while let node = node.left {
            _node = node
        }
        return _node
    }

    func updateHeight(of node: AVLNode<T>) {
        node.height = 1 + max(height(of: node.left), height(of: node.right))
    }

    func height(of node: AVLNode<T>?) -> Int {
        return node?.height ?? 0
    }

    func balanceFactor(of node: AVLNode<T>?) -> Int {
        return height(of: node?.left) - height(of: node?.right) // 2
    }

    func rotateRight(_ node: AVLNode<T>) -> AVLNode<T> {

        let newRoot = node.left!
        node.left = newRoot.right
        newRoot.right = node

        updateHeight(of: node)
        updateHeight(of: newRoot)
        return newRoot
    }

    func rotateLeft(_ node: AVLNode<T>) -> AVLNode<T> {

        let newRoot = node.right!
        node.right = newRoot.left
        newRoot.left = node

        updateHeight(of: node)
        updateHeight(of: newRoot)
        return newRoot
    }
}
