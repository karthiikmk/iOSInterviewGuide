//
//  MyPlayground.swift
//  iOSInterviewGuide
//
//  Created by Karthik on 21/09/24.
//

import Foundation


/*
 Given a string s and a character c that occurs in s,
 return an array of integers answer where answer.length == s.length and answer[i] is the distance from index i to the closest occurrence of character c in s.
 
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
    
    func findDistanceOutput(_ s: String, target: Character) -> [Int] {
        var result = [Int]()
        var stringArray = Array(s)
        ///
        guard var targetIndex = stringArray.firstIndex(of: target) else { return [] } // O(n)
        /// O(n)
        for (index, char) in stringArray.enumerated() {
            if char == target {
                result.append(0)
                targetIndex = index // updating it closest
            } else {
                let distance = abs(targetIndex - index)
                result.append(distance)
            }
        }
        return result
    }
    
    /*
     Given a string paragraph and a string array of the banned words banned, return the most frequent word that is not banned.
     The words in paragraph are case-insensitive and the answer should be returned in lowercase.
     
     paragraph = "Bob hit a ball, the hit BALL flew far after it was hit.", banned = ["hit"] -> "ball"
    */
    
    func mostFrequentWord(_ paragraph: String, _ banned: [String]) -> String? {
        
        var charFreq = [String: Int]()
        let seperators = CharacterSet(charactersIn: ",. ") //
        let stringArray = paragraph.components(separatedBy: seperators) //
    
        for element in stringArray where !element.isEmpty {
            let word = String(element).lowercased()
            /// Filtering the proper words
            if !banned.contains(word) {
                charFreq[word, default: 0] += 1
            }
        }
        
        var resultString: String = ""
        var maxValue: Int = 0
        for (word, count) in charFreq {
            if count >= maxValue {
                resultString = word
                maxValue = count //
            }
        }
        return resultString
    }
}
