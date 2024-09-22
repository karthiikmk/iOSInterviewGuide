//
//  MyPlayground.swift
//  iOSInterviewGuide
//
//  Created by Karthik on 21/09/24.
//

import Foundation

class MyPlayground {
    
    class LRUCache<K: Hashable, V: Comparable>: CustomStringConvertible {
        
        class Node: CustomStringConvertible {
            let key: K
            var value: V
            var next: Node?
            var prev: Node?
            
            init(key: K, value: V) {
                self.key = key
                self.value = value
            }
            
            var description: String {
                var result = ""
                // Traverse backward to find the head of the list
                var current: Node? = self
                while let prevNode = current?.prev {
                    current = prevNode
                }
                // Now traverse forward and build the string representation
                while let currentNode = current {
                    result += "\(currentNode.value)"
                    if currentNode.next != nil {
                        result += " -> "
                    }
                    current = currentNode.next
                }
                return result
            }
        }
        
        var cache = [K: Node]()
        let capacity: Int
        
        var head: Node?
        var tail: Node?
                
        init(capacity: Int) {
            self.capacity = capacity
            self.cache = [K: Node](minimumCapacity: capacity)
        }
        
        func get(for key: K) -> V? {
            guard let node = cache[key] else { return nil }
            moveToHead(node)
            return node.value
        }
        
        func set(value: V, forK key: K) {
            if let node = cache[key] {
                node.value = value // as its ref type, am just updating the value
                moveToHead(node)
                return
            }
            let node: Node = .init(key: key, value: value)
            cache[key] = node
            addToHead(node)
            /// Eviction
            if cache.count > capacity {
                if let tail = tail {
                    cache.removeValue(forKey: key)
                    remove(tail)
                }
            }
        }
        
        /// is not removign the tail
        private func remove(_ node: Node) {
            let prev = node.prev // either nil or have value
            let next = node.next
            
            if prev != nil { //some prev is there
                prev?.next = next
            } else {
                head = next // if there is no previous, then that is head
            }
                        
            if next != nil { // some next is there
                next?.prev = prev
            } else {
                tail = prev // next is not there, means tail
            }
        }
        
        private func addToHead(_ node: Node) {
            node.next = head
            node.prev = nil
            
            head?.prev = node
            head = node
            
            if tail == nil {
                tail = head
            }
        }
        
        private func moveToHead(_ node: Node) {
            remove(node)
            addToHead(node)
        }
        
        var description: String {
            return head?.description ?? ""
        }
    }
    
    func run() {
        let cache = LRUCache<String, Int>(capacity: 3)
        cache.set(value: 1, forK: "one")
        cache.set(value: 2, forK: "two")
        cache.set(value: 3, forK: "three")
        // cache.
//        cache.set(value: 4, forK: "four")
//        cache.set(value: 5, forK: "five")
//        cache.set(value: 6, forK: "six")
        print(cache)
    }
}
