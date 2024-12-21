# sort

## Topics

Findout the different sorting mechanisms 

### Bubble Sort

- Bubble Sort is a simple sorting algorithm that repeatedly steps through the list, compares adjacent (next) elements, and swaps them if they are in the wrong order. The pass through the list is repeated until the list is sorted.

- Bubble Sort is suitable for small-sized arrays or nearly sorted arrays where simplicity is preferred over efficiency. It's commonly used for educational purposes due to its simplicity.

Example: Sorting a small array of integers for a simple command-line utility where performance is not critical.

### Insertion Sort

- Insertion Sort is a simple sorting algorithm that builds the final sorted array one element at a time. It iterates through the input elements, growing the sorted array behind it. It repeatedly takes the next element from the input data and inserts it into the correct position in the already sorted list.

- Insertion Sort is efficient for sorting small arrays or nearly sorted arrays. It's also suitable for online sorting (i.e., when elements are added to the array one by one), as it efficiently maintains a partially sorted array.

Example: Sorting a list of names as they are entered in a web form in alphabetical order.

### Quick Sort

- Quick Sort is a widely used sorting algorithm based on the divide-and-conquer strategy. It selects a 'pivot' element from the array and partitions the other elements into two sub-arrays according to whether they are less than or greater than the pivot. The sub-arrays are then recursively sorted.

- Quick Sort is widely used in practice due to its efficiency, especially for large datasets. It's often the default choice for sorting algorithms in programming languages and libraries.

Example: Sorting a large array of integers or strings in a database management system.

### Merge Sort

- Merge Sort is an efficient, stable, and comparison-based sorting algorithm. It divides the unsorted list into n sublists, each containing one element, and then repeatedly merges sublists to produce new sorted sublists until there is only one sublist remaining.

- Merge Sort is preferred for applications where stability is important (i.e., preserving the order of equal elements). It's also suitable for sorting linked lists due to its efficient use of memory.

Example: Sorting a large collection of student records by their names, where maintaining the original order of records with the same name is necessary.


| Algorithm       | Average Time Complexity | Worst-case Time Complexity | Space Complexity |
|-----------------|-------------------------|----------------------------|------------------|
| Bubble Sort     | O(n^2)                  | O(n^2)                     | O(1)             |
| Insertion Sort  | O(n^2)                  | O(n^2)                     | O(1)             |
| Quicksort       | O(n log n)              | O(n^2)                     | O(log n)         |
| Merge Sort      | O(n log n)              | O(n log n)                 | O(n)             |
|-----------------|-------------------------|----------------------------|------------------|
