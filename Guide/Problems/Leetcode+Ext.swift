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

    func toInt() -> Int {
        return reduce(0) { $0 * 10 + $1 }
    }
    
    func toNaturalNumbersSum() -> Int {
        let n = self.count
        return n*(n+1)/2
    }
}

public enum SortType {
    case asc, desc
}

extension ArraySlice where Element: Comparable {
    
    @inlinable public mutating func sort(type: SortType) {
        type == .asc ? self.sort() : self.sort(by: >)
    }
}

// - MARK: Regex

/// Eg: "([a-zA-z])(\\d+)"
/// This gives 2 groups.
/// `Group 1`: Range(match.range(at: 1), in: input)
/// `Group 2`: Range(match.range(at: 2), in: input)
/// `value`: input[groupRange]
struct RegexBuilder {
    let regex: String
    
    func getMatches(input: String) -> [NSTextCheckingResult] {
        let regex = try! NSRegularExpression(pattern: regex, options: [])
        return regex.matches(in: input, range: NSRange(location: 0, length: input.utf16.count))
    }
}

extension NSTextCheckingResult {
    func getRange(at: Int, in string: String) -> Range<String.Index>? {
        return Range(self.range(at: at), in: string)
    }
}

extension Range where Bound == String.Index {
    func substring(from string: String) -> String {
        let substring = String(string[self])
        return substring
    }
}
