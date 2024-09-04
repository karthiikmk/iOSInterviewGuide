//
//  2DArray.swift
//  Algorithms
//
//  Created by Karthik on 13/03/24.
//

import Foundation

/// - NOTE: Always keep the colomn first

/*
 let matrixArray = Array2D(columns: 2, rows: 2, defaultValue: 0)
 matrixArray[0, 0] = 1
 matrixArray[1, 0] = 2
 matrixArray[0, 1] = 3
 matrixArray[1, 1] = 4
 debugPrint(matrixArray)

 Order of array indexes

     C0  C1  C2  C3
    ----------------
R0 | 0 | 3 | 6 | 9  |
   ----------------
R1 | 1 | 4 | 7 | 10 |
   ----------------
R2 | 2 | 5 | 8 | 11 |
   ----------------

 To find the index position in an array, use
 let index = (column + (row * columns))

 when flatting array to matrix, to find the column and row
 let coumn = index % columns  - ciruclar behaviour
 let row =  index / columns  - incremental behaviour
*/

//        let matrixArray = Array2D(columns: 2, rows: 2, defaultValue: 0)
//        matrixArray[0, 0] = 1
//        matrixArray[1, 0] = 2
//        matrixArray[0, 1] = 3
//        matrixArray[1, 1] = 4
//        debugPrint(matrixArray)
class TwoDimensionalArray<T>: CustomStringConvertible {

    public let columns: Int
    public let rows: Int
    private var array: [T]

    var description: String {
        return array.description
    }

    init(columns: Int, rows: Int, defaultValue: T) {
        self.columns = columns
        self.rows = rows
        self.array = Array(repeating: defaultValue, count: columns*rows) // Imp
        debugPrint(array)
    }

    /// - NOTE: Colum and row are indices which should start from 0
    public subscript(row: Int, column: Int) -> T {
        get {
            assert(column >= 0 && column < columns, "Column \(column) Index out of range")
            assert(row >= 0 && row < rows, "Row \(row) Index out of range")
            return array[row * columns + column] // imp
        }
        set {
            assert(column >= 0 && column < columns, "Column \(column) Index out of range")
            assert(row >= 0 && row < rows, "Row \(row) Index out of range")
            array[row * columns + column] = newValue // imp
        }
    }
}

class ConvertArrayToTwoDimensionalArray<T> {

    let array: [T]
    let defaultValue: T

    init(array: [T], defaultValue: T) {
        self.array = array
        self.defaultValue = defaultValue
    }

    func convert(rows: Int, columns: Int) -> TwoDimensionalArray<T> {
        let matrix = TwoDimensionalArray<T>(columns: columns, rows: rows, defaultValue: defaultValue)
        for (index, element) in array.enumerated() {
            let column = index % columns // % circular behaviour
            let row = index / column // incremental behaviour
            matrix[column, row] = element
        }
        debugPrint(matrix)
        return matrix
    }
}
