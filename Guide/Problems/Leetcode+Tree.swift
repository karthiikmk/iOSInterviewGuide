//
//  Leetcode+Tree.swift
//  Algorithms
//
//  Created by Karthik on 23/03/24.
//

import Foundation

// 𝗘𝗮𝘀𝘆

//1) Binary Tree Inorder Traversal : https://lnkd.in/dkeNpXsj
//2) Same Tree : https://lnkd.in/dCcyEZYj
//3) Symmetric Tree : https://lnkd.in/dxmTjz2r
//7) Minimum Depth of Binary Tree : https://lnkd.in/d8qdZQ2C
//4) Maximum Depth of Binary Tree : https://lnkd.in/dwxus9pc
//5) Convert Sorted Array to Binary Search Tree : https://lnkd.in/d4eQfWrZ
//6) Balanced Binary Tree : https://lnkd.in/diKJ3nYe
//8) Path Sum : https://lnkd.in/dRrFXyTY
//9) Binary Tree Preorder Traversal : https://lnkd.in/dkq5HeWc
//10) Binary Tree Postorder Traversal : https://lnkd.in/dupicbpU
//12) Invert Binary Tree : https://lnkd.in/dtyv46Yw -
//11) Count Complete Tree Nodes : https://lnkd.in/dXHUrAZ2
//15) Binary Tree Level Order Traversal : https://lnkd.in/dip9mHNR
//20) Convert Sorted List to Binary Search Tree : https://lnkd.in/dZ_ddrt6
//24) Binary Tree Right Side View : https://lnkd.in/dk6-QQs6

//𝗠𝗲𝗱𝗶𝘂𝗺
//
//13) Unique Binary Search Trees : https://lnkd.in/dj2GEne2
//14) Validate Binary Search Tree : https://lnkd.in/dH9Gpi2s
//16) Binary Tree Zigzag Level Order Traversal : https://lnkd.in/dGjwwq-R
//17) Construct Binary Tree from Preorder and Inorder Traversal : https://lnkd.in/dB-7AAqE
//18) Construct Binary Tree from Inorder and Postorder Traversal : https://lnkd.in/djrJJDyk
//19) Binary Tree Level Order Traversal II : https://lnkd.in/dd-8jdDx
//21) Path Sum II : https://lnkd.in/dXDcEZAZ
//22) Populating Next Right Pointers in Each Node : https://lnkd.in/dGAFANRi
//23) Sum Root to Leaf Numbers : https://lnkd.in/d_xiMCNk
//25) Kth Smallest Element in a BST : https://lnkd.in/dWAPABQ3

/*
 12. Check if a binary tree is a binary search tree (BST).
 13. Print all leaf nodes of a binary tree.
 14. Reverse a binary tree.
 15. Find the height of a binary tree. - dfs
*/

extension LeetCode {

    class TreeNode: CustomStringConvertible {
        var value: Int
        var left: TreeNode?
        var right: TreeNode?
        init() { self.value = 0; self.left = nil; self.right = nil; }
        init(_ value: Int) { self.value = value; self.left = nil; self.right = nil; }
        init(_ value: Int, _ left: TreeNode?, _ right: TreeNode?) {
            self.value = value
            self.left = left
            self.right = right
        }

        var isLeaf: Bool { left == nil && right == nil }

        /// NOTE: BST insert
        func insert(value: Int) {
            if value == self.value {
                return
            } else if value < self.value {
                if let left = self.left {
                    left.insert(value: value)
                } else {
                    self.left = TreeNode(value)
                }
            } else {
                if let right = self.right {
                    right.insert(value: value)
                } else {
                    self.right = .init(value)
                }
            }
        }

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

    func runTree() {
        // convertUnsortedArrayToBSTTree()
        let node: TreeNode = .init(10)
        node.left = .init(9, .init(8), .init(7))
        node.right = .init(11, .init(12), .init(22))
        // convertBSTTreeToArray(node)
        levelOrderTraversal(for: node)
    }
}

extension LeetCode {

    /// NOTE: This is the basic of all
    /// Array must be sorted array.
    /// NOTE: on valid index check, = is very important.
    func buildTree(_ array: [Int], startIndex: Int, endIndex: Int) -> TreeNode? {
        guard startIndex <= endIndex else { return nil } // **** important
        let middleIndex = startIndex + (endIndex - startIndex) / 2
        let middleValue = array[middleIndex]
        let node: TreeNode = .init(middleValue)
        node.left = buildTree(array, startIndex: startIndex, endIndex: middleIndex - 1)
        node.right = buildTree(array, startIndex: middleIndex + 1, endIndex: endIndex)
        return node
    }

    /// NOTE: Array must be sorted
    /// Hint: As the array is already sorted, use divide and conquer
    func convertSortedArrayToBSTTree(_ array: [Int] = [8,10,12,16,18,25,20]) -> TreeNode? {
        let node = buildTree(array, startIndex: 0, endIndex: array.count - 1)
        // debugPrint(node)
        return node
    }

    /// NOTE: Here we can use natural way of constructing tree using insert api.
    func convertUnsortedArrayToBSTTree(_ array: [Int] = [3,2,4,2,1]) -> TreeNode? {
        guard !array.isEmpty else { return nil }

        // for now takign the first element as the start
        let node = TreeNode(array[0])
        array.forEach { node.insert(value: $0) }
        print(node)
        return node
    }

    /// NOTE: Linked list must be sorted.
    func convertLinkedListToBST(_ head: ListNode?) -> TreeNode? {
        var array = [Int]()
        var currentNode = head
        while currentNode != nil {
            array.append(currentNode!.val)
            currentNode = currentNode?.next
        }
        return convertSortedArrayToBSTTree(array)
    }

    /// NOTE: Inorder travseral is nothing but sorted array
    /// Both this and inorderTraversal are same
    func convertBSTTreeToArray(_ root: TreeNode) -> [Int] {
        var array = [Int]()
        func inOrderTraversal(_ node: TreeNode?) {
            guard let node else { return } // Basecondition
            inOrderTraversal(node.left)
            array.append(node.value)
            inOrderTraversal(node.right)
        }
        inOrderTraversal(root)
        print(array)
        return array
    }
}

// MARK: - Traversals
extension LeetCode {

    /// Binary Tree Inorder Traversal
    ///
    /// OJ: https://leetcode.com/problems/binary-tree-inorder-traversal/description/
    func inorderTraversal(_ root: TreeNode?) -> [Int] {
        
        func _inOrderTraversal(_ node: TreeNode?, array: inout [Int]) {
            guard let node else { return } // BaseCondition
            _inOrderTraversal(node.left, array: &array)
            array.append(node.value)
            _inOrderTraversal(node.right, array: &array)
        }

        var array = [Int]()
        _inOrderTraversal(root, array: &array)
        return array
    }

    func preorderTraversal(_ root: TreeNode?) -> [Int] {

        func _preOrderTraversal(_ node: TreeNode?, paths: inout [Int]) {
            // BaseCondition
            guard let node else { return }
            paths.append(node.value)
            _preOrderTraversal(node.left, paths: &paths)
            _preOrderTraversal(node.right, paths: &paths)
        }

        var paths = [Int]()
        _preOrderTraversal(root, paths: &paths)
        return paths
    }

    /// Idea is to use stack for comparision
    /// Note: Whenever encounter preorder, think about stack
    func preOrderTraverse(for root: TreeNode) -> [Int] {

        /// NOTE: Idea of the preorder traversal is
        /// Visit node, go into left side, then right side
        ///
        var array: [Int] = [Int]()
        let stack = Stack<TreeNode>()
        stack.push(root)

        while !stack.isEmpty {
            let last = stack.pop()!
            array.append(last.value) // Visiting node
            /// Right
            if let right = last.right {
                stack.push(right) // Going into the right side
            }
            // Left at the last because, enqueue happen at the last.
            // for preorder, we need all the left to be printed first
            if let left = last.left {
                stack.push(left) // Going into the left side
            }
        }
        return array // PreOrder traversed array.
    }

    /// The idea is to use for loop to create levels array.
    /// Traversing from top to bottom
    /// Level order also called as Breadth first search (BFS)
    func levelOrderTraversal(for root: TreeNode) -> [[Int]] {

        // FIFO
        class Queue<T> {

            var array = [T]()
            var isEmpty: Bool { array.isEmpty }
            var count: Int { array.count }

            func enqueue(value: T) { 
                array.append(value)
            }

            func dequeue() -> T? {
                guard !array.isEmpty else { return nil }
                return array.removeFirst()
            }
        }

        var result = [[Int]]()
        var queue = Queue<TreeNode>() // stack
        queue.enqueue(value: root) // push

        while !queue.isEmpty {
            var levelsArray = [Int]()
            for _ in 0..<queue.count {
                let node = queue.dequeue()
                levelsArray.append(node!.value)

                if let left = node?.left {
                    queue.enqueue(value: left)
                }
                if let right = node?.right {
                    queue.enqueue(value: right)
                }
            }
            result.append(levelsArray)
        }
        print(result)
        return result
    }
}

// MARK: - Search
extension LeetCode {

    /// NOTE: DFS (pre-order)
    func dfs(_ root: TreeNode?) {
        // Basecase
        guard let root = root else { return }

        // Pre-order: Process the node first
        print(root.value)

        // Recursively process the left and right children
        dfs(root.left)
        dfs(root.right)
    }

    /// NOTE: DFS (Pre-Order)
    func dfsIteratively(_ root: TreeNode?) {
        guard let root else { return }

        var stack = Stack<TreeNode>()
        stack.push(root)

        while !stack.isEmpty {
            let node = stack.pop()
            // do your stuffs here
            if let right = node?.right { stack.push(right) }
            if let left = node?.left { stack.push(left) }
        }
    }

    /// NOTE: BFS (level-order) - Queue
    /// can be done iteratively (using queue)
    func bfs(_ root: TreeNode?) -> [Int] {
        guard let root = root else { return [] }

        var result = [Int]()
        var queue: [TreeNode] = [root]  // Queue to store nodes to be processed

        while !queue.isEmpty {
            let node = queue.removeFirst()  // Dequeue the first node
            result.append(node.value)       // Process the current node

            // Enqueue left and right children of the current node, if they exist
            if let leftChild = node.left {
                queue.append(leftChild)
            }
            if let rightChild = node.right {
                queue.append(rightChild)
            }
        }

        return result
    }
}

extension LeetCode {

    /// Draw and learn more deeper 
    func maxDepth(_ root: TreeNode?) -> Int {
        guard let root else { return 0 } // Basecase
        return max(maxDepth(root.left), maxDepth(root.right)) + 1
    }

    /// NOTE: MinDepth - RootNode to nearest leafNode
    func minDepth(_ root: TreeNode?) -> Int {
        guard let root else { return 0 } // Basecase

        /// We need to handle the case where, left child is nil, and right child is available.
        /// Viseversa to be handled as well. 
        if root.left == nil {
            return minDepth(root.right) + 1
        } else if root.right == nil {
            return minDepth(root.left) + 1
        } else {
            return min(minDepth(root.left), minDepth(root.right)) + 1
        }
    }

    /// Height: Number of edges in the longest path from the given node to a leaf node
    /// Hint: DFS
    func maxHeight(_ node: TreeNode?) -> Int {
        guard let node else { return 0 } // BaseCase
        return 1 + max(maxHeight(node.left), maxHeight(node.right))
    }

    /// Hint: DFS
    /// As it touches all the nodes once
    func countNodes(_ root: TreeNode?) -> Int {
        /// BaseCondition
        guard let node = root else { return 0 }
        return 1 + countNodes(node.left) + countNodes(node.right)
    }

    /// NOTE: Return array of right side nodes.
    func rightSideView(_ root: TreeNode?) -> [Int] {

        var result = [Int]()
        var currentNode = root

        while currentNode != nil {
            result.append(currentNode!.value)
            currentNode = currentNode?.right
        }
        return result
    }

    /// NOTE: Take one node, swap left and right node of that node.
    /// Doing it recursivelly will invert the entire tree
    /// Hint: DFS
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

    /// A+, L, R
    /// Idea is to apply binary search mechanism using min & max
    /// BST is valid, only if its meeting its constraints
    /// Constraint: left node value should be less than its parent node value
    /// right node value should be greater than its parent value
    /// Hint: DFS
    func isValidBST(_ root: TreeNode?) -> Bool {

        func isValid(_ node: TreeNode?, min: Int? = nil, max: Int? = nil) -> Bool {
            /// BaseCondition
            /// Empty tree considered as balanced
            guard let node else { return true }

            // Not required that all nodes should have both min and max.
            if let min, node.value <= min { return false }
            if let max, node.value >= max { return false }

            return isValid(node.left, min: min, max: node.value)
            && isValid(node.right, min: node.value, max: max)
        }

        /// Initial we wont be knowing min and max for the given / root node.
        /// So assuming its nil.
        return isValid(root)
    }

    /// Balanced Binary Tree
    /// The balance factor shouldn't be more than 1
    ///
    /// OJ: https://leetcode.com/problems/balanced-binary-tree/
    /// IDEA: Take each node, and think in that perspective.
    /// Balance factor should be calculated in each level in order to get the right results.
    /// Hint: DFS
    func isBalanced(_ node: TreeNode?) -> Bool {
        /// BaseCase
        /// Empty tree considered as balanced
        guard let node else { return true }

        let balanceFactor = abs(maxHeight(node.left) - maxHeight(node.right))
        /// In some scenario, height diff can be less than 1, but the tree might have not balanced.
        /// So recurrsively checking for balanced condition in each level
        return balanceFactor <= 1 && isBalanced(node.left) && isBalanced(node.right)
    }

    /// Idea is to use two stacks for comparsion
    /// Hint: DFS using stack
    func isSameTree(_ p: TreeNode?, _ q: TreeNode?) -> Bool {

        var pStack = [TreeNode]()
        var qStack = [TreeNode]()

        if let p { pStack.append(p) } // Important
        if let q { qStack.append(q) } // Important

        while !pStack.isEmpty && !qStack.isEmpty {
            let pNode = pStack.removeLast() // important
            let qNode = qStack.removeLast() // important
            /// BaseCondition
            guard pNode.value == qNode.value else {
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
        }
        return true
    }

    /// Given the root of a binary search tree and an integer k, return true if there exist two elements
    /// in the BST such that their sum is equal to k, or false otherwise.
    /// Hint: DFS
    func findTarget(_ root: TreeNode?, _ k: Int) -> Bool {
        /// Recurrent function
        var nodes = Set<Int>()
        func _dfs(_ root: TreeNode?) -> Bool {
            /// BaseCondition
            guard let node = root else { return false }
            if nodes.contains(k - node.value) { return true }
            nodes.insert(node.value)
            return _dfs(node.left) || _dfs(node.right)
        }
        return _dfs(root)
    }

    func findTargetUsingStack(_ root: TreeNode?, _ k: Int) -> Bool {
        guard let root else { return false }

        var visiteds = Set<Int>()
        var stack = Stack<TreeNode>()
        stack.push(root)

        while !stack.isEmpty {
            let node = stack.pop()
            let difference = k - node!.value
            if visiteds.contains(difference) {
                return true
            }
            visiteds.insert(node!.value)

            if let right = node?.right { stack.push(right) }
            if let left = node?.left { stack.push(left) }
        }
        return false
    }

    /// Checking the given sum is matching from root to leaf.
    /// Kind of depth first search.
    /// Idea is to subtrack node value form the sum
    /// whichever the leaf node meeting 0, then we found the path with given target
    /// Hint: DFS, if there is path related, then blindly go with dfs
    func hasPathSum(_ root: TreeNode?, _ sum: Int) -> Bool {
        // Basecondition
        guard let root else { return false }

        /// visiting Node
        var summation = sum
        summation -= root.value
        /// Logic Implementation
        if root.isLeaf { return summation == 0 }
        return hasPathSum(root.left, summation) || hasPathSum(root.right, summation)
    }

    func findAllTheLeadNodes(_ tree: TreeNode?) -> [Int] {
        guard let node = tree else { return [] }

        var leafs = [Int]()
        func dfs(_ node: TreeNode?) {
            guard let node else { return }
            if node.isLeaf {
                leafs.append(node.value)
                return
            }
            dfs(node.left)
            dfs(node.right)
        }
        dfs(node)
        print("Leafs: \(leafs)")
        return leafs
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
            guard leftNode.value == rightNode.value else { return false }

            /// First Node Left == Second Node Right
            stack.append(leftNode.left)
            stack.append(rightNode.right)

            stack.append(leftNode.right)
            stack.append(rightNode.left)
        }
        return true
    }

    /// Idea is brute force recurrent traversal
    func findAllTreePaths(_ root: TreeNode?) -> [String] {

        var paths = [String]()
        /// Depth first pre-order traversal
        func dfs(_ node: TreeNode?, path: String) {
            /// BaseCondition
            guard let node else { return }
            /// Logic Implementation
            if node.isLeaf {
                paths.append("\(path)\(node.value)") // not adding any arrows.
                return
            }
            dfs(node.left, path: "\(path)\(node.value)->")
            dfs(node.right, path: "\(path)\(node.value)->")
        }
        dfs(root, path: "")
        return paths
    }
}

// MARK: - inorder traversal sums
extension LeetCode {

    /// Finding the minium difference between two nodes.
    /// Idea is to use inorder traversal to find the difference,
    /// as this traversal taps all the nodes once.
    /// Hint: inorder traversal as it gives sorted form. so calculating difference is easy.
    func getMinimumDifference(_ root: TreeNode?) -> Int {

        var difference: Int = Int.max
        var previousValue: Int = 0 // Important

        func _inOrderTraverse(_ node: TreeNode?) {
            /// BaseCondition
            guard let node else { return }
            /// Left traversal
            _inOrderTraverse(node.left)
            // Visting Node
            difference = min(difference, abs(node.value - previousValue))
            previousValue = node.value
            /// Right traversal
            _inOrderTraverse(node.right)
        }

        _inOrderTraverse(root)
        return difference
    }

    /// NOTE: Find sum between range
    /// inorder is needed as its sorted. applying range condition is easy on sorted form.
    func rangeSumBST(_ root: TreeNode?, _ low: Int, _ high: Int) -> Int {

        var result: Int = 0 // Initial Sum
        func _inorderTraverse(_ node: TreeNode?) {
            /// BaseCondition
            guard let node = node else { return }
            _inorderTraverse(node.left)
            if node.value >= low && node.value <= high {
                result += node.value
            }
            _inorderTraverse(node.right)
        }
        _inorderTraverse(root)
        return result
    }
}
