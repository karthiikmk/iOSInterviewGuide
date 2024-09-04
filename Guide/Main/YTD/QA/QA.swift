//
//  QA.swift
//  Algorithms
//
//  Created by Karthik on 13/03/24.
//

import Foundation

/// - NOTE: Use memory debugger to see the memory leaks
/// A retain cycle occurs when two objects hold strong references to each other,
/// preventing them from being deallocated and leading to memory leaks.

/*
 NonEscaping Closure - a closure which guarnteed to be executed with in the given func scope.
 Escaping closure - is clsoure that can be stored or called after the function scope
 to all the clsoure to escape the function scope, we should mark with @escaping keyword.

*/
