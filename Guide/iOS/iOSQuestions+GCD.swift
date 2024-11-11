//
//  iOSQuestions+GCD.swift
//  iOSInterviewGuide
//
//  Created by Karthik on 07/11/24.
//

import Foundation

/*
 Concurrency (list of ways to achive concurrency)
 - Using GCD (low level apis)
 - Operations and queues (NSOperation)
 - Async/Await and Actor
 
 Tasks -> dispatched on -> Queues -> internally dispatched on -> Threads
                        (serial || concurrent)
  
 GCD:
 - Widely used frameworks for managing concurrent operations
 - It Abstracts thread managment and allows devs to focus on the task they want to perform concurrently
 
 - DispatchQueue is a class that manages tasks serially or concurrently using system threads.
 - Tasks can be dispatched serially or concurrently to queues. In serial queue, tasks are executed one after the other. In concurrent queue they are executed in parallel/concurrently.
 - GCD provides instance methods called sync & async that are popularly used to control the manner of execution of tasks.
    - Sync: The current task is executed and all other tasks are halted from using resources until the task at hand is completed.
    - Async: The current task is submitted and the control returns back to the caller. The submitted task gets executed on availability of resource.
 - GCG manages collection of dispatch queues. work submitted to these queues is exectued on a pool of threads
 
 Quality of service:
 - User interactive - tasks that need to be done immediately in order to provide a nice user experience.
 - UserInitiated - tasks that are initiated from the UI and can be performed asynchronously
 - Default - priority level of this QoS falls between user-initiated and utility.
 - Utility - long-running tasks, typically with a user-visible progress indicator
 - Background - Use it for prefetching, maintenance, and other tasks that don’t require user interaction
 
 highest priority qos task completes first then lowest qos task finishes its execution.
 
 Pros:
 - Highest abstraction. Provide light weight API for the developer to work with multithread.
 - GCD takes care of all thread creation, management and scheduling.
 - Two queues are available out of the box: main and global.
 
 Cons:
 - you can’t cancel an operation if it is in the queue or it can’t be stopped when it is running
 - You can’t suspend operation which they are in Queue
 - You can’t find how many pending operations are there in queue.
 - You can’t define the maximum number of concurrent operations.
 
  
 Operation:
 - A framework provides higher level approach to concurrency.
 - allows us to encapsulate tasks as operation object, and offers features like priorities, cancellations, dependencies etc

 - BlockOperation - multiple tasks that need to be executed concurrently. provides additional features like cancelling, adding dependinces and notifying the completion.
 - Dispatch Groups - A DispatchGroup lets you group multiple tasks and track when they complete.
 - Dispatch Semaphores and barriers - a synchronization tool that can be used to control access to a resource by multiple threads.
 Dispatch Barrier is used in concurrent dispatch queues to create a synchronization point
 - DispatchWorkItem - DispatchWorkItems are useful when you need more fine-grained control over asynchronous tasks.
*/

class BlockOperationExample {
    
    func run() {
        
        let operationQueue = OperationQueue()
        
        let operatoin1 = BlockOperation { print("Operation 1 started") }
        let operatoin2 = BlockOperation { print("Operation 2 started") }
        let operation3 = BlockOperation { print("Operation 3 started") }

        /// Adding dependency.
        operation3.addDependency(operatoin1)

        /// Executing the tasks.
        operationQueue.addOperations([operatoin1, operatoin2, operation3], waitUntilFinished: false)
    }
}

// we need a dedicated queue
class DispatchGroupExample {
    
    func run() {
        let dispatchGroup = DispatchGroup()
        let concurrentQueue = DispatchQueue(label: "com.karthik.dispatchQueue", attributes: .concurrent)
        
        // Tasks to be executed concurrently and monitored as a group
        concurrentQueue.async(group: dispatchGroup) {
            print("task starting running")
        }
        
        dispatchGroup.notify(queue: .main) {
            print("All tasks are done")
        }
 
        // dispatchGroup.resume()
        dispatchGroup.enter() //
        dispatchGroup.leave() //
 
        // dispatchGroup.wait()
        print("Done")
    }
}

class DispatchBarrierExample {
    
    static let shared = DispatchBarrierExample()
    var data: [String] = [] // Now this is not threadsafe
    let dataQueue = DispatchQueue(label: "com.karthik.dataQueue", attributes: .concurrent)
    
    func add(_ newData: String) {
        dataQueue.async(flags: .barrier) { // ** IMP
            self.data.append(newData)
        }
    }
    
    func getData() -> [String] {
        return dataQueue.sync { // **
            return data
        }
    }
}

class DispatchSemaphoreExample {
    
    func run() {
        let lock = DispatchSemaphore(value: 1)
            
        DispatchQueue.global().async {
            lock.wait()
            print("task 1 started")
            lock.signal()
        }
        
        DispatchQueue.global().async {
            lock.wait()
            print("task 2 started")
            lock.signal()
        }
    }
}

/// DispatchWorkItem represents a piece of work that can be scheduled and managed on a DispatchQueue.
/// DispatchWorkItems are useful for tasks that need to be controlled (like being cancelled, observed for completion, or having dependencies).
/// 1. `Cancelable Network Requests`: A network request that can be cancelled based on user action (like pressing a cancel button).
/// 2. `Dependent Tasks`: Tasks that must complete before another starts.
/// 3. `Resource-Intensive Calculations`: Calculations that may need to be cancelled if conditions change or if they are taking too long.
/// DispatchWorkItems are useful when you need more fine-grained control over asynchronous tasks.
class DispatchWorkItemExample {

    func run() {
        let workItem = DispatchWorkItem {
            print("Hello World")
        }
        workItem.notify(queue: .main) {
            print("work item completed.")
        }
        DispatchQueue.global().async(execute: workItem)
    }
}

class CustomOperation: Operation, @unchecked Sendable {
    
    override var isAsynchronous: Bool { true }
    
    override func start() { }
    
    override func cancel() { }
}

class CustomOperationQueue: OperationQueue, @unchecked Sendable  {
    
    override func addOperation(_ op: Operation) {
        
    }
    
    override func addOperations(_ ops: [Operation], waitUntilFinished wait: Bool) {
        
    }
    
    override func cancelAllOperations() {
        
    }
}

// let customOperationQueue = CustomOperationQueue()
// let custompOperation = CustomOperation() // use block operatoin
// customOperationQueue.addOperations([], waitUntilFinished: false)
