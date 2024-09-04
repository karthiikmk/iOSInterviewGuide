//
//  Practise.swift
//  iOSInterviewGuide
//
//  Created by Karthik MK on 04/09/24.
//

import Foundation

class Practise {

    func run() {

//        let node = removeDuplicates(inList: .init(value: 2, next: .init(value: 2, next: .init(value: 2, next: .init(value: 4, next: nil)))))
//        print(node)

//        let stack = Stack()
//        stack.push(value: 4)
//        stack.push(value: 5)
//        stack.pop()
//        stack.push(value: 6)
//        print(stack)

//        let queue = Queue()
//        queue.enqueue(value: 4)
//        queue.enqueue(value: 5)
//        queue.enqueue(value: 6)
//        queue.dequeue()
//        queue.dequeue()
//        queue.dequeue()
//        print(queue)

//        let node1 = LeetCode.ListNode(1)
//        let node2 = LeetCode.ListNode(2)
//        let node3 = LeetCode.ListNode(3)
//        let node8 = LeetCode.ListNode(8)
//        let node9 = LeetCode.ListNode(9)
//        let node10 = LeetCode.ListNode(10)
//
//        node1.next = node2
//        node2.next = node3
//        node3.next = node8
//        node8.next = node9
//        node9.next = node10
//
//        let node4 = LeetCode.ListNode(4)
//        let node5 = LeetCode.ListNode(5)
//        node4.next = node5
//        node5.next = node8 // List B starts here and intersects at node 8
//
//        let leetCode = LeetCode()
//        let intersection = leetCode.getIntersectionNode(node1, node4)
//        print(intersection?.val)

        var array = [0,1,1,2,2,2,4,4,5]
        removeDuplicatesInPlace(in: &array)
    }

    func reverse(from node: Practise.Node?) -> Practise.Node? {
        guard let node else { return nil }

        // 5, 4, 3 -> 3, 4, 5
        var previousNode: Practise.Node? = nil
        var currentNode: Practise.Node? = node // 3
        var nextNode: Practise.Node? //

        while currentNode != nil {
            nextNode = currentNode?.next // nil
            currentNode?.next = previousNode // 3 - 4 - 5 - nil
            previousNode = currentNode // 3 - 4 - 5 - nil
            currentNode = nextNode // nil
        }

        return previousNode
    }

    func removeDuplicates(in array: [Int]) -> [Int] {
        // iterate alle element to create new array
        var visiteds = Set<Int>()
        var result = [Int]()

        var startIndex = 0
        let endIndex = array.count - 1

        while startIndex <= endIndex {
            let value = array[startIndex]
            if !visiteds.contains(value) {
                visiteds.insert(value)
                result.append(value)
            }
            startIndex += 1
        }

        return result
    }

    func removeDuplicatesInPlace(in array: inout [Int]) {
        //
        var slow = 0 // This points where non duplicate can be inserted
        var fast = 1 // this iterates all the elements

        while fast < array.count {
            if array[fast] != array[slow] {
                slow += 1
                array[slow] = array[fast]
            }
            fast += 1
        }
        print(array)
        print("fast: \(fast), slow \(slow)")
    }

    func removeDuplicates(inList head: Node?) -> Node? {

        // assuming that the list is sorted, in order to remove the duplicates
        // iterate over the nodes, find the next and check for duplication
        var currentNode: Node? = head

        while currentNode != nil {
            if currentNode?.value == currentNode?.next?.value {
                currentNode?.next = currentNode?.next?.next // remvoing the duplicate
            } else {
                // this is also important, if duplication comes continiously, then
                // updating for each iteration can go wrong
                currentNode = currentNode?.next // updating the current node only if mismatching found.
            }
        }

        return head // this is very important
    }

    /// [0,1,4,0,3,2,2,2], val = 2
    /// put all the matchting element to the last index
    /// return the lenght of the array exclcuding duplicates
    func removeElement(_ nums: inout [Int], _ val: Int) -> Int {

        var startIndex = 0 // 5
        var endIndex = nums.count - 1 // 4

        /// Need to check all the numbers. so = is needed
        while startIndex <= endIndex {
            if nums[startIndex] == val {
                nums.swapAt(startIndex, endIndex) //
                endIndex -= 1
            } else {
                startIndex += 1
            }
        }
        print(nums)
        return endIndex + 1
    }

    /// Array is sorted
    func search(_ nums: [Int], _ target: Int) -> Int {
        var startIndex = 0
        var endIndex = nums.count - 1
        while startIndex < endIndex {
            let middleIndex = startIndex + (endIndex - startIndex) / 2
            if nums[middleIndex] == target {
                return middleIndex
            } else if target < nums[middleIndex] {
                endIndex = middleIndex - 1
            } else {
                startIndex = middleIndex + 1
            }
        }
        return startIndex
    }

    func twoSum(_ array: [Int], target: Int) -> (Int, Int) {

        var number_index = [Int: Int]()

        for (index, number) in array.enumerated() {
            let difference = target - number
            if let otherIndex = number_index[difference] {
                return (index, otherIndex)
            }
            number_index[number] = index
        }
        return (0,0)
    }

    func majorityElement(_ nums: [Int]) -> Int {

        var count: Int = 0
        var element: Int = nums[0] // taking the first element as element

        for (index, num) in nums.enumerated() {
            if num == element {
                count += 1
            } else if count == 0 {
                count += 1
                element = num
            } else {
                count -= 1
            }
        }
        return element // this is the majority
    }
}

extension Practise {

    class Node: CustomStringConvertible, Equatable {

        static func == (lhs: Node, rhs: Node) -> Bool {
            lhs.value == rhs.value
        }

        var value: Int
        var next: Node?

        init(value: Int, next: Node? = nil) {
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
    }

    // LIFO
    class Stack: CustomStringConvertible {

        var head: Node?

        // always on the front
        func push(value: Int) {
            let newNode = Node(value: value)
            newNode.next = head
            self.head = newNode
        }

        func pop() -> Int? {
            let node = self.head
            self.head = node?.next
            return node?.value
        }

        func peek() -> Int? {
            return head?.value
        }

        var description: String {
            return head?.description ?? "-"
        }
    }

    // FIFO
    class Queue: CustomStringConvertible {

        var head: Node?
        var tail: Node?

        var isEmpty: Bool { head == nil }

        // First In (append)
        func enqueue(value: Int) {
            let newNode = Node(value: value)
            if isEmpty {
                head = newNode
                tail = head // important
                return
            }
            tail?.next = newNode
            tail = tail?.next // updating the tail
        }

        // First out
        func dequeue() -> Int? {
            let node = head
            self.head = node?.next
            if head == nil {
                tail = nil
            }
            return node?.value
        }

        var description: String {
            return "\(String(describing: head?.description))"
        }
    }
}
