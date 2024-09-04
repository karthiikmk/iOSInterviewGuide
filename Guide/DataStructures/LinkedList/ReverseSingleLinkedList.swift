//
//  ReverseSingleLinkedList.swift
//  ALDS
//
//  Created by Karthik on 26/05/22.
//

import Foundation

// swiftlint:disable all
class ReverseSingleLinkedList {
    
    var list = LinkedList<Int>()
    
    func reverse(array: [Int]) {
        let list = LinkedList<Int>()
        array.forEach { list.append(item: $0) }
        // print("original list \(list)")
        // take head node and start reversing
        //print(reverse(from: list.head))
        reverse(from: list.head, by: 2)
    }     
    
    func reverse(from node: Node<Int>?) -> Node<Int>? {
        guard node != nil else { return nil }
       
        var previous: Node<Int>? = nil // 1st not wont be having previous node
        var current = node
        var next: Node<Int>?
        
        // Using two rooms startagy
        while current != nil {
            next = current?.next // sending it to next room
            current?.next = previous // using the previous one 
            previous = current // going to previous room
            current = next // for next iteration
        }
        return previous
    }
    
    /// Using `3 pointer`
    /// Consider single node has single value. so that we can complete the full flow
    @discardableResult func reverse(from node: Node<Int>?, by offset: Int) -> Node<Int>? {

        guard node != nil else {
            print("Executing basecase")
            return nil             
        } // BaseCase
        
        var previous: Node<Int>? = nil
        var current = node
        var next: Node<Int>?
        var count: Int = 0
        
        // Using two rooms startagy
        // first offset 
        while count < offset && current != nil {
            next = current?.next // sending it to next room
            current?.next = previous // using the previous one
            previous = current // going to previous room
            current = next // for next iteration
            count += 1
        }
        let revers = reverse(from: current, by: 2)
        node?.next = revers
        return previous
    }
}
// swiftlint:enable all
