//
//  Leetcode+Ext.swift
//  iOSInterviewGuide
//
//  Created by Karthik on 19/09/24.
//

import Foundation

/*
 To invert the number, use remainder
 To build the number, multiply the number with 10
 To find the digits, divite it by 10
*/
extension Int {
    
    /// NOTE: Idea is to convert number to string, then map into whole numbers 
    func toArray() -> [Int] {
        return String(self)
            .compactMap(\.wholeNumberValue)
    }
    
    func isEven() -> Bool {
        return self % 2 == 0
    }
    
    /// NOTE: Idea is how many times, the number divided by 10.
    /// Track the counter, that can tell the even or odd digits 
    func hasEvenDigits() -> Bool {
        var number = self
        var count: Int = 1
        
        while number != 0 { // ***
            number /= 10
            count += 1
        }
        return count.isEven()
    }
}

extension Array where Element == Int {
    
    //        var result = 0
    //        for digit in array {
    //            result = result * 10 + digit
    //        }
    //        return result
    func toInt() -> Int {
        return reduce(0) { $0 * 10 + $1 }
    }
}
