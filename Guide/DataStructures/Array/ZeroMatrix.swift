//
//  ZeroMatrix.swift
//  Algorithms
//
//  Created by Karthik on 20/03/24.
//

import Foundation

typealias Matrix = [[Int]]

class ZeroMatrix {

    enum MatrixType {
        case row(Int)
        case colomn(Int)
    }

    var matrix: Matrix
    var zeroRows: [Bool]!
    var zeroColomns: [Bool]!

    init(matrix: Matrix) {
        self.matrix = matrix
        self.zeroRows = Array(repeating: false, count: matrix.count)
        self.zeroColomns = Array(repeating: false, count: matrix[0].count)
    }

    func printMatrix() {
        for r in 0..<matrix.count {
            for c in 0..<matrix[r].count {
                print(matrix[r][c], terminator: " ")
            }
            print(" ")
        }
    }

    func makeZero(_ type: MatrixType) {
        for r in 0..<matrix.count {
            for c in 0..<matrix[r].count {
                switch type {
                case .row(let rowIndex) where r == rowIndex:
                    matrix[r][c] = 0
                case .colomn(let colomnIndex) where c == colomnIndex:
                    matrix[r][c] = 0
                default:
                    continue
                }
            }
        }
    }

    func findAndReplace() {

        for r in 0..<matrix.count {
            for c in 0..<matrix[r].count {
                if matrix[r][c] == 0 {
                    zeroRows[r] = true
                    zeroColomns[c] = true
                }
            }
        }

        // Blindly Making the row zero
        for r in 0..<zeroRows.count {
            if zeroRows[r] {
                makeZero(.row(r))
            }
        }

        // Blindly making the colomn zero
        for c in 0..<zeroColomns.count {
            if zeroColomns[c] {
                makeZero(.colomn(c))
            }
        }
    }
}
