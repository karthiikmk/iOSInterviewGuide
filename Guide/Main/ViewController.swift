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

//        let leetCode = LeetCode()

//        leetCode.findSumOfMaxSubArray([-2,1,-3,4,-1,2,1,-5,4])
//        leetCode.searchInsert([1, 3, 5, 6], 7)
//        leetCode.plusOne([4,3,2,1])
//        
//        let parent = LeetCode.ListNode(1)
//        let one = LeetCode.ListNode(1)
//        let two = LeetCode.ListNode(2)
//        one.next = two
//        parent.next = one
//        leetCode.removeDuplicates(inList: parent)
//        leetCode.findLongestPalindromSubstring(in: "hellomadam")
//        leetCode.permutations(of: "abc")
//        leetCode.reverseVowels("leetcode")
//        leetCode.firstUniqChar("leetcode")
//
//        var character: [Character] = ["a","a","a","b","b","c","c","c"]
//        leetCode.compress(&character)
//        leetCode.reverseWords("Let's take LeetCode contest")
//        leetCode.restoreString("abc", [0,1,2])
//        leetCode.TOH(n: 4, a: 1, b: 2, c: 3)
//        leetCode.findDuplicates([4,3,2,7,8,2,3,1])
//        leetCode.lengthOfLongestSubstring("thistorenc")
//        var chars: [Character] = ["a", "b", "c", "d"]
//        leetCode.reverseString(&chars)
//
//        leetCode.reverseOnlyLetters("Test1ng-Leet=code-Q!")
//        var nums = [0,1,2,2,3,0,4,2]
//        leetCode.removeElement(&nums, 2)
//
//        leetCode.flipAndInvertImage([[1,1,0],[1,0,1],[0,0,0]])
//
//        leetCode.sortedSquares([-7,-3,2,3,11])
//        leetCode.sortArrayByParity([3,1,2,4])
//        leetCode.reversePrefix("abcdefd", "d")
//
//        leetCode.numSubarrayProductLessThanK([10,5,2,6], 100)
//        leetCode.singleNumber([4,1,2,1,2])
//
//        var array = [7, 6, 10, 5, 9, 2, 1, 15, 7]
//        let quickSort = InPlaceQuickSort(array: array)
//        quickSort.sort()

        let practise = Practise()
        practise.run()
	}

    /// - NOTE: Given a one-dimensional array representing a single lane with vehicles moving in either directions,
    /// Write a function to determine how many pairs of vehicles are moving towards each other.
    /// Uses two-pointer technique
    func findPairs() -> Int {
        let array: [String] = [">", "<", ">", ">", "<"]
        var leftPointer = 0
        var rightPointer = 0
        var count = 0

        // Move the left pointer until it finds a ">"
        while leftPointer < array.count {
            if array[leftPointer] == ">" {
                // Move the right pointer from the current position of the left pointer
                rightPointer = leftPointer + 1

                // Move the right pointer until it finds a "<" or reaches the end of the array
                while rightPointer < array.count && array[rightPointer] != "<" {
                    rightPointer += 1
                }

                // If a "<" is found, increment the count by the number of "<"s found between the pointers
                if rightPointer < array.count && array[rightPointer] == "<" {
                    count += 1
                }
            }
            leftPointer += 1
        }

        return count
    }

    func findDuplicates() -> [Int: Int] {
        let array: [Int] = [3, 1, 3]
        var duplicates = [Int: Int]()
        var start: Int = 0
        let end: Int = array.count

        while start < end {
            let element = array[start]
            if let duplicatedCount = duplicates[element] {
                let value = duplicatedCount + 1
                duplicates[element] = value
            } else {
                duplicates[element] = 1
            }
            start += 1
        }

        return duplicates
    }

    func runGraph() {

        let graph = Graph<Int>()
        let one = graph.addVertex(1)
        let two = graph.addVertex(2)
        let three = graph.addVertex(3)
        let four = graph.addVertex(4)
        let five = graph.addVertex(5)
        let six = graph.addVertex(6)
        let seven = graph.addVertex(7)

        
        graph.addEdge(from: one, to: two)
        graph.addEdge(from: one, to: three)
        graph.addEdge(from: one, to: four)

        graph.addEdge(from: two, to: one)
        graph.addEdge(from: two, to: three)

        graph.addEdge(from: three, to: two)
        graph.addEdge(from: three, to: one)
        graph.addEdge(from: three, to: four)
        graph.addEdge(from: three, to: five)

        graph.addEdge(from: four, to: one)
        graph.addEdge(from: four, to: three)
        graph.addEdge(from: four, to: five)

        graph.addEdge(from: five, to: three)
        graph.addEdge(from: five, to: four)
        graph.addEdge(from: five, to: six)
        graph.addEdge(from: five, to: seven)

        graph.addEdge(from: six, to: five)
        graph.addEdge(from: seven, to: five)

        // graph.minumumSpanning(for: one)
        let result = graph.bfs(for: one)
        debugPrint(result)
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

        let priorityQueue = PriorityQueue<Task>()
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

    func testBinarySearchTree() {
        let seven = BinarySearchTree(7)
        let two = BinarySearchTree(2)
        let ten = BinarySearchTree(10)
        let one = BinarySearchTree(1)
        let five = BinarySearchTree(5)
        let nine = BinarySearchTree(9)

        two.left = one
        two.right = five

        ten.left = nine

        seven.left = two
        seven.right = ten

        debugPrint(seven)
        seven.traverseInOrder { value in
            debugPrint(value, terminator: ", ")
        }
    }

    func testMaxHeap() {
        let task1 = Task(priority: 3, name: "Clean room")
        let task2 = Task(priority: 1, name: "Do homework")
        let task3 = Task(priority: 2, name: "Wash dishes")
        let task4 = Task(priority: 4, name: "reading")
        let task5 = Task(priority: 5, name: "writing")

        let priorityQueue = Heap<Task>(maxHeap: true)

        // Insert tasks into the priority queue
        priorityQueue.push(task1)
        priorityQueue.push(task2)
        priorityQueue.push(task3)
        priorityQueue.push(task4)
        priorityQueue.push(task5)

        // Remove tasks from the priority queue based on their priority
        while let task = priorityQueue.pop() {
            print("Performing task: \(task.name)")
        }
    }

    func getFib(_ position: Int) -> Int {
        if position == 0 || position == 1 {
            return position
        }

        let first = getFib(position - 1)
        let second = getFib(position - 2)
        debugPrint("firts \(first) - second \(second)")
        return first + second
    }

    func runFixedArray() {

        /// Creating fixed size array of count 10
        // let fixedArray = FixedSizeArray(max: 10, defaultValue: 0)
    }
}
