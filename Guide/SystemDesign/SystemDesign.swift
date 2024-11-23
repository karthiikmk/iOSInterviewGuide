//
//  SystemDesign.swift
//  iOSInterviewGuide
//
//  Created by Karthik on 07/10/24.
//

import Foundation

/// `System Design`: The big picture of how your system works (who, where, when, which, for)
///
/// `Framework`
/// Step 1 (5 mins): Understand the problem and establish design scope, by the end, we should have a list of features to implement
/// Additionally some non functional requirements to satisfy (scalability, capacity, availablity etc)
/// Step 2 (20 mins): Propose high-level design and get buy-in (20 mins), Design required api and it response (only required for functional requirements)
/// Step 3 (15 mins): Design deep dive
/// Step 4: Wrap up (wrap up)
///
/// `How to approach`
/// 1. Functional Requirements
/// 2. Non-Functional Requirements - Availablitiy, Reliability, Scalability, Fault tolerance, consistency, and security needs.
/// 3. Capacity Estimation - RequestVolume, Storage requirements, Latency, Cache, Analytics requirements and other requirements 
/// 4. Api required
/// 5. System Components - Break down the system into key components or services (e.g., UserService, ProductService, PaymentService etc).
/// 6. Data Flow - Explain how data flows between components
/// 7. Storage and Databases - Describe the database(s) you plan to use (SQL, NoSQL, in-memory caches) and the rationale behind your choice.
/// - For storing product catalogs, a NoSQL database like MongoDB could be used for scalability.
///
/// `High-Level Design (HLD)`: HLD is a bird’s-eye view of the system
/// It’s about the architecture, components, and how the system works at a broad level.
/// Technologies used (e.g., whether you’re using databases, caches, load balancers, queues).
/// Performance considerations (scalability, reliability, fault tolerance).
///
/// `Low-Level Design (LLD)`:
/// LLD focuses on the detailed design of each component.
/// LLD is for developers who will be responsible for building the system.
/// Database schema, API contracts, and interface specifications.
///
/// `Performance Consideration:`
/// Availability - System being accessible and operational when users need it.
/// Reliability - System functions correctly and consistently under specified conditions.
/// Fault Tolerance - System continues to operate even if part of the system fails.
/// Scalability - System's ability to handle increased load and grow over time (like bus and how its handle passengers over time).
/// Security - Protecting the system from malicious attacks and unauthorized access
///
/// Efficiency - An efficient system performs its functions in the most optimal way, often with least resources possible.
/// Maintainability - System is designed in such a way that it's easy to update and upgrade.
/// Modularity - whole system is divided into separate modules, each handling a specific functionality.
///
/// `Tools and Technologies`
///
/// `Databases` - PostgreSQL, MongoDB, DynamoDB
/// Relational Database (RDBMS) - Data in an RDBMS is `structured` in tables, and relationships can be formed between different tables.
/// NoSQL Database - NoSQL databases are non-tabular and store data differently than relational tables. `MongoDB` and `Cassandra` are popular examples
/// In-Memory Database - In-memory databases store data in the memory (RAM) of the server instead of on disk, making data access incredibly fast. Redis is a well-known in-memory database.
/// Graph Database - Graph databases use graph structures to store, map and query relationships. `Neo4j` is a popular graph database
/// Document Databases - Document databases store data in documents similar to JSON objects. MongoDB is a famous document database.
/// Key value stores - In this type of database, data is stored as a collection of key-value pairs where each unique key is associated with a value
/// `Indexing`
/// `Sharding` - Sharding involves breaking your data into smaller parts, or "shards", each held on a separate database server. helping to boost performance and adding redundancy.
/// - to reduce the latency. (reddis, mem-cache)
/// - eviction policies: LRU, LFU, FIFO
/// `Caching` - Redis, Memcached
/// `Search Engines` - Elasticsearch, Solr
/// `Messaging Queue`- for Asyncronous processing. Eg: kafka, RabbitMQ
/// `Cloud Services` - AWS, Azure, Google Cloud
/// 
///
/// `ApiGateWay`:
/// Authorization
/// Rate limiting (prevents DDOS attack)
/// Load Balancing
/// - routing the req to the service which is free or in less load eg: round robbin, least connection
/// - Routing (which req should go to which server)
///
/// `Domain naming system (DNS)`: An api hits the dns to get the ip address followed by hitting the correspoinding api gateway.
/// `Content Delivery Network (CDN)`: distrubute content globaly to reduce the latency
/// its kind of cache for static contents to reduce the latency in loading contents (Eg: Cloudflare, Akamai)
/// `Circuit Breaker` - It monitors for failing service calls and once the failures reach a certain threshold, the circuit breaker trips, and all further calls to the service fail immediately.
///
/// `Communication`
/// `Peer-to-Peer (P2P)` - sharing resources directly without a centralized coordination. eg group of friends sharing files among themself.
/// `Publisher-Subscriber` - "Newspaper pattern", publisher produces data and subscriber consumes it.
///
/// `Components`
/// UserService
/// AnalyticsService
/// MediaService - ObjectStorageService
/// ChatService
/// WebSocketService
/// NotificationService
///
/// `Common Desing Patterns`
///
/// `Example`
/// URL Shortener: Design a URL shortener.
/// Design a UPI app
/// Design a Movie ticket booking app
/// E-Commerce System: Design an e-commerce store like Amazon.
/// Social Media: Design a social network like Facebook, Instagram, or Twitter.
/// Messaging System: Design a chat service like Facebook Messenger or WhatsApp.
///
/// Design a parking lot system.
/// Design a video streaming service like YouTube or Netflix.
/// Design a ride-hailing service like Uber or Lyft.
/// File Storage System: Design a global file storage and sharing service like Dropbox or Google Drive.
