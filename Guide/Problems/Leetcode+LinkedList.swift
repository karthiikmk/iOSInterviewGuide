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
        
        var value: Int
        var next: ListNode?
        init(_ value: Int, _ next: ListNode? = nil) {
            self.value = value
            self.next = next
        }
        
        var description: String {
            var s = "\(value)"
            if let next {
                s += " -> \(next.description)"
            }
            return s
        }

        func insert(value: Int) {
            var previousNode: ListNode? = self // keep track of the list
            var currentNode: ListNode? = next // overriden
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
        var array = [Int]()
        var currentNode: ListNode? = node
        while currentNode != nil {
            array.append(currentNode!.value)
            currentNode = currentNode?.next
        }
        print("LinkedList to Array: \(array)")
        return array
    }

    /// NOTE: We should be using three window technique here.
    func reverse(from node: ListNode) -> ListNode? {

        var previousNode: ListNode? = nil
        var currentNode: ListNode? = node

        while currentNode != nil {
            let nextNode = currentNode?.next
            currentNode?.next = previousNode
            previousNode = currentNode
            currentNode = nextNode
        }
        return previousNode
    }
    
    /// Reverse k nodes in a linked list
    /// Consider single node has single value. so that we can complete the full flow
    /// Reversing linked list by 2 nodes (k nodes)
    @discardableResult
    func reverse(from node: Node<Int>?, by offset: Int) -> Node<Int>? {
        guard node != nil else { return nil }
        
        var previous: Node<Int>? = nil
        var current = node
        var index: Int = 0 // to swap howmany indices.
        
        // Using two rooms startagy, first offset
        while index < offset && current != nil {
            let next = current?.next // sending it to next room
            current?.next = previous // using the previous one
            previous = current // going to previous room
            current = next // for next iteration
            index += 1
        }
        node?.next = reverse(from: current, by: offset) // recursively swapping by offset.
        return previous // ** important.
    }

    /// - NOTE: Little tricky.
    /// assigning the head reference in current node to perform mutation and iteration
    /// where as head will not be nil, only the mutation performed via currentNode<##>
    func removeDuplicates(inList head: ListNode?) -> ListNode? {
        var currentNode = head
        while currentNode != nil {
            if currentNode?.value == currentNode?.next?.value {
                /// this will udpate the next node,
                /// while loop still continious wiht old current node, with updated next index
                currentNode?.next = currentNode?.next?.next // ** not overriding the currentNode, updating the next node.
            } else {
                /// continuing the iteration
                currentNode = currentNode?.next
            }
        }
        // if we return currentNode, then that is just last element
        // we should be returning the reference of the head
        return head // *** important (Not currentNode)
    }

    /// NOTE: Starting both slow and fast from the same node.
    /// Then advancing slow by 1, and fast by 2 step
    func middleElement(of node: ListNode?) -> ListNode? {
        var slow = node
        var fast = node
        // Floyd’s Cycle Detection Algorithm
        while fast != nil && fast?.next != nil {
            slow = slow?.next 
            fast = fast?.next?.next
        }
        return slow
    }

    /// NOTE: Starting both slow and fast from the same node.
    func hasCycle(node: ListNode?) -> Bool {
        var slow = node // ***
        var fast = node // ***

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

    /// (i.e., they “intersect” at a certain point). After the intersection point, both linked lists share the same nodes.
    /// Both first and second should share some intersection node, so that the reference can be equated
    /// first: 1 -> 3 -> 5 -> 7 -> 9
    ///                              ↘
    ///                                11 -> 12 -> 13
    ///                               ↗
    /// second:            2 -> 4 -> 6
    func getIntersectionNode(_ first: ListNode?, _ second: ListNode?) -> ListNode? {

        func getLength(for node: ListNode?) -> Int {
            var counter: Int = 0
            var currentNode = node
            while currentNode != nil {
                currentNode = currentNode?.next
                counter += 1
            }
            return counter
        }

        var firstLength = getLength(for: first)
        var secondLength = getLength(for: second)

        var firstNode = first
        var secondNode = second
        
        /// Align the starting point
        if firstLength > secondLength {
            for _ in 0..<(firstLength - secondLength) {
                firstNode = firstNode?.next
            }
        } else if secondLength > firstLength {
            for _ in 0..<(secondLength - firstLength) {
                secondNode = secondNode?.next
            }
        }
        
        // Equating the reference, not value.
        while firstNode !== secondNode {
            firstNode = firstNode?.next
            secondNode = secondNode?.next
        }
        return firstNode
    }
}
