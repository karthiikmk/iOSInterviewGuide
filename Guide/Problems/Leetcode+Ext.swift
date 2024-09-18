//
//  Leetcode+Ext.swift
//  iOSInterviewGuide
//
//  Created by Karthik on 19/09/24.
//

import Foundation


extension Int {
    
    func toArray() -> [Int] {
        return String(self)
            .compactMap(\.wholeNumberValue)
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
