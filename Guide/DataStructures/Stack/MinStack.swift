//
//  MinStack.swift
//  iOSInterviewGuide
//
//  Created by Karthik on 01/04/24.
//

import Foundation

/// Design a stack that supports push, pop, top, and retrieving the minimum element in constant time.
/// OJ: https://leetcode.com/problems/min-stack/
class MinStack {
    
    class Node {
        
        let value : Int
        var minimumValue : Int
        var next: Node? = nil
        
        init(_ value: Int) {
            self.value = value
            self.minimumValue = value
        }
    }

    var head: Node? = nil // root

    func push(_ val: Int) {
        if head == nil {
            self.head = Node(val)
        } else {
            /// As stack is LIFO, pushing new element on the front. 
            let newNode = Node(val)
            newNode.minimumValue = min(val, head!.minimumValue)
            newNode.next = head
            self.head = newNode
        }
    }

    func pop() { // should we update the minimum value ?
        let next = head?.next
        self.head = next
    }

    func top() -> Int {
        return head?.value ?? 0
    }

    func getMin() -> Int {
        return head?.minimumValue ?? 0
    }
}
