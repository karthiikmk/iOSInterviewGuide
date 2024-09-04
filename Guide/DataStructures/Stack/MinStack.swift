//
//  MinStack.swift
//  iOSInterviewGuide
//
//  Created by Karthik on 01/04/24.
//

import Foundation

class MinStackNode {

    let value : Int
    var minimumValue : Int
    var next: MinStackNode? = nil

    init(_ value: Int) {
        self.value = value
        self.minimumValue = value
    }
}

/// OJ: https://leetcode.com/problems/min-stack/
/// Uses Linked list
class MinStack {

    var head: MinStackNode? = nil

    func push(_ val: Int) {
        if head == nil {
            self.head = MinStackNode(val)
        } else {
            let newNode = MinStackNode(val)
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
