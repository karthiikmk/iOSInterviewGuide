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
 
 guard - early exit, safely unwrap optional values
 tuple - A temporary container for returning multiple values
 dynamic dispatch - Process of selecting which implementation of a polymorphic operation to call at run time.
 defer - provides a block of code executed when function execution leaves the current scope

 Storage:
 In-Mem - array, dictionary, sets and other datastructures
 Key-value - userdefaults, keychain
 Document/Data - NSFileManager
 Database - Coredata, relam for offline storage
 Complex query - SQLite relational database
 
 Memory Management
  - ARC (Automatic referece counting), is a memory management technique used in iOS development to automatically
 manage the memory of an object.
 
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

// - MARK: Property
///
/// `Computed property`: A feature that allows you to define a property whose value is computed each time rather than using stored.
/// `Property Wrapper`:
/// ```
/// @propertyWrapper
/// struct WrapperName<ValueType> {
///     private var value: ValueType
///     var wrappedValue: ValueType {
///         get {
///             return value
///         } set {
///             value = newValue
///         }
///     }
///     init(wrappedValue: ValueType) {
///         self.value = wrappedValue
///     }
/// }
/// ```
/// `lazy property`: Its stored proerty, and its initial value will be calculated only at the first time of calling
///
/// `Property observer` (willset, didSet): A feature, which helps to observe the change in a variable before and after the mutation. property wrappers applicable for both stored and computed properites.
/// `Contional Confirmance` - Allows a type to confirm to a protocol only when certain condition where met. (Eg collections are diffable only if elements are hashable)
/// ```
/// protocol Diffable { }
/// extension Array: Diffable where Element: Hashable { }
/// ```
/// `Circular Reference`: When two object strongly refering each other, they can never be deallocated.
/// `Optinal Chaining`: Process of querying and calling properties. Different queires can be chained here.
///
// - MARK: Closure
///
/// `Closure`: A block of code, that can be passed around and executed in our code. closures can capture the reference in which they are defined.
/// `Escaping closure`: can be exectuted after the function it was passed, this means that the closure escapes the funtion body and can be called later. caches the reference in order to execute later point
/// `Non-escaping closure`: Ensures that the closures executes with in the function scope, This means the closure does not “escape” or outlive
/// the scope of the function. Non-escaping closures are the default in Swift and doesn't need any special  memory handling to retain variables.
/// ```
/// func performTask(_ task: () -> Void) {
///     print("Start Task")
///     task()  // The closure is executed within the function scope
///     print("End Task")
/// }
/// ```
/// `Autoclosures`: Automatically wraps an expression passed as an arugment to function - eg print, assert etc
/// `Completion handler`: These are function passed as parameter to an other function. its a techinque for implementing callback functionality using closures.
/// `function vs closures`: closures is a self contained block of code that can be passed around and exectured at a later time, while
/// function is a block of code that performs specific task.
///
/// `Copy-on-Write (COW)`
///  An optimization technique used in some Swift value types like arrays, dictionaries, sets, and strings.
///  Instead of copying the entire value type immediately, Swift creates a reference to the same memory location. This helps save memory.
///  when you modify the copied value, Swift creates a new memory space with the updated data.
///  Note: value types are stored in the stack, while their references are managed in the heap.

/// - Stong, weak and unowned: These are related to object references and how its stored in memory.
///  strong reference increase the retain count of an object ( A <-> B which creates retain count 1 )
///  `weak` Weak references are always declared as optional types because, they can become nil if the referenced object is deallocated
///   weak reference is used where there is possibility for that reference to become nil at some point during its lifetime.
///   weak references do not increase the retain count and are set to nil when the referenced object is deallocated. (B refers A as a weak, so A will be nill if its deallocated)
///
///  `unowned` an unowned reference is used where there is no possibility for that reference becoming nil at any point until the self-object exist
///  unowned reference are similar to weak but are expected to have a value, hence they aren't set to nil
///
// - MARK: Memory
///
/// `Autorelease pool` - primary purpose of an autorelease pool is to help manage memory usage and reduce memory footprint.
/// Its a stack like structure that manages the release of objects, when an object is added to an auto release pool,
/// it is not release immeidately, but rather added to a list of objects that will be released when pool is drained
///
/// Deadlock - A deadlock is a situation in concurrent or multithreaded programming where two or more threads (or processes) are unable to proceed
/// because each one is waiting for the other to release a resource they need.
//                                    Consider two threads, Thread T1 and Thread T2, and two resources, Resource R1 and Resource R2:
//                                        1.    Thread T1 locks Resource R1.
//                                    2.    Thread T2 locks Resource R2.
//                                    3.    Thread T1 then tries to lock Resource R2 but can’t proceed because Thread T2 holds it.
//                                    4.    Thread T2 tries to lock Resource R1 but can’t proceed because Thread T1 holds it.
//                                    How to Prevent Deadlocks
//                                    1.    Resource Ordering: Impose a strict order for acquiring resources, so that each thread requests resources in a consistent order.
//                                    2.    Deadlock Detection and Recovery: Detect deadlocks by periodically checking for cycles in the dependency graph and then recover by aborting or restarting one of the threads.
//                                    3.    Timeouts: Set a timeout for resource requests. If a thread waits too long, it releases its resources and tries again.
//                                    4.    Avoid Hold and Wait: Require threads to request all resources they need at once and hold none if not all resources are availab
//                                    
//                                    Race condition - Race conditions occur when threads execute a section of code that can be managed concurrently by several threads, making them “race” to alter shared resources.
//                                    Concurrency - concept of managing multiple tasks or operation at the same time
//                                    Parallelism - is about exectuting multiple task simultaniously
//                                    In modern systems, concurrency and parallelism are often used together. For instance, an application may use concurrency to manage multiple tasks, each of which may run in parallel if multiple processors are available.

/// TODO: - https://github.com/shobhakartiwari/iOS_Lead_Interview (complete this)

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

/// What tools would you use to analyze the security of iOS applications?
/// Static Analysis Tools: This involves examining the source code of an application without executing it. The goal is to identify code patterns that are potentially harmful or insecure, such as buffer overflows, SQL injection vulnerabilities, and insecure API usage.
///     Xcode, SonarQube can scan source code for vulnerabilities without running the app.
/// Dynamic Analysis Tools: Dynamic analysis is conducted while the app is running. This can be done using debugging tools like LLDB or higher-level tools like Frida to inject scripts, modify runtime values, and observe behaviors.
/// Frida, a powerful dynamic instrumentation toolkit that allows you to hook into the runtime of an iOS app to monitor its behavior, modify its code, and intercept system calls.
/// Network Analysis Tools: Wireshark and Charles Proxy help intercept and analyze data sent and received by the app over the network.
///
/// What is an IPA file, and how do you analyze it for security issues?
/// An IPA (iOS App Store Package) file is the distribution format for iOS apps, It can be analyzed by unpacking it to review the contents such as the compiled binary, property list files, and resources.
///
/// How would you use Python to write tools for automating the analysis of iOS applications?
/// What Python libraries or frameworks would you use to analyze mobile application behavior?
/// How does the iOS runtime work, and how does this affect app security analysis?
/// What key contributions can you provide for the role based on your technical expertise?
