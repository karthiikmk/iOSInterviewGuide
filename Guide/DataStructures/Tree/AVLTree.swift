//
//  AVLTree.swift
//  Algorithms
//
//  Created by Karthik on 15/03/24.
//

import Foundation

/// An AVL tree is a self-balancing binary search tree named after its inventors Adelson-Velsky and Landis
/// Eeach node keep track of its height, after insert and remove operation
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
    /// in many implementations, the height of a leaf node is often initialized as 1
    /// because the AVL tree manipulations (like rotations) depend on height differences.
    var height: Int = 1 // always keeps the max height of subtrees

    init(value: T) {
        self.value = value
    }
}

/// Pre-requsites
/// Implement: insert, remove, search operation
class AVLTree<T: Comparable> {

    /// - NOTE: Tree can have only one root
    var root: AVLNode<T>? = nil

    init() { }

    func insert(value: T) {
      root = insert(value: value, root)
    }

    func search(value: T) -> AVLNode<T>? {
        return search(value: value, node: root)
    }

    func remove(value: T)  {
        self.root = remove(value: value, node: root)
    }
}

// MARK: - Insert operation
extension AVLTree {
    
    /// - NOTE: Recurssive function
    @discardableResult
    private func insert(value: T, _ node: AVLNode<T>?) -> AVLNode<T> {
        guard let node else {
            return AVLNode(value: value)
        }
        if value == node.value {
            // duplicate can't be inserted
        } else if value < node.value {
            // Reassign the left child after recursive insert
            node.left = insert(value: value, node) // ** not returning.
        } else  {
            // Reassign the right child after recursive insert
            node.right = insert(value: value, node)
        }
        return rebalance(node)
    }

    func search(value: T, node: AVLNode<T>?) -> AVLNode<T>? {
        guard let node else { return nil }
        if value == node.value {
            return node // Match found
        } else if value < node.value {
            return search(value: value, node: node.left)
        } else {
            return search(value: value, node: node.right)
        }
    }

    func remove(value: T, node: AVLNode<T>?) -> AVLNode<T>? {
        guard let node else { return nil }

        if value < node.value {
            // Reassign the left child after recursive deletion
            node.left = remove(value: value, node: node.left) // Recursive
        } else if value > node.value {
            // Reassign the right child after recursive deletion
            node.right = remove(value: value, node: node.right) // Recursive
        } else {
            /// At this place we found the node, this is the node which gonna be removed.
            
            /// for the current node, if both the childs are not there, then simply returning
            /// nil will delete the current node.
            if node.left == nil && node.right == nil {
                return nil // If the node is a leaf, return nil to remove it
            }
            /// if current node which gonna be deleted has right child, then return that.
            else if node.left == nil {
                return node.right  // No left child, return right child
            }
            /// if current node which gonna be deleted has left child, return that.
            else if node.right == nil {
                return node.left   // No right child, return left child
            }
            /// if the current node which gonna be deleted has both the child.
            /// then we should find the min child in the right sub tree..
            /// swap that as the current node, and remove the min child from the right sub tree
            /// because we are using the bst.
            else {
                // Node with two children: Get the inorder successor (smallest in the right subtree).
                let successor = minimum(of: node.right!)
                node.value = successor.value
                // Delete the inorder successor.
                node.right = remove(value: successor.value, node: node.right) // Recursive
            }
        }
        return rebalance(node)
    }
}

extension AVLTree {
    
    func rebalance(_ node: AVLNode<T>) -> AVLNode<T> {
        // Update the height of this ancestor node.
        updateHeight(of: node)
        // Balance the node if needed.
        return balance(node: node)
    }
    
    func updateHeight(of node: AVLNode<T>) {
        let leftHeight = node.left?.height ?? 0
        let rightHeight = node.right?.height ?? 0
        node.height = 1 + max(leftHeight, rightHeight)
    }

    /// NOTE: To understand more on rotation
    /// draw BST with 4 levels.
    /// we get +ve bf, if left side nodes are available
    /// we get -ve bf, if right side nodes are available.
    /// In order to determine double rotation
    /// we need to check the intermidate node balance factor.
    /// if that is +ve, then we need right rotation first
    /// if that is -ve, then rotate left
    func balance(node: AVLNode<T>) -> AVLNode<T> {
        let bf = balanceFactor(of: node)
        if bf >= -1 && bf <= 1 {
            // No imbalance found
        } else if bf > 1 {
            if balanceFactor(of: node.left) < 0 { // +ve, -ve check
                node.left = rotateLeft(node.left!) // double rotation
            }
            return rotateRight(node)
        } else if bf < -1 {
            if balanceFactor(of: node.right) > 0 {
                node.right = rotateRight(node.right!) // double rotation
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

    func height(of node: AVLNode<T>?) -> Int {
        return node?.height ?? 0
    }

    func balanceFactor(of node: AVLNode<T>?) -> Int {
        let leftHeight = node?.left?.height ?? 0
        let rightHeight = node?.right?.height ?? 0
        return leftHeight - rightHeight
    }

    func rotateRight(_ node: AVLNode<T>) -> AVLNode<T> {

        let newRoot = node.left!
        node.left = newRoot.right // order is very important. else EXE BADACCESS
        newRoot.right = node

        updateHeight(of: node)
        updateHeight(of: newRoot)
        return newRoot
    }

    func rotateLeft(_ node: AVLNode<T>) -> AVLNode<T> {

        let newRoot = node.right!
        node.right = newRoot.left // order is important
        newRoot.left = node

        updateHeight(of: node)
        updateHeight(of: newRoot)
        return newRoot
    }
}
