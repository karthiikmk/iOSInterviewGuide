//
//  iOS+Coredata.swift
//  iOSInterviewGuide
//
//  Created by Karthik on 19/12/24.
//

import Foundation

/// Coredata a powerful framework provided by apple for managing the object graphs
/// It simplifys the process of storing, fetching, updating and deleting data making it valulable tool for developers.
///
/// To talk more about coredata, we should go by each component. 
///
/// Persistent store: The actual data storage mechanism, which could be SQLite, XML, binary, or in-memory store.
///
/// Persistent Store Coordinator: Sits between the managed object context and the persistent store. It is responsible for managing the persistent store(s) and coordinating access to them.
///
/// Managed object context: Works as a buffer in which you create, modify, and delete objects
///
/// Managed object: Represents a single instance of an entity
///
/// Entity Relationships: Core Data supports to-one and to-many relationships, and these relationships can be unidirectional or bidirectional, with various delete rules such as “nullify,” “cascade,” and “deny.”
///
/// Fetching Data: Data is retrieved from Core Data using NSFetchRequest, which can be customized with NSPredicate for filtering and NSSortDescriptor for sorting. Fetch requests can be executed to return either managed objects, dictionaries, or specific values.
///
/// Core Data provides various tools and techniques for optimizing performance, such as `fetch batching`, property faulting, relationship faulting, and using `indexes` on entity properties.
///
/// Versioning and Migration: Core Data supports model versioning and migration, which helps manage changes to the model over different releases of an application. Lightweight migrations can handle simple changes automatically, while more complex migrations might require a mapping model.
///
/// NSMergePolicy: A policy object that you use to resolve conflicts between the persistent store and in-memory versions of managed objects.
/// mergeByPropertyStoreTrump: A property-based merge policy that applies external changes. if there is a conflict between the value stored persistently (e.g., in a database or file) and the value currently held in memory, the value from the persistent store will overwrite the value in memory.
/// mergeByPropertyObjectTrump: A property-based merge policy that applies in-memory changes.
/// overwrite: A merge policy that overwrites the entire stored object.
/// error, and rollback
