//
//  DesignPatterns.swift
//  Algorithms
//
//  Created by Karthik on 13/03/24.
//

import Foundation
import UIKit

/*
 If you want to learn Design Patterns and LLD, just watch these 11 Videos:

 These are the most important design Patterns that one can be asked during an interview.

 Singleton Design Pattern (): https://lnkd.in/gh5uFq5p

 Factory Design Pattern (Define an interface for creating an object, but let subclasses alter the type of objects that will be created): https://lnkd.in/ghqAbVuW

 Composite Design Pattern (Compose objects into tree structures to represent part-whole hierarchies): https://lnkd.in/gDuW9BqP

 Builder Design Pattern (Use for Building immutable Objects): https://lnkd.in/gdgRrZSR

 State Design Pattern (Allow an object to alter its behavior when its internal state changes): https://lnkd.in/g4ez-Ubn

 Observer Design Pattern (Define a one-to-many dependency between objects so that when one object changes state, all its dependents are notified and updated automatically): https://lnkd.in/gKucwt-e

 Iterator Design Pattern (Provide a way to access the elements of an aggregate object sequentially without exposing its underlying representation): https://lnkd.in/gcPB_N6V

 Adapter Design Pattern (Convert the interface of a class into another interface clients expect): https://lnkd.in/gTg_fBy8

 Strategy Design Pattern (Define a family of algorithms, encapsulate each one, and make them interchangeable): https://lnkd.in/gk9JUmYc

 Abstract Design Pattern (Provide an interface for creating families of related or dependent objects without specifying their concrete classes): https://lnkd.in/gvQ2Jhhm

 Prototype Design Pattern (Specify the kinds of objects to create using a prototypical instance, and create new objects by copying this prototype): https://lnkd.in/gFkBv7we

 Bonus: GitHub Repo that has Code examples of above Design Patterns: https://lnkd.in/gr8mr-J8
*/

/// `Creational` Design Pattern

/// `Singleton`
///  Ensure a class has only one instance and provide a global point of access to it
///  not a thread safe one for shared resource under the object
///  Eg: Database connection, Logger
class SmartPhone {
    var color: UIColor?
    var screenSize: CGFloat = 4.7
    var memorySize: Int = 512*1024
    var battery: String?

    static let shared = SmartPhone()
}

/// `Builder`
///  Allows step-by-step construction of complex object
class SmartPhoneBuilder {
    var phone: SmartPhone = SmartPhone()
    
    func set(color: UIColor) {
        phone.color = color
    }
    func setscreenSize(_ size: CGFloat) {
        phone.screenSize = size
    }
    func build() -> SmartPhone {
        return phone
    }
}

/// `Factroy`
///  Provides an interface for creating objects, but lets subclasses alter the type of objects that will be created.
///
protocol SmartPhoneFactory {
    func produce() -> SmartPhone
}

class iPhoneFactory: SmartPhoneFactory {
    func produce() -> SmartPhone {
        return SmartPhone()
    }
}

class SamsungFactory: SmartPhoneFactory {
    func produce() -> SmartPhone {
        return SmartPhone()
    }
}

/// `Prototype` Create objects by cloning an existing instance
///  Eg: Document template, Game character

/// `Structrual` Pattern

/// `Facade`
///  Provides a simplified interface to a library, a framework, or any other complex `set of classes`.
class Battery { }
class Speaker { }

class SmartPhoneOne {
    let battery: Battery
    let speaker: Speaker
    
    init(battery: Battery, speaker: Speaker) {
        self.battery = battery
        self.speaker = speaker
    }
    
    func playMusic() { }
}

/// `Adapter`
///  Converts an interface of a class into another interface that the client expects.
class LegacyAudioJack {
    func play() { }
    func pause() { }
}

protocol AuidoJack {
    func play()
    func pause()
}

class AudioJackAdapter: AuidoJack {
    let legacyAudioJack: LegacyAudioJack
    
    init(legacyAudioJack: LegacyAudioJack) {
        self.legacyAudioJack = legacyAudioJack
    }
    func play() {
        self.legacyAudioJack.play()
    }
    func pause() {
        self.legacyAudioJack.pause()
    }
}

/// `Proxy` Provides a surrogate or placeholder for another object to control access to it.
protocol BankAccount {
    func deposit(money: Double)
    func withdraw() -> Double?
}

class RealBankAccount: BankAccount {
    func deposit(money: Double) { }
    func withdraw() -> Double? { return nil }
}

class BankAccountProxy: BankAccount {
    let bankAccount: RealBankAccount
    init(bankAccount: RealBankAccount) {
        self.bankAccount = bankAccount
    }
    func deposit(money: Double) { }
    func withdraw() -> Double? {
        // Do addtional check here
        return bankAccount.withdraw()
    }
}

/// `Behavioral` Design Pattern

/// `Observer`
///  The Observer Pattern allows todefines a one-to-many dependency between objects so that when one object changes its state. This is commonly used for event-driven systems or when one change needs to propagate across multiple components.
///  Eg: Weather station publishes the update
protocol WeatherObservable {
    func update()
}
 
class WeatherStation {
    var observers = [WeatherObservable]()
    
    func add(observer: WeatherObservable) {
        observers.append(observer)
    }
    
    func broadcast() {
        observers.forEach { $0.update() }
    }
}

class WeatherDisplayer: WeatherObservable {
    func update() {
        // get the update and show in the display
    }
}

/// `Mediator` The Mediator Pattern centralizes communication between different objects,
/// avoiding direct references between them and reducing coupling.
protocol AirTraficControl {
    func sendMessage(message: String, from airplane: Airplane)
}

class Airplane {
    let name: String
    var tower: AirTraficControl? // mediator
    init(name: String, tower: AirTraficControl? = nil) {
        self.name = name
        self.tower = tower
    }
    func send() {
        tower?.sendMessage(message: "", from: self)
    }
}

class Tower: AirTraficControl {
    private var airplanes = [Airplane]()
    
    init() { }
    
    func register(airplane: Airplane) {
        airplanes.append(airplane)
        airplane.tower = self
    }
    
    func sendMessage(message: String, from airplane: Airplane) {
        print("Tower: \(message) from \(airplane.name)")
    }
}
