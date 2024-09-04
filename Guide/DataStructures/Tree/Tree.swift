//
//  Tree.swift
//  Algorithms
//
//  Created by Karthik on 13/03/24.
//

import Foundation

/// A tree represents hierarchical relationships between objects. consists of nodes, and these nodes are linked to one another.
///
/// Nodes: Each node in a tree contains some data and may have a reference to one or more child nodes.
/// Root: The topmost node in a tree is called the root. It is the starting point for traversing the tree.
/// Edges: The edges of a tree are the connections between nodes. They represent relationships between the nodes.
/// Leaf Nodes: Nodes that do not have any children are called leaf nodes or terminal nodes. They are the nodes at the ends of the branches in the tree.
/// Depth and Height: The depth of a node in a tree is the length of the path from the root to that node.
/// The height of a tree is the length of the longest path from the root to a leaf node.

class TreeNode<T> {

    let value: T
    weak var parent: TreeNode<T>? // IMP
    var children: [TreeNode<T>] = [TreeNode<T>]() // N number of children

    init(value: T) {
        self.value = value
    }

    func add(node: TreeNode<T>) {
        children.append(node)
        node.parent = self
    }
}

extension TreeNode: CustomStringConvertible {

    var description: String {
        var s = "\(value)"
        if !children.isEmpty {
            s += " {" + children.map { $0.description }.joined(separator: ", ") + "}"
        }
        return s
    }
}

extension TreeNode where T: Equatable {

    func search(value: T) -> TreeNode? {
        // Basecase
        if self.value == value {
            return self
        }
        for child in children {
            // Recursive is important here.
            if let found = child.search(value: value) {
                return found
            }
        }
        return nil
    }
}
