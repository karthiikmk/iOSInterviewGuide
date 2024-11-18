//
//  SystemDesign.swift
//  iOSInterviewGuide
//
//  Created by Karthik on 07/10/24.
//

import Foundation

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
 
 ApiGateWay
    - Authorization
    - Validation
    - Rate limiting
    - Routing (which req should go to which server)
    - Load Balancing (routing the req to the service which is free or in less load)
    - Request Transformation
  
 DNS: Api Hits the dns to get the ip address followed by hitting the correspoinding api gateway.
 CDN: kind of cache for static contents to reduce the latency in loading contents
 
 
 Mallescious request,
 DDOS Attack - rate limiting can prevent
 
*/
