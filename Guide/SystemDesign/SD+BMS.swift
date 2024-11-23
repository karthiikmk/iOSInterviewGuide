//
//  SystemDesign+BMS.swift
//  iOSInterviewGuide
//
//  Created by Karthik on 21/11/24.
//

/// Book My Show
/// Create LLD entity ORM classes and write 2 methods on how booking will saved and fetched
/// checked the whole flow :> API - application - Data gettng saved in the table
/// how to handle concrurrent bookings and some technical questions arund those only
///
import Foundation

enum TicketBooking {
    
    struct Movie {
        let id: UUID
        let name: String
        var theaters = [Theater]()
    }
    
    struct Theater {
        let id: UUID
        let name: String
        var movies = [Movie]()
        var shows = [Show]()
    }
    
    class Seat {
        let id: UUID
        let number: Int
        var isBooked: Bool
        var cost: Double = 0 // premium, balcony, normal
        
        init(id: UUID, number: Int, isBooked: Bool) {
            self.id = id
            self.number = number
            self.isBooked = isBooked
        }
    }
    
    /// Under a theater, what movie, what show.
    class Show {
        let id: UUID = UUID()
        let movie: Movie
        let theater: Theater
        let seats: [Seat]
        let startTime: Date
        var cost: Double = 0 // late-night show, first day show ticket can vary.
        
        init(movie: Movie, theater: Theater, seats: [Seat], startTime: Date) {
            self.movie = movie
            self.theater = theater
            self.seats = seats
            self.startTime = startTime
        }
        
        var seatNumbers: [Int] { seats.map { $0.number } }
    }
    
    struct Booking {
        let id: UUID = UUID()
        let show: Show
    }
    
    class BookMyShow {
        var database = [Show]() // this should have all the valid shows
        var bookings = [UUID: Booking]()
        var lock = NSLock()
        
        /// What you want to save
        func book(showId: UUID, seats: [Seat]) -> Booking? {
            lock.lock()
            defer { lock.unlock() }

            /// Assuming we have proper showId
            /// Need to check seat availability
            guard let show = database.filter({ $0.id == showId }).first else { return nil }
            let availableSeats = show.seats.filter { !$0.isBooked }
            let selectedSeatAvailbleToBook = seats.allSatisfy { seat in
                return availableSeats.contains { $0.number == seat.number }
            }
            guard selectedSeatAvailbleToBook else { return nil } // No proper available seats
            availableSeats.forEach { $0.isBooked = true }
            
            let booking = Booking(show: show)
            bookings[booking.id] = booking
            return booking
        }
        
        func fetchBooking(for id: UUID) -> Booking? {
            return bookings[id]
        }
    }
        
    /// Show entry
    /// 1M Active Users
    /// 10000, 5shows, 200seats = 10,000,000
    /// perday seats = 10,000*5*200
    ///
    /// Data storage
    /// assume each show takes 2kb of storage / day
    /// 50000*2kb = 100MB / perday
    ///
    /// Booking data
    /// Each record - 2kb
    /// ~ 20% available seats booking daily
    /// 10,000,000 & 0.2 = 500,000
    /// 50,000*2kb = 100MB
    ///
    /// Retain history - 100MB for shows, 100MB for bookings
    /// 200MB * 365 days - 75GB
    ///
    /// Api Implementation
    ///
    /// POST: /bookings - create booking
    /// GET: /bookings/{bookingId} - get booking details
    /// DELETE: /bookings/{bookingId} - cancel bookings 
}

// No of active users
// transactions / days / user
// datastorage
