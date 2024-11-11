//
//  iOSQuestions.swift
//  iOSInterviewGuide
//
//  Created by Karthik on 22/09/24.
//

import Foundation

// Locks
// https://www.linkedin.com/posts/preetendali_iosdevelopment-swiftlang-concurrency-ugcPost-7242768521644883968-1l2Q?utm_source=share&utm_medium=member_ios

/*
 Swift
 Safety, Simplicity in syntax, Readabiltiy, Multiplatform
    - Strongly typed language ( type safety )
    - Optionals for null type safety
    - ARC (swift uses ARC like objective-C but improves it with better compile time safety checks)
    - let keyword for immutability
    - value types (struct and enum)
    - Better concurrency and multithread handling (async/await and actors)
    - Built in error handling (do, catch)
 
 Non-running, InActive, Active, Background, Suspended
 
 InActive - The app is running but not receiving user events. It’s a temporary state. (like receiving phone calls etc)
 Active -  The app is in the foreground and actively interacting with the user
 Background - When the app is no longer on-screen but still has some tasks to complete (like bg tasks, Voip, location handling etc..)
 Suspended - The app remains in memory but does not execute any code, When the app moves to the background and finishes all tasks or when iOS freezes the app to free up memory.
 
 State Transitions in Practice
 - Launching: The app starts in the Inactive state, then moves to Active.
 - Going to Background: The app transitions from Active to Inactive and then to Background.
 - Becoming Suspended: The app goes from Background to Suspended when it finishes tasks or if it needs to conserve resources.
 
 Enum
 - A value type contains group of related object
 - Impossbile to create an instance of it
 - Can be used for name spacing
 
 lazy property: Its stored proerty, and its initial value will be calculated only at the first time of calling
 computed property: a feature that allows you to define a property whose value is computed each time rather than using stored.
 guard - early exit, safely unwrap optional values
 tuple - A temporary container for returning multiple values
 dynamic dispatch - Process of selecting which implementation of a polymorphic operation to call at run time.
 defer - provides a block of code executed when function execution leaves the current scope
 
 Closure: A block of code, that can be passed around and executed in our code. closures can capture the reference in which they are defined.
 Escaping closure: can be exectuted after the function it was passed, this means that the closure escapes the funtion body and can be called later. caches the reference in order to execute later point
 Non-escaping closure: ensures that the closures executes with in the function scope, in this case swift assumes that the closures will not escape and
 doesn't need any special memory handling to retain variables
 Autoclosures: automatically wraps an expression passed as an arugment to function - eg print.
 Completion handler: These are function passed as parameter to an other function. its a techinque for implementing callback functionality using closures.
 
 function vs closures: closures is a self contained block of code that canb e passed around and exectured at a later time, while
 function is a block of code that performs specific task.
 
 Contional Confirmance - allows a type to confirm to a protocol only when certain condition where met. (Eg collections are diffable only if elements are hashable)
 Circular Reference: When two object strongly refering each other, they can never be deallocated.
 Optinal Chaining: Process of querying and calling properties. Different queires can be chained here.
 Property observer (willset, didSet): helps to observe the change in a variable before and after the mutation. willSet are useful for performing
 additional logic when a property value changes.
 
 Autorelease pool - primary purpose of an autorelease pool is to help manage memory usage and reduce memory footprint.
 Its a stack like structure that manages the release of objects, when an object is added to an auto release pool,
 it is not release immeidately, but rather added to a list of objects that will be released when pool is drained
 
 Deadlock - A deadlock is a situation in concurrent or multithreaded programming where two or more threads (or processes) are unable to proceed
 because each one is waiting for the other to release a resource they need.
 Consider two threads, Thread A and Thread B, and two resources, Resource X and Resource Y:
 1.    Thread A locks Resource X.
 2.    Thread B locks Resource Y.
 3.    Thread A then tries to lock Resource Y but can’t proceed because Thread B holds it.
 4.    Thread B tries to lock Resource X but can’t proceed because Thread A holds it.
 How to Prevent Deadlocks
 1.    Resource Ordering: Impose a strict order for acquiring resources, so that each thread requests resources in a consistent order.
 2.    Deadlock Detection and Recovery: Detect deadlocks by periodically checking for cycles in the dependency graph and then recover by aborting or restarting one of the threads.
 3.    Timeouts: Set a timeout for resource requests. If a thread waits too long, it releases its resources and tries again.
 4.    Avoid Hold and Wait: Require threads to request all resources they need at once and hold none if not all resources are availab
 
 Race condition - Race conditions occur when threads execute a section of code that can be managed concurrently by several threads, making them “race” to alter shared resources.
 Concurrency - concept of managing multiple tasks or operation at the same time
 Parallelism - is about exectuting multiple task simultaniously
 In modern systems, concurrency and parallelism are often used together. For instance, an application may use concurrency to manage multiple tasks, each of which may run in parallel if multiple processors are available.

 Storage:
 In-Mem - array, dictionary, sets and other datastructures
 Key-value - userdefaults, keychain
 Document/Data - NSFileManager
 Database - Coredata, relam for offline storage
 Complex query - SQLite relational database
 
 Memory Management
  - ARC (Automatic referece counting), is a memory management technique used in iOS development to automatically
 manage the memory of an object.
  - Xcode profilers to analyse memory issues
  - Make sure to use weak reference to get rid of strong reference cycles
  - Stong, weak and unowned: These are related to object references and how its stored in memory.
 strong reference increase the retain count of an object ( A <-> B which creates retain count 1 )
 weak references do not increase the retain count and are set to nil when the referenced object is deallocated. (B refers A as a weak, so A will be nill if its deallocated)
 unowned reference are similar to weak but are expected to have a value, hence they aren't set to nil
 
 Performance & Optimization
 - Remove unwanted codes and assets
 - Reducing the appsize
 - Using xcode profiler to find out memory leaks and allocation
 - Using Time profiler to find out which part app takes most of the device resouce and which part of the code blocks main thread,
 then emplying effective algorithm
 - Use thread sanitizer to catch the race condition
 - Memory graph debugger to trackdown memory leaks / retain cycles
 - AppThining (combination of bitcode, appslicing and on demand resource)
 - Bitcode: we push our complied code, apple recompiles it again for different devices and architectures
 - App slicing: only necessary assets are downloaded to users device
 - on-demand resource
 
 Instruments:
 - Xcode profiler to find out memory leaks and allocation
 - Thread sanitizer to catch the race condition
 - Memory graph debugger to trackdown memory leaks / retain cycles
 
 Security
 - ATS, https for network communication
 - Storing sensitive data in keychain
 - Implementing proper authentication and authorization
 - Reqularly updating the app 3rd party frameworks to reduce the security vulnerabilities
 - Properly following guidelines like GDPR, HIPPA for data handling
 
 Design Pattern
 - Singleton - A design pattern which ensures only one instace exists for a given class.
 when needed for the first time, it generally uses lazy loading to create a single instace.
 - Adapter - A design patterh which allows objects with incompatible interfaces to work togeather.
 it acts as a bridge or a wrapper between two exisiting interfaces, converting the interface of one object into another interface that client expect.
 
 
 Cost Control
 - improve the app performance inorder to increase the customer base
 - rate limiter
 - reducing the backend calls (using caches)
 - optiomize google location api usage
 - impleented localization to reach max audiance inorder to increase the revene
 - implemented CI/CD integration
 
 Maximize revenue
 - In-App Purchases and Subscriptions
 - Personlized in app advertasing.( using AdMob, and apple's ads service)
 - Optimizing Appstore discoverabiiltiy (ASO)
 - Improve the customer app engagment using push notification and intercom notificatoin
 - Social sharing and added referals
 - Continously monitoring analytics and user retentions to optimize the app for improvmenets
 
 
*/

class Test  {
    
    /// lazy stored property
    lazy var count: Int = 0
    var propertyObserver: Int = 0 {
        willSet {
            print("new value: \(newValue)")
        } didSet {
            print("old value: \(oldValue), new value: \(propertyObserver)")
        }
    }
}

// Conditoinal Confirmance
protocol Diffable { }
extension Array: Diffable where Element: Hashable { }

extension Collection {

    /// NOTE: Create our own custom compact map.
    func customCompactMap<T>(_ transform: (Element) -> T?) -> [T] {
        var result = [T]()
        for element in self {
            if let transformed = transform(element) {
                result.append(transformed) // Only append non nil values
            }
        }
        return result
    }
}

// Strong Reference: Cyclic
class Parent {
    var child: Child?
}
class Child {
    var parent: Parent? // Making this weak can remove the retainc cycle
}
let parent = Parent()
let child = Child()
// parent.child = child
// child.parent = parent

// Protocols with associated types.
protocol CustomProtocol {
    associatedtype T
    
    func someMethod() -> T
}

class CustomClass: CustomProtocol {
    typealias T = Int
    
    func someMethod() -> Int {
        return 0
    }
}
