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
            if value < self.value {
                if let left = self.left {
                    left.insert(value: value)
                } else {
                    self.left = TreeNode(value)
                }
            } else if value > self.value {
                if let right = self.right {
                    right.insert(value: value)
                } else {
                    self.right = .init(value)
                }
            } else {
                /// Duplicate can't be inserted.
            }
        }

        var description: String {
            var s = ""
            // Format the left subtree
            if let left = self.left {
                s += "(\(left.description)) <- "
            } else {
                s += "(x) <- "
            }
            // Add the current node value
            s += "\(value)"

            // Format the right subtree
            if let right = self.right {
                s += " -> (\(right.description))"
            } else {
                s += " -> (x)"
            }
            return s
        }
    }

    /// Think about Queue for level order
    /// Think about stack for depth first search (dfs)
    /// Depth: from root -> specific node
    /// Height: specific node -> leaf node
    /// Balance factor: difference between the height of its left subtree and the height of its right subtree.
    func runTree() {
        let tree = convertArrayToBSTTree([44, 17, 32, 78, 50, 88])
        inorderTraversal(tree)
        reverseInorderTraversal(tree)
    }
}

// MARK: - Collection to BST
extension LeetCode {

    /// NOTE: This is the basic of all
    /// Array must be sorted array.
    /// NOTE: on valid index check, = is very important.
    fileprivate func buildTree(_ array: [Int], startIndex: Int, endIndex: Int) -> TreeNode? {
        guard startIndex <= endIndex else { return nil } // **** important
        let middleIndex = startIndex + (endIndex - startIndex) / 2
        let middleValue = array[middleIndex] // as we created middle node already/
        let node: TreeNode = .init(middleValue)
        node.left = buildTree(array, startIndex: startIndex, endIndex: middleIndex - 1) // ** (upto middle - 1)
        node.right = buildTree(array, startIndex: middleIndex + 1, endIndex: endIndex) // ** (from middle + 1)
        return node
    }

    /// NOTE: Here we can use natural way of constructing tree using insert api.
    /// Array can be either sorted or unsorted
    func convertArrayToBSTTree(_ array: [Int] = [3,2,4,2,1]) -> TreeNode? {
        guard !array.isEmpty else { return nil }
        let node = TreeNode(array[0]) // customized
        array.forEach { node.insert(value: $0) }
        print("Unsorted Array to BST: \(node)")
        return node
    }

    /// NOTE: Array must be sorted
    /// Step 1: Find the middleIndex (as its sorted array, we can make use of startIndex and endIndex)
    /// Step 2: Keep the smaller elements at left side of middleIndex
    /// Step 3: Keep the larger elements at the right side middle index
    func convertSortedArrayToBSTTree(_ array: [Int] = [8,10,12,16,18,25,20]) -> TreeNode? {
        guard !array.isEmpty else { return nil }
        guard let node = buildTree(array, startIndex: 0, endIndex: array.count - 1) else { return nil }
        print("Sorted Array to BST: \(node)")
        return node
    }

    /// NOTE: Linked list must be sorted.
    func convertLinkedListToBST(_ head: ListNode?) -> TreeNode? {
        var array = [Int]()
        var currentNode = head
        while currentNode != nil {
            array.append(currentNode!.value)
            currentNode = currentNode?.next
        }
        return convertSortedArrayToBSTTree(array)
    }

    /// NOTE: Converting normal tree to BST tree
    /// BST should meet the constraits
    /// Smaller values should be left of its parent, and larger on its parent right.
    func convertTreeToBST(_ root: TreeNode) -> TreeNode? {
        let array = inorderTraversal(root) /// Inorder traversal provides sorted array (but tree is not a bst, so it wont provide)
        let bstTree = buildTree(array, startIndex: 0, endIndex: array.count - 1)
        return bstTree
    }
}

// MARK: - BST to Collection
extension LeetCode {

    /// NOTE: Inorder travseral is nothing but sorted array
    /// As it is BST tree, we should be doing inorder traversal to get the sorted array
    /// Reverse inorder traveral for getting desc sorted array
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

    /// NOTE: BST is already sorted
    func convertBSTTreeToLinkedList(_ root: TreeNode) -> ListNode? {
        let array = convertBSTTreeToArray(root)
        let linkedList = convertArrayToLinkedList(array)
        return linkedList
    }
}

// MARK: - Traversals
extension LeetCode {

    /// Binary Tree Inorder Traversal
    ///
    /// OJ: https://leetcode.com/problems/binary-tree-inorder-traversal/description/
    @discardableResult
    func inorderTraversal(_ root: TreeNode?) -> [Int] {
        var array = [Int]()
        func _inOrderTraversal(_ node: TreeNode?) {
            guard let node else { return } // BaseCondition
            _inOrderTraversal(node.left)
            array.append(node.value)
            _inOrderTraversal(node.right)
        }
        _inOrderTraversal(root)
        print("inorder traversal - \(array)")
        return array
    }

    /// NOTE: This api is more or less equivalent to Descending sorting. 
    @discardableResult
    func reverseInorderTraversal(_ node: TreeNode?) -> [Int] {
        var result = [Int]()
        func _reverseInorderTraversal(_ node: TreeNode?) {
            guard let node else { return }
            _reverseInorderTraversal(node.right)
            result.append(node.value)
            _reverseInorderTraversal(node.left)
        }
        _reverseInorderTraversal(node)
        print("reverse inorder traveral - \(result)")
        return result
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
        let queue = Queue<TreeNode>() // stack
        queue.enqueue(value: root) // push

        while !queue.isEmpty {
            var levels = [Int]()
            for _ in 0..<queue.count {
                let node = queue.dequeue()
                levels.append(node!.value)

                if let left = node?.left { queue.enqueue(value: left) }
                if let right = node?.right { queue.enqueue(value: right) }
            }
            result.append(levels)
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
    func dfsUsingStack(_ root: TreeNode?) {
        guard let root else { return }

        let stack = Stack<TreeNode>()
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
            if let leftChild = node.left { queue.append(leftChild) }
            if let rightChild = node.right { queue.append(rightChild) }
        }

        return result
    }
}

/// For a given node, calculate height and depth
/// Depth: number of connecting edges from given node (specific node) to root node.
/// Height: number of connecting edges from given node to leaf node.
extension LeetCode {
 
    /// Depth: target node -> root node
    /// Idea: Kind of dfs
    func depthOfNode(_ rootNode: TreeNode, _ targetNode: TreeNode) -> Int {
        
        func _depthOfNode(_ currentNode: TreeNode?, _ targetNode: TreeNode, _ depth: Int) -> Int? {
            guard let currentNode else { return nil }
            /// If value matches, then we found the node (as bst wont have duplicates)
            if currentNode.value == targetNode.value { return depth }
            if let leftDepth = _depthOfNode(currentNode.left, targetNode, depth + 1) { return leftDepth }
            if let rightDepth = _depthOfNode(currentNode.right, targetNode, depth + 1) { return rightDepth }
            return nil
        }
        return _depthOfNode(rootNode, targetNode, 0) ?? 0
    }
    
    /// Height: target node -> leaf node
    /// going deeper till the leaf from the given node.
    /// the same applicable for calculating the max height as well.
    func heigthOfNode(_ node: TreeNode?) -> Int {
        guard let node else { return 0 }
        return 1 + max(heigthOfNode(node.left), heigthOfNode(node.right))
    }
}

extension LeetCode {
    
    /// Draw and learn more deeper (same as height)
    /// distance from the `root node` to that `specific node`
    /// measured in terms of the number of edges
    /// MaxDepth: leaf (longest path) to root
    func maxDepth(_ root: TreeNode?) -> Int {
        guard let root else { return 0 } // Basecase
        return max(maxDepth(root.left), maxDepth(root.right)) + 1
    }

    /// NOTE: MinDepth - from `rootNode` to `nearest leafNode`
    /// While calcuclating min depth we should consider the `nil` as well **
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

    /// Height: Number of edges in the `longest path` from the `given node` to a `leaf node`
    /// How many stages we got in the tree.
    /// Hint: DFS
    func maxHeight(_ node: TreeNode?) -> Int {
        guard let node else { return 0 } // BaseCase
        return 1 + max(maxHeight(node.left), maxHeight(node.right)) // ** max, not sum
    }

    /// Hint: DFS (visiting node, left, right)
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

    /// Idea is to use two stacks for comparsion
    /// Hint: DFS using stack
    func isSameTree(_ p: TreeNode?, _ q: TreeNode?) -> Bool {

        let pStack = Stack<TreeNode>()
        let qStack = Stack<TreeNode>()

        if let p { pStack.push(p) } // Important
        if let q { qStack.push(q) } // Important

        while !pStack.isEmpty && !qStack.isEmpty {
            if let pNode = pStack.pop(), let qNode = qStack.pop() {
                /// BaseCondition
                if pNode.value != qNode.value { return false } // ***
                /// right append
                if let pRightNode = pNode.right { pStack.push(pRightNode) }
                if let qRightNode = qNode.right { qStack.push(qRightNode) }
                if pStack.count != qStack.count { return false }
                /// left append
                if let pLeftNode = pNode.left { pStack.push(pLeftNode) }
                if let qLeftNode = qNode.left { qStack.push(qLeftNode) }
                if pStack.count != qStack.count { return false }
            }
        }
        return true
    }

    /// Given the root of a binary search tree and an integer k, return true if there exist two elements
    /// in the BST such that their sum is equal to k, or false otherwise.
    /// Hint: DFS
    func findSum(_ root: TreeNode?, _ k: Int) -> Bool {
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
        let stack = Stack<TreeNode>()
        stack.push(root)

        while !stack.isEmpty {
            let node = stack.pop()!
            let difference = k - node.value
            if visiteds.contains(difference) { return true }
            visiteds.insert(node.value)

            if let right = node.right { stack.push(right) }
            if let left = node.left { stack.push(left) }
        }
        return false
    }

    func findAllTheLeadNodes(_ tree: TreeNode?) -> [Int] {
        guard let node = tree else { return [] }

        var leafs = [Int]()
        func dfs(_ node: TreeNode?) {
            guard let node else { return }
            ///
            if node.isLeaf { leafs.append(node.value) }
            ///
            dfs(node.left)
            dfs(node.right)
        }
        dfs(node)
        print("Leafs: \(leafs)")
        return leafs
    }

    /// Step1: dfs
    /// Step2: use path variable
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

// - MARK: Recurrance
extension LeetCode {
    
    /// NOTE: Take one node, swap left and right node of that node.
    /// Doing it recursivelly will invert the entire tree
    /// Hint: DFS
    func invertTree(_ root: TreeNode?) -> TreeNode? {
        /// BaseCondition
        guard let node = root else { return nil }
        let leftSubTree = invertTree(node.left) // ** important
        let rightSubTree = invertTree(node.right) // ** imporant
        // Swapping
        node.left = rightSubTree
        node.right = leftSubTree
        return node
    }
    
    /// A+, L, R
    /// Idea is to apply binary search mechanism using `min & max` - imporant
    /// Min and max is very important, as it help for the entire tree validation. not only 3 nodes
    /// BST is valid, only if its meeting its constraints
    /// Constraint: left node value should be less than its parent node value
    /// right node value should be greater than its parent value
    /// Hint: DFS
    /// isValidBST checks the entire tree with global constraints
    func isValidBST(_ root: TreeNode?) -> Bool {
        
        // Not all nodes requires min and max.
        func isValid(_ node: TreeNode?, _ min: Int? = nil, _ max: Int? = nil) -> Bool {
            /// BaseCondition
            guard let node else { return true } // Empty tree considered as balanced
            if let min, node.value <= min { return false }
            if let max, node.value >= max { return false }
            
            return isValid(node.left, min, node.value)
            && isValid(node.right, node.value, max)
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
        guard let node else { return true } /// Empty tree considered as balanced
        let balanceFactor = maxHeight(node.left) - maxHeight(node.right)
        let isValid = balanceFactor >= -1 && balanceFactor <= 1
        if !isValid { return false }
        /// In some scenario, height diff can be less than 1, but the tree might have not balanced.
        /// So recurrsively checking for balanced condition in each level
        return isBalanced(node.left) && isBalanced(node.right)
    }
    
    /// Checking the given sum is matching from root to leaf.
    /// Check is there any path for the given sum.
    /// Kind of depth first search.
    /// Idea is to subtrack node value form the sum
    /// whichever the leaf node meeting 0, then we found the path with given target
    /// Hint: DFS, if there is path related, then blindly go with dfs
    func hasPathSum(_ node: TreeNode?, _ sum: Int) -> Bool {
        // Basecondition
        guard let node else { return false }
        /// visiting Node
        var runningSum = sum
        runningSum -= node.value
        /// Logic Implementation
        if node.isLeaf { return runningSum == 0 }
        return hasPathSum(node.left, runningSum) || hasPathSum(node.right, runningSum)
    }
    
    /// Symmetric Tree
    /// Given the root of a binary tree, check whether it is a `mirror of itself` (i.e., symmetric around its center).
    /// Think about a mirror line on the center
    /// And always think in one level. add recurrance on top of it
    /// ```
    ///          1
    ///         / \
    ///        2   2
    ///       / \ / \
    ///      3  4 4  3
    /// ```
    ///  Step 1: levels should be same.
    ///  Step 2: right and left child should be same.
    ///  Step 3: Compare left and right value
    func isSymmetric(_ root: TreeNode?) -> Bool {
        guard let root else { return true }
        func isMirror(_ left: TreeNode?, _ right: TreeNode?) -> Bool {
            // Base case: both nodes are nil, so they are symmetric (mirror images)
            if left == nil && right == nil { return true }
            // If one is nil and the other isn't, they are not symmetric
            guard let left, let right else { return false }
            // 1. The values at p and q are equal
            // 2. The left subtree of p is a mirror of the right subtree of q
            // 3. The right subtree of p is a mirror of the left subtree of q
            return left.value == right.value
            && isMirror(left.left, right.right) // **
            && isMirror(left.right, right.left)
        }
        return isMirror(root.left, root.right)
    }
}

// MARK: - inorder traversal sums
extension LeetCode {

    /// Finding the minium difference between two nodes.
    /// Idea is to use inorder traversal to find the difference,
    /// as this traversal taps all the nodes once.
    /// Hint: inorder traversal as it gives sorted form. so calculating difference is easy.
    /// by starting `previousValue` from 0 we could able to find the diff
    func getMinimumDifference(_ root: TreeNode?) -> Int {

        var difference: Int = Int.max
        var previousValue: Int = 0 // ** Important (as bst inorder already sorted)

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
            guard let node = node else { return } /// BaseCondition
            _inorderTraverse(node.left)
            ///
            if node.value >= low && node.value <= high {
                result += node.value
            }
            ///
            _inorderTraverse(node.right)
        }
        _inorderTraverse(root)
        return result
    }

    /// NOTE: Nice idea to have a counter to find the kth element
    /// Tree should be BST, so that we can perform inorder traversal to find the kth smallest
    func kthSmallest(root: TreeNode, k: Int) -> Int {
        var result: Int? = nil
        var counter: Int = 0

        func inorderTraversal(node: TreeNode?) {
            guard let node else { return }
            ///
            inorderTraversal(node: node.left)
            /// important, we should update the counter and check the condtion. just take 3 nodes and try to understant from that.
            counter += 1
            if counter == k {
                result = node.value
                return
            }
            ///
            inorderTraversal(node: node.right)
        }
        inorderTraversal(node: root)
        return result ?? -1
    }

    /// NOTE: Inverse inorder traveral will give descending sort
    /// Hint: Reverse inorder traversal
    func kthLargest(root: TreeNode, k: Int) -> Int {
        var result: Int? = nil
        var counter: Int = 0

        func reverseInorderTraversal(node: TreeNode?) {
            guard let node else { return }
            reverseInorderTraversal(node: node.right)
            counter += 1
            if counter == k {
                result = node.value
                return
            }
            reverseInorderTraversal(node: node.left)
        }
        reverseInorderTraversal(node: root)
        return result ?? -1
    }
}

extension LeetCode {

    func rotateLeft(_ node: TreeNode) -> TreeNode? {
        let newNode = node.right
        node.right = node.left
        newNode?.left = node
        return newNode
    }

    func rotateRight(_ node: TreeNode) -> TreeNode? {
        let newRoot = node.left
        node.left = newRoot?.right
        newRoot?.right = node
        return newRoot
    }
}
