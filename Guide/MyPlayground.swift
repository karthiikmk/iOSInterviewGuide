//
//  MyPlayground.swift
//  iOSInterviewGuide
//
//  Created by Karthik on 21/09/24.
//

import Foundation

class MyPlayground {
    
    func run() {
        TOH(n: 3, a: 1, b: 2, c: 3)
    }
    
    func TOH(n: Int, a: Int, b: Int, c: Int) {
        guard n > 0 else { return } // basecondition
        TOH(n: n-1, a: a, b: c, c: b) // Move a -> b using c
        print("\(a) -> \(c)")
        TOH(n: n-1, a: b, b: a, c: c) // Move b -> c using a
    }
}
