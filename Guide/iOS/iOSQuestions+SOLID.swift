//
//  iOSQuestions+DesignPattern.swift
//  iOSInterviewGuide
//
//  Created by Karthik on 18/11/24.
//

import Foundation

/*
 SOLID PRINICIPLES
 
Single Responsibility Principle
 
 1. A class should have only one reason to change, meaning it should only have one responsibility.
 2. This makes your code more modular and easier to maintain.
 3. Keep each class focused on a single task to improve readability, maintainability, and reusability.
 - Eg: DataFetcher, DataDisplayer etc
 
Open/Closed Principle (OCP):
 
 - The code open for extension but closed for modification
 - OCP by allowing you to extend the system's functionality without altering existing code
 - we can use protocols and create extensions for each class
 - Eg: DataManager which processes the data of diff type like file, database, api etc
 
 Liskov Substitution Principle (LSP)
 
 - Subtypes must be substitutable for their base types without altering the correctness of the program.
 - Ensure derived classes preserve the behavior of the base class, not break it.
  
 Interface Segregation Principle (ISP)
 - A class should not be forced to implement methods it doesn’t use.
 - Split large interfaces into smaller, more specific interfaces tailored to different client needs.
 
 Dependency Inversion Principle (DIP):
 
 - High-level modules should not depend on low-level modules; both should depend on abstractions.
 - Use interfaces or abstractions to reduce coupling between components and make the system more flexible.
*/

/// ----------------------------------------------------------------------
struct User {
    let id: String
    let name: String
    let isPremimumUser: Bool = false
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}

protocol BookType {
    var isPhysical: Bool { get }
}

class Book: BookType {
    let title: String
    init(title: String) {
        self.title = title
    }
    var isPhysical: Bool { fatalError() }
}

class LibraryWithoutSOLID {
    func add(book: Book) { }
    func search(book: Book) { }
    func issue() -> Book? { return nil }
    func fee() -> Double { return 0 }
}

/// Single Responsibility Principle (SRP):
/// Single Library class should not manage everything. instead it has to follow single responsibity.
/// Now BookManager, FeeCalculator has only one responsibiity to chanage. BookManager only manages books, and FeeCalculator calculates fees.
class Library {
    let bookManager: BookManager
    let feeCalculator: FeeCalculator = FeeCalculator(strategy: RegularFeeStrategy())
    
    init(bookManager: BookManager) {
        self.bookManager = bookManager
    }
}

class BookManager {
    func add(book: Book) { }
    func search(book: Book) { }
}

/// Open/Closed Principle (OCP):
/// If you later want to add different fee strategies (e.g., a premium user gets a discount), you need to modify the class, violating OCP.an
protocol FeeStrategy {
    func fee(_ book: Book) -> Double
}

class RegularFeeStrategy: FeeStrategy {
    func fee(_ book: Book) -> Double { return 0.0 }
}

class PremiumFeeStrategy: FeeStrategy {
    func fee(_ book: Book) -> Double { return 0.0 } // this will give discount
}

/// Now FeeCalculator can use fee strategy in order to extend the functionlity
class FeeCalculator {
    let strategty: FeeStrategy
    init (strategy: FeeStrategy = RegularFeeStrategy()) {
        self.strategty = strategy
    }
    func fee(_ book: Book) -> Double {
        return strategty.fee(book) // here we can make use of this plce
    }
}

/// Liskov Substitution Principle (LSP):
class PhysicalBook: Book {
    override var isPhysical: Bool { true }
}

class DigitalBook: Book {
    override var isPhysical: Bool { false }
}

/// Interface Segregation Principle (Consider LibraryWithoutSOLID)
///
/// If a class only needs to add books, it will still inherit unnecessary methods like calculateLateFee.
protocol BookSearchable {
    func search(book: Book)
}
extension BookSearchable {
    func search(book: Book) { }
}

protocol BookManageable: BookSearchable {
    func add(book: Book)
}

protocol FeeCaclculatable {
    func fee(_ book: Book) -> Double
}

/// Dependency inverstion Principle
///
/// If Library directly depends on concrete classes like PhysicalBook or RegularFeeStrategy, changing the implementation requires modifying Library:
class LibraryWithDependencyInversion: BookManageable, FeeCaclculatable {
    
    let bookManager: BookManageable
    var feeCalculator: FeeCalculator?
    
    init(bookManager: BookManageable, feeCalculator: FeeCalculator? = nil) {
        self.bookManager = bookManager
        self.feeCalculator = feeCalculator
    }
    
    func add(book: Book) { }
    
    func search(book: Book) {  }
        
    func fee(_ book: Book) -> Double { return 0.0 }
}

/// You can inject different strategies (e.g., PremiumFeeStrategy) without modifying the Library class.
