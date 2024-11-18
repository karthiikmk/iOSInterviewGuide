//
//  iOSQuestions+Combine.swift
//  iOSInterviewGuide
//
//  Created by Karthik on 08/11/24.
//

import Foundation
import Combine

/*
 Combine - It provides a declarative Swift API for processing asynchronous events and streams of data
 publishers and subscribers - a publisher is an object that emits a stream of values over time, while a subscriber is an object that receives and processes those values.
 both are connected through a subscroption. and subscriber can cancel the subscription at anytime.
 
 How does Combine handle errors - Combine provides a special type of publisher called a Failed publisher which can be used to emit errors.
 Subscribers can handle errors by providing a catch block in the sink method.
 
 merge and zip:
 - merge operator combines multiple publishers into a single publisher by emitting all the values from each publisher in the order they are received
 - zip operator combines multiple publishers into a single publisher by emitting a tuple of the latest values from each publisher in the order they are received
 
 Zip                                                          Merge
 Waits for each publisher to emit before producing output     Emits values as soon as any publisher emits
 Produces tuples containing values from each publisher        Produces values from any publisher as they emit
 
 share:
 - The share() operator allows multiple subscribers to attach to a single publisher, and it will only subscribe to the upstream publisher once.
 share() operator shares the output of an upstream publisher with multiple subscribers. and comes with default autoconnect behaviour
 
 receive(on:)
 - The receive(on:) operator is used to specify the scheduler on which the subscriber will receive events.
 
 prepend, replaceNil, combineLatesh (zip), zip, collect, switchToLatest
 
 debounce:
 - Debounce waits for a pause in the events before emitting the latest value.
 - waits for a specific duration from the emision of last value before emiting the received,
 - If a new event is emitted before the debounce time interval is over, the timer resets. (useCase: search)
 throttle: works similar to debounce, but it waits for specified interval repeatedly.(useCase: button clicks)
 
*/

class CombineExample {
    
    
    func run() {
        
        var subscriptions = Set<AnyCancellable>()
        
        // Operator: Zip & Merge
        let publisher1 = PassthroughSubject<String, Never>()
        let publisher2 = PassthroughSubject<Int, Never>()
        
        // zip waits for publisher1 and publisher2 to emit a value
        // When both publishers emit, zip produces a tuple with the combined values, which is then handled by sink.
        _ = publisher1
            .zip(publisher2)
            .sink { (string, number) in
                print("Received values: \(string) and \(number)")
            }
        
        publisher1.send("Hello")
        publisher2.send(1)
        

        // Operator: Share
        let pub = (1...3)
            .publisher
            .delay(for: 1, scheduler: DispatchQueue.main)
            .map { _ in return Int.random(in: 0...100) }
            .share() //
        
        _ = pub.sink { print ("Stream 1 received: \($0)") }
        _ = pub.sink { print ("Stream 2 received: \($0)") }
        
        // Operator: ReplaceNil
        [1, nil, 3]
            .publisher
            .replaceNil(with: 0) //
            .sink(receiveValue: { print($0!) })
            .store(in: &subscriptions)

    }
}
