//
//  SystemDesign+UPI.swift
//  iOSInterviewGuide
//
//  Created by Karthik on 21/11/24.
//

import Foundation

enum UPIApp { }

/// User can have multipe UPIIds
/// Each UPI Id can have only one bank account
/// Each Bank Account can have multipe UPIID
extension UPIApp {
    
    class User {
        let id: UUID = UUID()
        let name: String
        var upi: UPI?
        
        init(name: String) {
            self.name = name
        }
    }
    
    /// A merchant in the UPI ecosystem refers to a business or individual
    /// who accepts payments via UPI for goods or services provided to customers.
    class Merchant {
        let id: UUID = UUID()
        let name: String
        var upi: UPI?
        let transactions: [Transaction] = []
        
        init(name: String) {
            self.name = name
        }
    }
    
    class BankAccount {
        let id: UUID = UUID()
        let name: String
        let accountNumber: String
        var balance: Double = 0
        var upiIds = [UPI]()
        
        init(name: String, accountNumber: String, balance: Double) {
            self.name = name
            self.accountNumber = accountNumber
            self.balance = balance
        }
    }
    
    // Each UPIId associated with one bank account
    class UPI {
        let id: UUID = UUID()
        let upiID: String
        let bankAccount: BankAccount
        var isDefault: Bool = false
        
        init(upiID: String, bankAccount: BankAccount) {
            self.upiID = upiID
            self.bankAccount = bankAccount
        }
    }
    
    enum TransactionStatus {
        case pending
        case completed
        case failed
    }
    
    class Transaction {
        let id: UUID
        let from: UPI
        let to: UPI
        let amount: Double
        let status: TransactionStatus
        let timestamp: Date
        
        init(
            id: UUID,
            from: UPI,
            to: UPI,
            amount: Double,
            status: TransactionStatus,
            timestamp: Date
        ) {
            self.id = id
            self.from = from
            self.to = to
            self.amount = amount
            self.status = status
            self.timestamp = timestamp
        }
    }
    
    /// Capacity Esitmation
    ///
    /// Daily Active Users - 1 million
    /// Transaction Per day - 10 per user -> 10 million / day
    /// Database storage for transaction -
    /// Each record - 100 bytes
    /// 10 million/day * 100 byes = 1GB / day
    ///
    /// Timeframe (1 year) - 1 GB * 365 days - 365 GB / Year
    /// Latency < 200 ms
    ///
    /// Api Implementation
    ///
    /// POST: /user - create user and stores it in the datbase
    /// POST: /user/{userId}/bankAccount - banks associated with the users
    /// POST: /transaction - initiate transation
    /// POST: /merchant/paymentRequest - creates payment request to collect the payment
    /// GET: /merchant/transaction?merchantId=M123
    /// POST: /merchant/refund
    ///
    class UPIService {
        
        func initiateTransaction(from sender: UPI, to receiver: UPI, amount: Double) -> Transaction? {
            /// Balance check
            guard sender.bankAccount.balance >= amount else { return nil }
            sender.bankAccount.balance -= amount
            ///
            receiver.bankAccount.balance += amount // temp
            
            let transaction = Transaction(
                id: UUID(),
                from: sender,
                to: receiver,
                amount: amount,
                status: .completed,
                timestamp: Date()
            )
            return transaction
        }
    }
    
    class UserService {
        
        func registerUser(name: String, mobileNumber: String, bankAccount: BankAccount) -> User {
            let upiID = "\(mobileNumber)@upi"
            let user = User(name: name)
            user.upi = UPI(upiID: upiID, bankAccount: bankAccount)
            return user
        }
        
        func linkAccounts(user: User, bankName: String, accontNumber: String, balance: Double) -> BankAccount {
            let account = BankAccount(
                name: bankName,
                accountNumber: accontNumber,
                balance: balance
            )
            // user.accounts.append(account)
            return account
        }
    }
    
    class MainApp {
        
        let userService: UserService = UserService()
        let upiService: UPIService = UPIService()
        
        func performTransaction(sender: UPI, receiver: UPI, amount: Double) -> Transaction? {
            return upiService.initiateTransaction(from: sender, to: receiver, amount: amount)
        }
    }
}
