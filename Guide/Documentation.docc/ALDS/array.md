# Array

## Vector Array  
- Collection of elements 
- Collection of similarly typed data elements
    
## Static Array 
- Implemented in stack only as the space is known at compile time 
- Cannot be resized
    
## Dynamic Array  
- Declaration in stack, memory allocation in heap
- Access heap memory allocation with stack pointer
- To increase size:
    1. Original array `a[5] = [1,2,3,4,5]`
    2. New array `b` created with larger size
    3. Elements from `a` copied into `b`
    4. `a` deleted from heap, address of `b` assigned to `a`
    5. Arrays must be contiguous
    
## Two Dimensional Array 

- Understanding `%` (modulo) and `/` (division operator) is important

``` swift
     3 - Quotient 
  -----
3 | 10
  |  9
  -----
    1 - Reminder 
```

- Elements stored contiguously despite matrix-like representation

```swift
for r in 0..<rows {
    for c in 0..<columns {
        arr[r][c] = // add, remove, get etc
    }
}
```

### Row Major Mapping (C++ follows)

- Elements stored row by row  

```swift
     C0  C1  C2  C3
    ----------------
R0 | 0 | 3 | 6 | 9  |
   ----------------
R1 | 1 | 4 | 7 | 10 |    
   ----------------
R2 | 2 | 5 | 8 | 11 |
   ----------------
   
   Final contiguous array:

   -------------------------------
   | 0 | 3 | 6 | 9  | 1 | 4 | 7 | 10 | 2 | 5 | 8 | 11 |
   -------------------------------  
```

- Index calculation: `let index = (column + (row * columns))`  

- To find row and column: 
  - Incremental behavior: `let row =  index / columns`  
  - Circular behavior: `let column = index % columns`

### Column Major Mapping

```swift
     C0  C1  C2  C3
    ----------------
R0 | 0 | 3 | 6 | 9  |
   ----------------
R1 | 1 | 4 | 7 | 10 |
   ----------------
R2 | 2 | 5 | 8 | 11 |
   ----------------

   Final contiguous array:
   
   --------------------------------
   | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 |
   --------------------------------  
```

- Index calculation: `let index = (row + (column * rows))`
- To find row and column:
  - Incremental behavior: `let row = index / rows`  
  - Circular behavior: `let column = index % rows`


## Search 

### Linear Search

 - Search would be done from start to end of the array. 
 - In worst case, the element can be searched entirely.  
 
 Improving linear search
 - transposition (swapping found element one index before)
 - move to head (swapping found element to the head of the array)
 

```swift
for r in 0..<rows {
    // statement 
}
```

### Binary Search 

- array must be sorted 
- find out mid element  
- Can be done using simple while loop, or using recurssion 

```
Base case - O(1)
Worst case - O(log n) where log n is the height of the tree
Avg case  -  
```

### Reverse and Shift an Array 
 
#### SubArray 
A subarray is a portion of an array that maintains the order of elements from the original array.

Subarrays are frequently used in algorithms and programming tasks for tasks such as:
- Finding maximum or minimum subarray sums.
- Searching for specific patterns or sequences within an array.
- Calculating prefix sums or cumulative sums within an array.
