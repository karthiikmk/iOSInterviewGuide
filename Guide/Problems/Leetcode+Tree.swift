//
//  Leetcode+Tree.swift
//  Algorithms
//
//  Created by Karthik on 23/03/24.
//

import Foundation

// 𝗘𝗮𝘀𝘆

//1) Binary Tree Inorder Traversal : https://lnkd.in/dkeNpXsj
//
//2) Same Tree : https://lnkd.in/dCcyEZYj
//
//3) Symmetric Tree : https://lnkd.in/dxmTjz2r
//
//4) Maximum Depth of Binary Tree : https://lnkd.in/dwxus9pc
//
//5) Convert Sorted Array to Binary Search Tree : https://lnkd.in/d4eQfWrZ
//
//6) Balanced Binary Tree : https://lnkd.in/diKJ3nYe
//
//7) Minimum Depth of Binary Tree : https://lnkd.in/d8qdZQ2C
//
//8) Path Sum : https://lnkd.in/dRrFXyTY
//
//9) Binary Tree Preorder Traversal : https://lnkd.in/dkq5HeWc
//
//10) Binary Tree Postorder Traversal : https://lnkd.in/dupicbpU
//
//11) Count Complete Tree Nodes : https://lnkd.in/dXHUrAZ2
//
//12) Invert Binary Tree : https://lnkd.in/dtyv46Yw
//
//𝗠𝗲𝗱𝗶𝘂𝗺
//
//13) Unique Binary Search Trees : https://lnkd.in/dj2GEne2
//
//14) Validate Binary Search Tree : https://lnkd.in/dH9Gpi2s
//
//15) Binary Tree Level Order Traversal : https://lnkd.in/dip9mHNR
//
//16) Binary Tree Zigzag Level Order Traversal : https://lnkd.in/dGjwwq-R
//
//17) Construct Binary Tree from Preorder and Inorder Traversal : https://lnkd.in/dB-7AAqE
//
//18) Construct Binary Tree from Inorder and Postorder Traversal : https://lnkd.in/djrJJDyk
//
//19) Binary Tree Level Order Traversal II : https://lnkd.in/dd-8jdDx
//
//20) Convert Sorted List to Binary Search Tree : https://lnkd.in/dZ_ddrt6
//
//21) Path Sum II : https://lnkd.in/dXDcEZAZ
//
//22) Populating Next Right Pointers in Each Node : https://lnkd.in/dGAFANRi
//
//23) Sum Root to Leaf Numbers : https://lnkd.in/d_xiMCNk
//
//24) Binary Tree Right Side View : https://lnkd.in/dk6-QQs6
//
//25) Kth Smallest Element in a BST : https://lnkd.in/dWAPABQ3


/*
 12. Check if a binary tree is a binary search tree (BST).
 13. Print all leaf nodes of a binary tree.
 14. Reverse a binary tree.
 15. Find the height of a binary tree.
*/

extension LeetCode {

    class TreeNode: CustomStringConvertible {

        var val: Int
        var left: TreeNode?
        var right: TreeNode?
        init() { self.val = 0; self.left = nil; self.right = nil; }
        init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
        init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
            self.val = val
            self.left = left
            self.right = right
        }

        var isLeaf: Bool {
            left == nil && right == nil
        }

        var description: String {
            var s = ""
            if let left = self.left {
                s += "(\(left.description)) <- "
            }
            s += "\(val)"
            if let right = self.right {
                s += " -> \(right.description)"
            }
            return s
        }
    }

    func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
        guard !nums.isEmpty else { return nil }

        func _buildBST(for array: inout [Int], startIndex: Int, endIndex: Int) -> TreeNode? {
            // BaseCondition, checking for valid index
            guard startIndex < endIndex else { return nil }

            let midIndex = (startIndex + (endIndex - startIndex)) / 2
            let rootNode = TreeNode(array[midIndex])
            rootNode.left = _buildBST(for: &array, startIndex: 0, endIndex: midIndex - 1)
            rootNode.right = _buildBST(for: &array, startIndex: midIndex + 1, endIndex: endIndex)
            return rootNode
        }
        var array = nums
        return _buildBST(for: &array, startIndex: 0, endIndex: nums.count - 1)
    }

    func sortedListToBST(_ head: ListNode?) -> TreeNode? {

        var array = [Int]()
        var currentNode = head
        while currentNode != nil {
            array.append(currentNode!.val)
            currentNode = currentNode?.next
        }

        return sortedArrayToBST(array)
    }

    /// Draw and learn more deeper 
    func maxDepth(_ root: TreeNode?) -> Int {
        guard let root else { return 0 }
        return max(maxDepth(root.left), maxDepth(root.right)) + 1
    }

    func minDepth(_ root: TreeNode?) -> Int {
        guard let root else { return 0 }
        return min(minDepth(root.left), minDepth(root.right)) + 1
    }

    /// Checking the given sum is matching from root to leaf.
    func hasPathSum(_ root: TreeNode?, _ sum: Int) -> Bool {
        // Basecondition
        guard let root else { return false }

        var summation = sum
        summation -= root.val
        /// Logic Implementation 
        if root.isLeaf {
            return (summation == 0)
        }
        return hasPathSum(root.left, summation) || hasPathSum(root.right, summation)
    }

    /// Given the root of a binary search tree and an integer k, return true if there exist two elements
    /// in the BST such that their sum is equal to k, or false otherwise.
    func findTarget(_ root: TreeNode?, _ k: Int) -> Bool {
        /// Recurrent function
        func _dfs(_ root: TreeNode?, _ k: Int, nodes: inout Set<Int>) -> Bool {
            guard let node = root else { return false }
            /// BaseCondition
            if nodes.contains(k - node.val) {
                return true
            }
            nodes.insert(node.val)
            return _dfs(node.left, k, nodes: &nodes) || _dfs(node.right, k, nodes: &nodes)
        }
        var nodes = Set<Int>()
        return _dfs(root, k, nodes: &nodes)
    }

    /// Idea is to use two stacks for comparsion
    func isSameTree(_ p: TreeNode?, _ q: TreeNode?) -> Bool {

        var pStack = [TreeNode]()
        var qStack = [TreeNode]()

        if let p { pStack.append(p) } // Important
        if let q { qStack.append(q) } // Important

        while !pStack.isEmpty && !qStack.isEmpty {
            let pNode = pStack.removeLast() // important
            let qNode = qStack.removeLast() // important
            /// BaseCondition
            guard pNode.val == qNode.val else {
                return false
            }
            /// right append
            if let pRightNode = pNode.right {
                pStack.append(pRightNode)
            }
            if let qRightNode = qNode.right {
                qStack.append(qRightNode)
            }
            guard pStack.count == qStack.count else {
                return false
            }
            /// left append
            if let pLeftNode = pNode.left {
                pStack.append(pLeftNode)
            }
            if let qLeftNode = qNode.left {
                qStack.append(qLeftNode)
            }
            guard pStack.count == qStack.count else {
                return false
            }
            // loop conitinues for the next iteration.
        }

        return false
    }

    /// Symmetric Tree
    ///
    /// Given the root of a binary tree, check whether it is a mirror of itself (i.e., symmetric around its center).
    ///
    /// Idea is comparing Left Node left == Rigth Node right
    func isSymmetric(_ root: TreeNode?) -> Bool {
        
        /// Start with immediate left and right
        /// Intentionally kept as optional, as some nodes left or right child can be nil.
        var stack: [TreeNode?] = [root?.left, root?.right]

        while !stack.isEmpty {
            let left = stack.removeLast()
            let right = stack.removeLast()

            /// Applicable for nodes where any one child is available
            if left == nil && right == nil { continue }
            ///
            guard let leftNode = left, let rightNode = right else { return false }
            // BaseCondition
            guard leftNode.val == rightNode.val else { return false }

            /// First Node Left == Second Node Right
            stack.append(leftNode.left)
            stack.append(rightNode.right)

            stack.append(leftNode.right)
            stack.append(rightNode.left)
        }
        return true
    }

    /// Idea is brute force recurrent traversal
    func binaryTreePaths(_ root: TreeNode?) -> [String] {

        /// Depth first pre-order traversal
        func dfs(_ node: TreeNode?, path: String, paths: inout [String]) {
            /// BaseCondition
            guard let node else { return }
            /// Logic Implementation
            if node.isLeaf {
                paths.append("\(path)\(node.val)")
                return
            }
            if let left = node.left { // 1 ->
                dfs(left, path: "\(path)\(node.val)->", paths: &paths)
            }
            if let right = node.right { // 1 -> 2
                dfs(right, path: "\(path)\(node.val)->", paths: &paths)
            }
        }

        var paths = [String]()
        dfs(root, path: "", paths: &paths)
        return paths
    }

    /// Binary Tree Inorder Traversal
    ///
    /// OJ: https://leetcode.com/problems/binary-tree-inorder-traversal/description/
    func inorderTraversal(_ root: TreeNode?) -> [Int] {

        func _inOrderTraversal(_ node: TreeNode?, paths: inout [Int]) {
            // BaseCondition
            guard let node else { return }
            _inOrderTraversal(node.left, paths: &paths)
            paths.append(node.val)
            _inOrderTraversal(node.right, paths: &paths)
        }

        var paths = [Int]()
        _inOrderTraversal(root, paths: &paths)
        return paths
    }

    func preorderTraversal(_ root: TreeNode?) -> [Int] {

        func _preOrderTraversal(_ node: TreeNode?, paths: inout [Int]) {
            // BaseCondition
            guard let node else { return }
            paths.append(node.val)
            _preOrderTraversal(node.left, paths: &paths)
            _preOrderTraversal(node.right, paths: &paths)
        }

        var paths = [Int]()
        _preOrderTraversal(root, paths: &paths)
        return paths
    }

    /// Idea is to use stack for comparision
    func preOrderTraverse(for root: BinaryTreeNode<Int>) -> [Int] {

        var array: [Int] = [Int]()
        let stack = Stack<BinaryTreeNode<Int>>() // enqueu dequeue happens at the last position
        stack.push(root) // settign the root into stack

        /// - NOTE: Kind of recurrsion
        while !stack.isEmpty {
            let last = stack.pop()!
            array.append(last.value)
            /// Right
            if let right = last.right {
                stack.push(right)
            }
            // Left left at the last because, enqueue happen at the last.
            // for preorder, we need all the left to be printed first
            if let left = last.left {
                stack.push(left)
            }
        }
        return array
    }

    /// The idea is to use for loop to create levels array.
    /// Traversing from top to bottom
    func levelOrder(_ root: TreeNode?) -> [[Int]] {
        guard let root else { return [] }

        var result = [[Int]]()
        result.append([root.val])
        var queue: [TreeNode] = [root]

        while !queue.isEmpty {
            var levelsArray = [Int]()
            /// Iterating over numbers of count in queue to group the values.
            for _ in 0..<queue.count {
                let node = queue.removeFirst()
                levelsArray.append(node.val)
                if let left = node.left { levelsArray.append(left.val) } // Imp
                if let right = node.right { levelsArray.append(right.val) } // Imp
            }
            result.append(levelsArray)
        }

        return result
    }

    /// Balanced Binary Tree
    /// The balance factor shouldn't be more than 1
    ///
    /// OJ: https://leetcode.com/problems/balanced-binary-tree/
    ///
    func isBalanced(_ root: TreeNode?) -> Bool {
        /// Empty tree considered as balanced
        guard let root else { return true }

        func maxHeight(_ node: TreeNode?) -> Int {
            guard let node else { return 0 }
            return 1 + max(maxHeight(node.left), maxHeight(node.right))
        }

        let heightDifference = abs(maxHeight(root.left) - maxHeight(root.right))
        /// In some scenario, height diff can be less than 1, but the tree might have not balanced.
        /// So recurrsively checking for balanced condition in each level
        return heightDifference <= 1 && isBalanced(root.left) && isBalanced(root.right)
    }

    /// Kind of traversal only
    func countNodes(_ root: TreeNode?) -> Int {
        /// BaseCondition
        guard let node = root else { return 0 }
        return countNodes(node.left) + 1 + countNodes(node.right)
    }

    func invertTree(_ root: TreeNode?) -> TreeNode? {
        /// BaseCondition
        guard let node = root else { return nil }
        let leftSubTree = invertTree(node.left)
        let rightSubTree = invertTree(node.right)
        // Swapping
        node.left = rightSubTree
        node.right = leftSubTree
        return node
    }

    func rightSideView(_ root: TreeNode?) -> [Int] {

        var result = [Int]()
        var currentNode = root

        while currentNode != nil {
            result.append(currentNode!.val)
            currentNode = currentNode?.right
        }
        return result
    }

    /// A+, L, R
    /// Idea is to apply binary search mechanism using min & max
    func isValidBST(_ root: TreeNode?) -> Bool {

        func _isValidBST(_ node: TreeNode?, min: Int?, max: Int?) -> Bool {
            /// Empty tree considered as balanced
            guard let node else { return true }
            /// BaseCondition
            if let min, node.val <= min { return false }
            if let max, node.val >= max { return false }

            return _isValidBST(node.left, min: min, max: root?.val) && _isValidBST(node.right, min: root?.val, max: max)
        }

        return _isValidBST(root, min: nil, max: nil)
    }

    // A+,L, R
    func rangeSumBST(_ root: TreeNode?, _ low: Int, _ high: Int) -> Int {

        var result: Int = 0 // Initial Sum
        func _inorderTraverse(_ node: TreeNode?) {
            /// BaseCondition
            guard let node = node else { return }
            _inorderTraverse(node.left)
            if node.val >= low && node.val <= high {
                result += node.val
            }
            _inorderTraverse(node.right)
        }
        _inorderTraverse(root)
        return result
    }

    /// Idea is to use inorder traversal to find the difference,
    /// as this traversal taps all the nodes once
    func getMinimumDifference(_ root: TreeNode?) -> Int {

        var difference: Int = Int.max
        var previousValue: Int = 0

        func _inOrderTraverse(_ node: TreeNode?) {
            /// BaseCondition
            guard let node else { return }
            _inOrderTraverse(node.left)
            difference = min(difference, abs(node.val - previousValue))
            previousValue = node.val
            _inOrderTraverse(node.right)
        }

        _inOrderTraverse(root)
        return difference
    }
}
