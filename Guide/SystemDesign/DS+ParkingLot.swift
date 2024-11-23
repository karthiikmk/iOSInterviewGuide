//
//  DS+ParkingLot.swift
//  iOSInterviewGuide
//
//  Created by Karthik on 23/11/24.
//

import Foundation

enum ParkingLot { }

extension ParkingLot {
    
    /// PreReq
    /// How many parking space ? - to calculate the capacity estimation
    /// Hourly rate for parking ? - to calc the ticket fee
    /// is multi level parking ? 
    
    /// Functional Requirement
    /// User can park their vehicle
    /// User can park their vehicle in any floor
    /// User gets a ticket when they parking the vechile
    /// Feed would be calculated as per the time duration
    
    class User {
        let userId: UUID = UUID()
        let registrationNumber: String
        init(registrationNumber: String) {
            self.registrationNumber = registrationNumber
        }
    }
    
    class ParkingSlot {
        let slotId: UUID = UUID()
        var isAvailable: Bool = true
    }
    
    struct ParkingTicket {
        let ticketId: UUID = UUID()
        let slot: ParkingSlot
        let registrationNumber: String
        let parkedAt: Date = Date()
        var exitAt: Date? //
        
        init(slot: ParkingSlot, registrationNumber: String) {
            self.slot = slot
            self.registrationNumber = registrationNumber
        }
    }
    
    class ParkingService {
        let feeService = FeeService()
        
        var parkingSpace = [ParkingSlot]() // one database 1kb
        var tickets = [UUID: ParkingTicket]() // one database
        
        func park(_ user: User) -> ParkingTicket? {
            guard let slot = parkingSpace.first (where: { $0.isAvailable }) else { return nil }
            slot.isAvailable = false
            let ticket = ParkingTicket(
                slot: slot,
                registrationNumber: user.registrationNumber
            )
            return ticket
        }
        
        func exit(_ ticketId: UUID) -> Double? {
            guard var ticket = tickets[ticketId] else { return nil }
            ticket.exitAt = Date()
            ///
            let slot = parkingSpace.first { $0.slotId == ticket.slot.slotId }
            slot?.isAvailable = true
            ///
            return feeService.calculateFee(forTicket: ticket)
        }
    }
    
    class FeeService {
        private let ratePerHour: Double = 10
     
        func calculateFee(forTicket ticket: ParkingTicket) -> Double? {
            guard let exitAt = ticket.exitAt else { return nil }
            let duration = exitAt.timeIntervalSince(ticket.parkedAt) // seconds
            let hours = ceil(duration/3600)
            return hours * ratePerHour
        }
    }
}
