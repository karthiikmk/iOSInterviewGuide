//
//  Leetcode+LinkedList.swift
//  Algorithms
//
//  Created by Karthik on 23/03/24.
//

import Foundation

/*
 1. Reverse a linked list.
 2. Find the middle element of a linked list.
 3. Implement a stack using arrays/linked list.
 4. Implement a queue using arrays/linked list.
 10. Detect a cycle in a linked list.
 11. Find the intersection point of two linked lists.

*/
extension LeetCode {

    func runLinkedList() {
        let array = [8,10,12,16,18,25,20]
        let list = convertArrayToLinkedList(array)
        convertLinkedListToArray(list)
    }

    class ListNode: CustomStringConvertible {
        var val: Int
        var next: ListNode?
        init() { self.val = 0; self.next = nil; }
        init(_ val: Int) { self.val = val; self.next = nil; }
        init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }

        var description: String {
            var s = "\(val)"
            if let next {
                s += " -> \(next.description)"
            }
            return s
        }

        func insert(value: Int) {
            // Next is nil, basically empty case.
            guard let next = self.next else {
                next = .init(value)
                return
            }
            var previousNode: ListNode? = next
            var currentNode: ListNode? = next
            while currentNode != nil {
                previousNode = currentNode
                currentNode = currentNode?.next
            }
            previousNode?.next = .init(value)
        }
    }

    @discardableResult
    func convertArrayToLinkedList(_ array: [Int] = [1,2,3,4]) -> ListNode? {
        guard !array.isEmpty else { return nil }
        let node: ListNode = .init(array[0])
        for index in 1..<array.count {
            let value = array[index]
            node.insert(value: value)
        }
        print("Array to linkedList: \(node)")
        return node
    }

    @discardableResult
    func convertLinkedListToArray(_ node: ListNode?) -> [Int] {
        guard let node else { return [] }
        // convert list to array
        var array = [Int]()
        // traverse from head to tail
        var currentNode: ListNode? = node
        while currentNode != nil {
            array.append(currentNode!.val)
            currentNode = currentNode?.next
        }
        print("LinkedList to Array: \(array)")
        return array
    }

    /// NOTE: We should be using three window technique here.
    func reverse(from node: ListNode) -> ListNode? {

        var previousNode: ListNode? = nil
        var currentNode: ListNode? = node
        var nextNode: ListNode? //

        while currentNode != nil {
            nextNode = currentNode?.next
            currentNode?.next = previousNode
            previousNode = currentNode
            currentNode = nextNode
        }
        return previousNode
    }

    /// - NOTE: Little tricky.
    /// assigning the head reference in current node to perform mutation and iteration
    /// where as head will not be nil, only the mutation performed via currentNode<##>
    func removeDuplicates(inList head: ListNode?) -> ListNode? {
        var currentNode = head
        while currentNode != nil {
            if currentNode?.val == currentNode?.next?.val {
                /// this will udpate the next node,
                /// while loop still continious wiht old current node, with updated next index
                currentNode?.next = currentNode?.next?.next
            } else {
                /// continuing the iteration
                currentNode = currentNode?.next
            }
        }
        // if we return currentNode, then that is just last element
        // we should be returning the reference of the head
        return head // *** important (Not currentNode)
    }

    func middleElement(of node: ListNode?) -> ListNode? {
        var slow = node
        var fast = node
        // Floyd’s Cycle Detection Algorithm
        while fast != nil && fast?.next != nil {
            slow = slow?.next // 3
            fast = fast?.next?.next // 5
        }
        return slow
    }

    func hasCycle(node: ListNode?) -> Bool {
        var slow = node
        var fast = node

        /// Safely advancing by 2
        while fast != nil && fast?.next != nil {
            slow = slow?.next
            fast = fast?.next?.next
            // Equating the reference, not value
            // Same value can be in different node, but that couldn't be a cycle.
            if slow === fast {
                return true
            }
        }
        return false
    }

    // Get the length
    // Align the starting point
    // Traverse togeather to find the intersection
    func getIntersectionNode(_ headA: ListNode?, _ headB: ListNode?) -> ListNode? {

        func getLength(for node: ListNode?) -> Int {
            var counter: Int = 0
            var currentNode = node
            while currentNode != nil {
                currentNode = currentNode?.next
                counter += 1
            }
            return counter
        }

        let lenghtA = getLength(for: headA)
        let lengthB = getLength(for: headB)

        var pointerA = headA
        var pointerB = headB

        /// Align the starting point
        if lenghtA > lengthB {
            for _ in 0..<(lenghtA - lengthB) {
                pointerA = pointerA?.next
            }
        } else if lengthB > lenghtA {
            for _ in 0..<(lengthB - lenghtA) {
                pointerB = pointerB?.next
            }
        }

        // traverse
        // Equating the reference, not value. 
        while pointerA !== pointerB {
            pointerA = pointerA?.next
            pointerB = pointerB?.next
        }

        return pointerA
    }
}
