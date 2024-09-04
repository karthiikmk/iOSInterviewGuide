//
//  RetainCycle.swift
//  Algorithms
//
//  Created by Karthik on 13/03/24.
//

import Foundation

/*
 Q. What is the difference between weak and unowned keywords in Swift?

 Ans: Both weak and unowned are used in Swift to prevent strong reference cycles that
 create memory leaks when two or more objects hold strong references to each other.
 However, there are important differences between them.

 Optionality:
 Weak references are always declared as optional types because
 they can become nil if the referenced object is deallocated.

 weak reference is used where there is possibility for that reference to become nil at some point during its lifetime.
 an unowned reference is used where there is no possibility for that reference becoming nil at any point until the self-object exist”
 */

/*
 let instanceA = ClassA()
 let instanceB = ClassB()

 instanceA.propertyB = instanceB
 instanceB.propertyA = instanceA
*/

class ClassA {
    var propertyB: ClassB?

    init() { }

    deinit {
        print("ClassA is being deinitialized")
    }
}

class ClassB {
    var propertyA: ClassA! // Use 'weak' to avoid retain cycle

    init() { }

    deinit {
        print("ClassB is being deinitialized")
    }
}
