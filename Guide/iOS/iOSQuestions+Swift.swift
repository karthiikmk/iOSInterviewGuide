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
 
 Non-running, InActive, Active, Background, Suspended
 
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
 
 closure: A block of code, that can be passed around and executed in our code. closures can capture the reference in which they are defined.
 non-escaping closure ensures that the closures executes with in the function scope, in this case swift assumes that the closures will not escape and
 doesn't need any special memory handling to retain variables
 escaping closures can be exectuted after the function it was passed, this means that the closure escapes the funtion body and can be called later.
 caches the reference in order to execute later point
 autoclosures automatically wraps an expression passed as an arugment to function - eg print.
 
 function vs closures: closures is a self contained block of code that canb e passed around and exectured at a later time, while
 function is a block of code that performs specific task.
 
 Contional Confirmance - allows a type to confirm to a protocol only when certain condition where met.
 Circular Reference: When two object strongly refering each other, they can never be deallocated.
 Optinal Chaining: Process of querying and calling properties. Different queires can be chained here.
 Property observer (willset, didSet): helps to observe the change in a variable before and after the mutation. willSet are useful for performing
 additional logic when a property value changes.
 autorelease pool - primary purpose of an autorelease pool is to help manage memory usage and reduce memory footprint.
 Its a stack like structure that manages the release of objects, when an object is added to an auto release pool,
 it is not release immeidately, but rather added to a list of objects that will be released when pool is drained
 completion handler - these are function passed as parameter to an other function. its a techinque for implementing callback functionality using closures.

 Storage:
 In-Mem - array, dictionary, sets and other datastructures
 Key-value - userdefaults, keychain
 Document/Data - NSFileManager
 Database - Coredata, relam for offline storage
 Complex query - SQLite relational database
 
 Memory Management
  - ARC (Automatic referece counting), is a memory management technique used in iOS development to automatically
 manage the memory of object.
  - Xcode profilers to analyse memory issues
  - Make sure to use weak reference to get rid of strong reference cycles
  - Stong, weak and unowned: These are related to object references and how its stored in memory.
 strong reference increase the retain count of an object ( A <-> B which creates retain count 1 )
 weak references do not increase the retain count and are set to nil when the referenced object is deallocated.
 unowned reference are similar to weak but are expected to have a value, hence they aren't set to nil
 
 Concurrency (list of ways to achive concurrency)
    - Threads
    - DispatchQueues: Low level api that allows running tasks in parallel.
    - Operation Queues
 
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
 
 Security
 - ATS, https for network communication
 - Storing sensitive data in keychain
 - Implementing proper authentication and authorization
 - Reqularly updating the app 3rd party frameworks to reduce the security vulnerabilities
 - Properly following guidelines like GDPR for data handling
 
 Design Pattern
 - Singleton - A design pattern which ensures only one instace exists for a given class.
 when needed for the first time, it generally uses lazy loading to create a single instace.
 - Adapter - A design patterh which allows objects with incompatible interfaces to work togeather.
 it acts as a bridge or a wrapper between two exisiting interfaces, converting the interface of one object into another interface that client expect.
*/

class Test  {
    
    /// lazy stored property
    lazy var count: Int = 0
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

