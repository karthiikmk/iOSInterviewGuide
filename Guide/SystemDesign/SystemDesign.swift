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
///
/// `Distributed Storage` Distributed Storage refers to a system where data is `stored across multiple physical or virtual machines`, often in a way that makes the system scalable, fault-tolerant, and highly available.
/// Eg: Amazon S3, Google file system (GFS)
///
/// `Distributed Cache` is a high-performance, scalable caching system where `frequently accessed data is stored in memory across multiple nodes` in a cluster.
/// Eg: Reddis, memcached
///
/// `Indexing`
/// `Sharding` - Sharding involves breaking your data into smaller parts, or "shards", each held on a separate database server. helping to boost performance and adding redundancy.
/// - to reduce the latency. (reddis, mem-cache)
/// - eviction policies: LRU, LFU, FIFO
/// `Caching` - Redis, Memcached
/// `Search Engines` - Elasticsearch, Solr
/// `Messaging Queue`- for Asyncronous processing. Eg: kafka, RabbitMQ
/// `Cloud Services` - AWS, Azure, Google Cloud
/// 
/// `ApiGateWay`: In general api gateway is a centralized service that act as a proxy to manage and route incoming api requests to one or more backend services.
///
/// `AWS ApiGateway` - Service provided by amazon webservice to build, deploy, maintain, monitor and secure api at scale
/// - Scalability
/// - Security (AWS Cognito)
///     - Authentication
///     - Authorization (IAM, Lambda Authorizers, OAUth2 for securing Apis)
///  - Request Validation: Validate request payloads, headers and queryparams before forwarding to backend.
///  - DDos Protection (AWS Schield)
///     -  for distribured denia-of-service protection
///     - Implements throttlening and rate-limiting to prevent misuse.
///  - Mointoring (AWS Cloudwatch)
///
/// `Load Balancing`
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
/// `Publisher-Subscriber` - "Newspaper pattern", publisher produces data and subscriber consumes
///
/// `Database
///
/// DBMS Software - SQL, PostgressSQL, MongoDB
/// ACID Properties - Automicity, Consistency, Isolation and Durability (use ticket booking example for understanding)
/// Automicity - task should done completely (not half succussful half failure), like booking 10 tickets, 5 gets booked and 5 failed
/// Consistency - Table A -> Table B (relationship should kept in proper shape even after the update), basically should follow table constraints properly.
/// Isolation - read/write should happen in isolation. (should handle the concurrency properly)
/// Durability - Transaction should be show the result properly, should not revert its state after sometime
///
/// `SQL` - MySQL, PostgreSQL
///  - use when data is very much structured and having relation ships
///  - when schema doesn't change very often
///  - ACID complience (ƒinance, banking sectors ect)
///
/// `NOSQL` - Cassandra, ElasticSearch, AWSDynamoDB, Reddis
///  - use when data is not structured (like json etc)
///  - to handle fast read and write (eg: analtyics, feeds etc)
///  - to store large amount of data (eg: click streams, sensor data, logs etc)
///
/// `Normalization` - process of organizing database to avoid redundancy
/// PrimaryKey (PK) - unique key in the table. used for `indexing` as well.
/// ForeignKey (FK) - connecting tables, (when delete parent table row, cascading will delete this row as well)
/// CandidateKey (CK) - Having multipleKey to create primary key (uniqueKey), eg email+phone = candidateKey
///
/// `Normal Forms`
///
/// 1NF - Each row should have atomic value, no duplicated value
///
/// 2NF - should not have paritial dependency
/// -------------------------------------------------------
/// StudentId | CourseId | StudentName | CourseName
/// -------------------------------------------------------
/// 1         | 101      | Karthik     | Maths
/// 2         | 102      | Vishwa      | Science
/// 1         | 103      | Karthi      | English
/// -------------------------------------------------------
/// Primary Key - studentId, courseId
/// Partial Dependency - Student name depends on studentId, not on courseId
/// So we should be removing the partial depenceny from the above entity.
/// Normalization help to update the records easily, as it needs to update in single place rather manyplace
///
///-----------------------
/// StudentId | StudentName
///-----------------------
/// 1         | Karthik
/// 2         | Vishwa
///-----------------------
///
///-----------------------
/// CourseId | CourseName
///-----------------------
/// 101      | Maths
/// 102      | Science
/// 103      | English
///-----------------------
///
/// 3NF - should not have transitive dependency
///
/// `Denormalization` (combining multiple table for efficient access)
///  Creating new table where having freqent access properites from other tables
///
///  `Locking`
///  Table level locking
///  Row level locking
///  Page level locking
///
///  `Indexing` - Datastructure
///  Type of indexing - BalancedTree, Hashing
///  Clustered,
///  Non Clustered - Hashtable (maintains referene for the acutal data)
///
///  `Optimization`
///  QueryOptimization
///  indexing
///  Caching
///  Sharding
///  CAP Therom (Consistency, Availabilty, and Partition Tolerance)
///
///  `Weak Entity` - data stored in this entity can't be uniquely identified by its attributes alone.
///  Eg: EmployeeSkill, AccessControll entity 
///
///  `Summary`
///
///  Use 1NF to check the row values automicity
///  Apply 2NF and 3NF for removing paritial or transitive dependencies
///  Apply 3.5NF for makeing the 3NF better.

/// `Components`
/// UserService
/// AnalyticsService
/// MediaService - ObjectStorageService
/// ChatService
/// WebSocketService
/// NotificationService

/// `Common Desing Patterns`
///
/// `Example`
/// URL Shortener: Design a URL shortener.
/// Design a UPI app
/// Design a Movie ticket booking app
/// E-Commerce System: Design an e-commerce store like Amazon.
/// Social Media: Design a social network like Facebook, Instagram, or Twitter.
/// Messaging System: Design a chat service like Facebook Messenger or WhatsApp.
/// File Storage System: Design a global file storage and sharing service like Dropbox or Google Drive.
/// Design a parking lot system.
///
/// Authentication
/// Search
/// Design a google maps
/// Design a video streaming service like YouTube or Netflix.
/// Design a ride-hailing service like Uber or Lyft.

/*
 The key to answering system design interview questions is understanding the big picture of how your system works.
 
 High-Level Design (HLD): HLD is a bird’s-eye view of the system, focusing on the overall structure and how different components interact.
    - It’s about the architecture, components, and how the system works at a broad level.
    - Technologies used (e.g., whether you’re using databases, caches, load balancers, queues).
    - Performance considerations (scalability, reliability, fault tolerance).
    - High-level diagrams showing the overall structure.
    - If you’re designing an e-commerce system, your HLD might discuss the architecture: web servers, databases, caching, API layers, and how components like product catalogs, user profiles, and orders will communicate.
 Low-Level Design (LLD):
    - LLD focuses on the detailed design of each component.
    - LLD is for developers who will be responsible for building the system.
    - Database schema, API contracts, and interface specifications.
    - In an e-commerce system, LLD would define how the product catalog will be implemented (e.g., class definitions, methods, how caching works for products, database queries, indexing, etc.).
 
 
 System Design Patterns:

 Primary-Replica -
 Peer-to-Peer (P2P) - sharing resources directly without a centralized coordination. eg group of friends sharing files among themself.
 Publisher-Subscriber - "Newspaper pattern", publisher produces data and subscriber consumes it.
 Sharding - Sharding involves breaking your data into smaller parts, or "shards", each held on a separate database server. helping to boost performance and adding redundancy.
 Circuit Breaker - It monitors for failing service calls and once the failures reach a certain threshold, the circuit breaker trips, and all further calls to the service fail immediately.
 
 Databases and Storage Systems:
 
 Relational Database (RDBMS) - Data in an RDBMS is structured in tables, and relationships can be formed between different tables
 NoSQL Database - NoSQL databases are non-tabular and store data differently than relational tables. MongoDB and Cassandra are popular examples
 In-Memory Database - In-memory databases store data in the memory (RAM) of the server instead of on disk, making data access incredibly fast. Redis is a well-known in-memory database.
 Graph Database - Graph databases use graph structures to store, map and query relationships. Neo4j is a popular graph database
 Document Databases 0 Document databases store data in documents similar to JSON objects. MongoDB is a famous document database.
 Key value stores - In this type of database, data is stored as a collection of key-value pairs where each unique key is associated with a value
 Column Store databases
 
 
 - Requirements clarification
 - Defining the data model
 
 
 Design URL shortening service.
 Design a social network like Facebook, Instagram, or Twitter.
 Design a global chat service like Facebook Messenger or WhatsApp.
 Design a global video streaming service like YouTube or Netflix.
 Design a ride-hailing service like Uber or Lyft.
 Design a global file storage and sharing service like Dropbox or Google Drive.
 Design a parking lot system.
 Design an e-commerce store like Amazon.
 
 Fault Tolerance - System continues to operate even if part of the system fails.
 Availability - System being accessible and operational when users need it.
 Scalability - System's ability to handle increased load and grow over time (like bus and how its handle passengers over time).
 Efficiency - An efficient system performs its functions in the most optimal way, often with least resources possible.
 Reliability - System functions correctly and consistently under specified conditions
 Consistency - Data in the system remains the same across all the components in all the cases.
 Security - Protecting the system from malicious attacks and unauthorized access
 Maintainability - System is designed in such a way that it's easy to update and upgrade.
 Modularity - whole system is divided into separate modules, each handling a specific functionality.
 
 
 Framework:
 Step 1: Understand the problem and establish design scope (5 mins)
    By the end, we should have a list of features to implement
    Additionally some non functional requirements to satisfy (scalability, capacity, availablity etc)
 Step 2: Propose high-level design and get buy-in (20 mins)
    Design required api and it response (only required for functional requirements)
 Step 3: Design deep dive (15 mins)
 Step 4: Wrap up (wrap up)
 
 
 1. Functional Requirements
 2. Non-Functional Requirements
    - Highlight scalability, performance, fault tolerance, consistency, and availability needs.
 3. Capacity Estimation
 4. Api required
 3. System Components
    - Break down the system into key components or services (e.g., user service, product service, payment service).
 4. Data Flow
    - Explain how data flows between components
 5. Data Storage and Databases
    - Describe the database(s) you plan to use (SQL, NoSQL, in-memory caches) and the rationale behind your choice.
    - For storing product catalogs, a NoSQL database like MongoDB could be used for scalability.
  
 DNS: Api Hits the dns to get the ip address followed by hitting the correspoinding api gateway.
 CDN: kind of cache for static contents to reduce the latency in loading contents
 
 Mallescious request,
 DDOS Attack - rate limiting can prevent
 
*/
