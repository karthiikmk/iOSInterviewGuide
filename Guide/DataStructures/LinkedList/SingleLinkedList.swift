//
//  SingleLinkedList.swift
//  ALDS
//
//  Created by Karthik on 26/05/22.
//

import Foundation

/// - NOTE: Reused in many places. PLEASE Do not break.
class Node<T>: Equatable, CustomStringConvertible {
    
    let value: T
    var next: Node?
    
    init(value: T, next: Node? = nil) {
        self.value = value
        self.next = next
    }
    
    func insert(_ value: T) {
        var current: Node<T>? = self
        while current?.next != nil { // next is very important here. 
            current = current?.next
        }
        current?.next = Node(value: value)
    }
    
    // required conforms to CustomStringConvertible
    var description: String {
        guard let next = next else { return "\(value)" }
        return "\(value) -> " + String(describing: next)
    }
    
    // This is to compare two nodes, not values.
    static func == (lhs: Node<T>, rhs: Node<T>) -> Bool {
        return lhs.next == rhs.next
    }
}

/*
 Pre-requsite:
 - Head, tail
 - push(insert), pop,
 - append(last), removeLast, insert/remove at index
*/

// Building a generic linked list
class LinkedList<T: Equatable>: CustomStringConvertible {
    
    var head: Node<T>? = nil
    var tail: Node<T>? = nil
    
    var isEmpty: Bool { return head == nil }

    // MARK: - Helpers
    // This will always insert new value at the head. (head first)
    // Create a new node,
    // Assign current head to this head next
    // if tail is not there, add the new node to the tail
    func push(value: T) {
        let newNode = Node(value: value, next: head)
        self.head = newNode
        if tail == nil {
            self.tail = newNode
        }
    }

    // This will always remove the value at the head
    // Take the current head,
    // Assign the current head next node to the head
    // Now check the List is empty, remove the tail as well.
    func pop() -> Node<T>? {
        let currentHead = self.head
        self.head = currentHead?.next

        // if linked list has only one node.
        // removing that should update the tail
        if isEmpty {
            tail = nil
        }
        return currentHead
    }
}

// MARK: - Insert
extension LinkedList {

    // This will always insert the value at tail.
    // Check if the list is empty, push it
    // Create the new node,
    func append(item: T) {
        guard !isEmpty else {
            push(value: item) // Both head and tail are same here
            return
        }
        tail?.next = Node<T>(value: item, next: nil)
        tail = tail?.next //updating the current tail to the next one that was added newely
    }

    func insert(value: T, atIndex index: Int) {
        guard isValid(index: index) else { return }

        switch index {
        case 0: //first
            push(value: value)
        case numberOfNodes-1: //last
            append(item: value)
        default:
            guard let previousNode = self.node(before: index) else {
                print("Error: Node didn't found before index \(index)")
                return
            }
            let newNode = Node(value: value)
            newNode.next = previousNode.next
            previousNode.next = newNode
        }
    }
}

// MARK: - Remove
extension LinkedList {

    // MARK: - Remove
    // This will always removes the first head value.
    func removeFirst() {
        guard !self.isEmpty else { return }
        _ = self.pop()
    }

    // first and second node as example
    // We can't make use of the tail here. tail only offers next node.
    // so we need to iterate over the nodes till next reaches nil.
    func removeLast() -> Node<T>? {
        switch self.numberOfNodes {
        case 1:
            return pop()
        default:
            guard let previousNode = node(before: numberOfNodes - 1) else { return nil }
            let lastNode = previousNode.next
            previousNode.next = nil
            tail = previousNode
            return lastNode
        }
    }

    func remove(atIndex index: Int) -> Node<T>? {
        guard isValid(index: index) else { return nil }

        var currentIndex: Int = 0
        var previousNode: Node<T>?
        var currentNode: Node<T>? = self.head

        while currentNode?.next != nil && currentIndex < index {
            currentIndex += 1
            previousNode = currentNode
            currentNode = currentNode?.next
        }

        // tail update
        if previousNode?.next == self.tail {
            previousNode?.next = nil
            self.tail = previousNode
        } else {
            previousNode?.next = currentNode?.next
        }
        return currentNode
    }
}

extension LinkedList {

    var description: String {
        guard let head = head else { return "Empty list" }
        return String(describing: head)
    }

    // Iterate from 0 to till the head's next becomes nil.
    // That many count of objects we have in the list
    var numberOfNodes: Int {
        var count: Int = 0 // index and count both are same.
        var currentNode = self.head // Needs for iteration

        while currentNode != nil {
            count += 1
            currentNode = currentNode?.next
        }
        return count
    }

    func getFirst() -> Node<T>? {
        return self.head
    }

    func getLast() -> Node<T>? {
        return self.tail
    }

    func isValid(index: Int) -> Bool {
        return index >= 0 && index < numberOfNodes
    }

    // MARK: - Node At Index
    func node(at index: Int) -> Node<T>? {
        guard !isEmpty && isValid(index: index) else { return nil }
        
        var previousNode: Node<T>? = nil
        var currentNode = head
        var currentIndex: Int = 0
        while currentNode != nil && currentIndex <= index { // checking == index than the requried index.
            currentIndex += 1
            previousNode = currentNode
            currentNode = currentNode?.next
        }
        return previousNode
    }

    func node(before index: Int) -> Node<T>? {
        guard !isEmpty && isValid(index: index) else { return nil }

        var previousNode: Node<T>? = nil
        var currentNode = head
        var currentIndex: Int = 0
        while currentNode != nil && currentIndex < index { // checking lesser index than the requried index.
            currentIndex += 1
            previousNode = currentNode
            currentNode = currentNode?.next
        }
        return previousNode
    }

    func node(after index: Int) -> Node<T>? {
        return node(at: index)?.next // important
    }
}

extension LinkedList {

    func search(value: T) -> Node<T>? {
        var currentNode = self.head
        while currentNode != nil {
            if currentNode?.value == value {
                return currentNode
            }
            currentNode = currentNode?.next
        }
        return nil
    }
}
