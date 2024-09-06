//
//  LRUCache.swift
//  iOSInterviewGuide
//
//  Created by Karthik MK on 05/09/24.
//

import Foundation

/// LRU Cache using double linked list
final class LRUCache<K: Hashable, V> {

    class Node {
        let key: K
        var value: V
        var prev: Node?
        var next: Node?

        init(key: K, value: V) {
            self.key = key
            self.value = value
        }
    }

    var capacity: Int
    var cache: [K: Node]
    var head: Node?
    var tail: Node?

    init(capacity: Int) {
        self.capacity = capacity
        self.cache = [K: Node](minimumCapacity: capacity)
    }

    func getValue(forKey key: K) -> V? {
        guard let node = cache[key] else { return nil }
        moveToHead(node)
        return node.value
    }

    func set(value: V, forKey key: K) {
        if let node = cache[key] {
            node.value = value
            moveToHead(node)
            return
        }
        // New Insert
        let node = Node(key: key, value: value)
        cache[key] = node
        addToHead(node)
        // Capacity check
        if cache.count > capacity {
            // remove the tail node
            if let tail = self.tail {
                cache.removeValue(forKey: tail.key)
                remove(tail)
            }
        }
    }

    private func addToHead(_ node: Node) { 

        node.next = head
        node.prev = nil

        self.head?.prev = node
        self.head = node

        /// On first insert tail will be nil.
        if tail == nil {
            tail = head
        }
    }

    private func remove(_ node: Node) { 
        let prev = node.prev
        let next = node.next
        
        if prev != nil {
            prev?.next = next
        } else {
            head = next
        }

        if next != nil {
            prev?.next = next
        } else {
            tail = prev
        }
    }

    private func moveToHead(_ node: Node) { 
        remove(node)
        addToHead(node)
    }
}

//let cache = LRUCache<String, Int>(capacity: 5)
//cache.set(value: 10, forKey: "ten")
//cache.getValue(forKey: "ten")
