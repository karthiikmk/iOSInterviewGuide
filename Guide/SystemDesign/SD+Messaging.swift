//
//  SD+Messaging.swift
//  iOSInterviewGuide
//
//  Created by Karthik on 22/11/24.
//

import Foundation

/// Functional Requirements
/// Profile
/// one to one chat
/// one to many chat (group)
/// Media support (audio, video, image)
/// Status support
///

enum Messaging { }

extension Messaging {
    
    /// Profile
    class User {
        let userId: UUID = UUID()
        let name: String
        let profileImage: String?
        init(name: String, profileImage: String?) {
            self.name = name
            self.profileImage = profileImage
        }
    }
    
    struct Group {
        let groupId: String
        let name: String
        let groupProfileImage: String?
        let members: [User]
        let adminIds: [String]
    }
    
    enum MessageType {
        case text(String)
        case media(String)
    }
    
    enum MessageStatus {
        case sent, delivered, read
    }
    
    /// Message
    struct Message {
        let messageId: String
        let senderId: String // user
        let chatId: String // senderId,receiverId | groupId
        let type: MessageType
        let createdAt: Date
        let status: MessageStatus
    }
    
    enum ChatType {
        case direct, group
    }
    
    /// ChatConversation (list of recents)
    struct Chat {
        let chatId: String // sender,receiver | groupId
        let type: ChatType
        var recentMessage: Message? = nil
        var unreadCount: Int = 0
        var messages = [Message]()
    }
        
    /// Capacity Estimation
    /// 
    /// Number of ActiveUser - 10 Million (100,000,000) - 8zeros
    /// Message volume - 100 message / user
    /// Storage:
    /// Text Mesasge - ~1KB bytes / message
    ///   for a user/day = 100 * 1KB = 0.1MB
    ///   for 10M = 0.1MB * 10 = 100 GB / day
    /// Media Mesasge - ~1MB / message
    ///   for a user/day = 10% are media = 10 * 1Mb = 10MB
    ///   for 10M = 10MB * 10 = 1000 TB/day
    ///
        
    /// Api
    ///
    /// Profile:
    /// GET: /users/{userId} - get profile
    /// PUT: /users/{userId} - update profile
    ///
    /// Chat:
    /// GET: /chats/{chatID}/messages?limit=50 - fetch batch messages
    /// POST: /chats/{chatID}/messages - send messages
    ///
    /// Group:
    /// POST: /groups - create group
    /// GET: /groups/{groupId} - get the groups
    /// POST: /groups/{groupId}/memebers - add members to the group
    /// DELETE: /groups/{groupId}/members/{membersId} - delete the members
}
