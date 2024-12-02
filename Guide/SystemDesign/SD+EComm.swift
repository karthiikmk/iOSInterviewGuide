//
//  SD+EComm.swift
//  iOSInterviewGuide
//
//  Created by Karthik on 22/11/24.
//

import Foundation

/// https://iosinterviewguide.com/system-design-interview/ecommerce
enum EComm { }

extension EComm {
    
    /// 316 bytes
    class User {
        let userId: String // 16 bytes
        let name: String // 50 bytes
        let email: String // 50 bytes
        let address: String // 200 bytes
        var orders = [Order]() // history of orders
        init(userId: String, name: String, email: String, address: String, orders: [EComm.Order] = [Order]()) {
            self.userId = userId
            self.name = name
            self.email = email
            self.address = address
            self.orders = orders
        }
    }
    
    /// ~700 bytes
    class Product {
        let productId: String // 16b
        let name: String // 100 b
        let description: String // 500b
        let price: Double // 8bytes
        init(productId: String, name: String, description: String, price: Double) {
            self.productId = productId
            self.name = name
            self.description = description
            self.price = price
        }
    }
    
    class CartItem {
        let product: Product
        var quantity: Int
        init(product: Product, quantity: Int) {
            self.product = product
            self.quantity = quantity
        }
        
        var cost: Double { Double(quantity) * product.price }
    }
    
    /// Server keeps cart for each user.
    class Cart {
        var items = [String: CartItem]() // productId: CartItem
        var totalAmount: Double { items.values.reduce(0) { $0 + $1.cost } }
      
        func addProduct(_ product: Product, quantity: Int) -> Bool {
            guard isAvailable(product, quantity: quantity) else { return false }
            guard let item = items[product.productId] else {
                let cartItem = CartItem(product: product, quantity: quantity)
                items[product.productId] = cartItem
                return true
            }
            item.quantity += quantity
            return true
        }
        
        func removeProduct(_ product: Product) {
            items.removeValue(forKey: product.productId)
        }
        
        func clearCart() {
            items.removeAll()
        }
        
        func isAvailable(_ product: Product, quantity: Int) -> Bool {
            /// Make server call to check the availablity
            return true
        }
    }
    
    class OrderItem {
        let product: Product
        let quantity: Int
        init(product: Product, quantity: Int) {
            self.product = product
            self.quantity = quantity
        }
    }
    
    class Order {
        let orderId: UUID = UUID()
        let items: [OrderItem]
        let status: String // pending, confirmed, shipped, delivered, cancelled
        let totalAmount: Double
        init(items: [OrderItem], status: String, totalAmount: Double) {
            self.items = items
            self.status = status
            self.totalAmount = totalAmount
        }
    }
    
    /// Service / Components
    class CartService {
        var carts = [String: Cart]() // userId: Cart
        
        func getCart(forUserId userId: String) -> Cart {
            if let cart = carts[userId] {
                return cart
            }
            let newCart = Cart()
            carts[userId] = newCart
            return newCart
        }
    }
    
    class OrdereService {
        var orders = [String: Order]() // userId: Order
        
        func createOrder(forUser user: User, cart: Cart) -> Order? {
            guard !cart.items.isEmpty else { return nil }
            let items = cart.items.values.map { OrderItem(product: $0.product, quantity: $0.quantity) }
            let order = Order(items: items, status: "Pending", totalAmount: cart.totalAmount)
            orders[user.userId] = order
            cart.clearCart()
            return order
        }
        
        func getOrder(forUserId userId: String) -> Order? {
            return orders[userId]
        }
    }
    
    /// Capacity Estimation
    ///
    /// Daily Active Users: 1M
    /// Total Products ~10L
    /// 10000 active users either adds cart / placing orders
    /// Totally 50000 orders per day
    /// avg cart contains - 5 items
    /// avg order contains - 3 items
    ///
    /// Storage
    /// Users: 1M users * 316 bytes = ~316 MB
    /// Product: 10L * 700 bytes = ~70 MB
    /// Cart: 1L*5*60bytes = ~30MB/day
    /// Orders: 50000*3*60bytes = ~9MB/day
    ///
    
    /// API Implementation
    ///
    /// Users
    /// GET: /users/{userId}
    ///
    /// Product
    /// POST: /products - adding product
    /// GET: /products/{productId} - get product details
    ///
    /// Cart
    /// POST: /Users/{userId}/carts - add cart
    /// GET: /Users/{userId}/carts/{cartId}
    ///
    /// Order
    /// POST: /Users/{userId}/Orders
    /// GET: /Users/{userId}/Orders/{orderId}
}
