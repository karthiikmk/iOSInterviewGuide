//
//  Array.swift
//  Algorithms
//
//  Created by Karthik on 19/03/24.
//

import Foundation

func reverse<T>(array: [T]) -> [T] {

    var reversedArray = [T]()
    var targetIndex: Int = array.count - 1

    for element in array {
        reversedArray.insert(element, at: 0)
        targetIndex -= 1
    }

    return reversedArray
}

// append, and rotate

func reverseUsingRotate<T>(array: inout [T]) -> [T] {

    var start: Int = 0
    var end: Int = array.count - 1

    while start < end {
        (array[start], array[end]) = (array[end], array[start]) // swap
        start += 1
        end -= 1
    }

    return array
}
