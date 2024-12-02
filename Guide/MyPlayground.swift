//
//  MyPlayground.swift
//  iOSInterviewGuide
//
//  Created by Karthik on 21/09/24.
//

import Foundation

/*
 Given a string s and a character c that occurs in s,
 return an array of integers answer where answer.length == s.length and
 answer[i] is the distance from index i to the closest occurrence of character c in s.
 
 The distance between two indices i and j is abs(i - j), where abs is the absolute value function.
 
 Input: S = “helloworld”, C = ‘o’
 Output: [4, 3, 2, 1, 0, 1, 0, 1, 2, 3]
*/

class MyPlayground {
    
    func run() {
        print("start")
        
        // first findout the first index of the char C
        // again iterate the array and try to calc the distance
        // collect it in the output array
        
        // let result = findDistanceOutput("helloworld", target: "e")
        // print("result: \(result)")
        
        let paragraph = "Bob hit a ball, the hit BALL flew far after it was hit."
        let banned = ["hit"]
        let freq = mostFrequentWord(paragraph, banned) ?? "Not found"
        print("freq: \(freq)")
    }
    
    
    /// Using dynamic programming.
    func findDistanceOutput(_ s: String, target: Character) -> [Int] {
        
        let array = Array(s)
        var distance = Array(repeating: Int.max, count: s.count)
        var j = -1 // closest
        
        // Left to right
        for (i, char) in array.enumerated() {
            if char == target {
                j = i
            }
            if j != -1 {
                distance[i] = abs(i - j)
            }
        }
        
        j = -1 /// Resetting for the reverse iteration
        
        // right to left
        for i in stride(from: s.count-1, through: 0, by: -1) {
            if array[i] == target {
                j = i // 4
            }
            if j != -1 {
                distance[i] = abs(i - j)
            }
        }
        
        return distance
    }
    
    /*
     Given a string paragraph and a string array of the banned words banned, return the most frequent word that is not banned.
     The words in paragraph are case-insensitive and the answer should be returned in lowercase.
     
     paragraph = "Bob hit a ball, the hit BALL flew far after it was hit.", banned = ["hit"] -> "ball"
    */
    func mostFrequentWord(_ paragraph: String, _ banned: [String]) -> String? {
        let result = paragraph
            .lowercased()
            .components(separatedBy: CharacterSet.alphanumerics.inverted) // word seperation
            .filter { !$0.isEmpty && !banned.contains($0) } // removing banned words
            .reduce(into: [String: Int]()) { result, word in
                result[word, default: 0] += 1
            }
            .max(by: { $0.value < $1.value }) // finding the max frequency
        return result?.key
    }
}
