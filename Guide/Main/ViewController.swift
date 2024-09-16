//
//  ViewController.swift
//  Algorithms
//
//  Created by Karthik on 11/29/20.
//

import UIKit

class ViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()

        let leetcode = LeetCode()
        leetcode.run()
        leetcode.runLinkedList()
        leetcode.runTree()
        // practise.runGraph()

        runPriorityQueue()
	}
    
    func testMaxHeapWithInt() {

        var sortedArray: [Int] = [Int]()
        let maxHeap = Heap<Int>(maxHeap: true)
        maxHeap.push(7)
        maxHeap.push(2)
        maxHeap.push(10)
        maxHeap.push(1)
        maxHeap.push(5)
        maxHeap.push(9)
        debugPrint("Before sort: \(maxHeap)")

        while let value = maxHeap.pop() {
            sortedArray.append(value)
        }
        debugPrint("After sort: \(sortedArray)")
    }

    func runPriorityQueue() {

        struct Task: Comparable {
            let priority: Int
            let name: String

            static func < (lhs: Task, rhs: Task) -> Bool {
                return lhs.priority < rhs.priority
            }

            static func == (lhs: Task, rhs: Task) -> Bool {
                return lhs.priority == rhs.priority
            }
        }

        let priorityQueue = PriorityQueue<Task>(.max)
        let task1 = Task(priority: 1, name: "eat")
        let task2 = Task(priority: 3, name: "sleep")
        let task3 = Task(priority: 2, name: "drink")
        priorityQueue.enqueue(task1)
        priorityQueue.enqueue(task2)
        priorityQueue.enqueue(task3)

        while let removed = priorityQueue.dequeue() {
            debugPrint(removed.name)
        }
    }
}
