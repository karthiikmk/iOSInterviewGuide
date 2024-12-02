//
//  SD+SocialMedia.swift
//  iOSInterviewGuide
//
//  Created by Karthik on 22/11/24.
//

import Foundation

enum SocialMedia { }

/// Functional Requirement
/// User can post
/// User can view feed
/// User can follow other user
/// User can search other users
extension SocialMedia {
    
    ///
    class User {
        let userId: String
        let name: String
        var profileImage: String?
        let emailId: String
        
        var followers = [User]()
        var following = [User]()
        var posts = [Post]()
        var feeds = [Feed]()
        
        init(
            userId: String,
            name: String,
            profileImage: String? = nil,
            emailId: String,
            followers: [User] = [User](),
            following: [User] = [User]()
        ) {
            self.userId = userId
            self.name = name
            self.profileImage = profileImage
            self.emailId = emailId
            self.followers = followers
            self.following = following
        }
    }
        
    /// 540bytes
    struct Post {
        let postId: String
        let userId: String // who created the post
        let postContent: String // can be changed to - ~500 bytes
        let createdAt: Date
        
        init(postId: String, userId: String, postContent: String, createdAt: Date) {
            self.postId = postId
            self.userId = userId
            self.postContent = postContent
            self.createdAt = createdAt
        }
    }
    
    /// Seperate database for storing the feeds
    struct Feed {
        let userId: String
        var posts = [Post]()
    }
    
    /// Capacity Estimation
    /// Avg search per day -
    /// Avg how many feeds user will view - 400
    /// AVg how many followers user can have - 100
    ///
    /// Active Users - 1M (1M * 850 bytes) - 850MB total
    /// Post - 10M (10M * 540 kb) - 5GB/ day
    /// Feed - 1M * (16bytes+postIds(400)) - 40GB/day
    
    /// API Implementation
    /// User
    /// GET: /users/{userId} - view user
    /// POST: /users/{userId}/follow
    /// POST: /users/{userId}/unfollow
    ///
    /// Post
    /// POST: /Users/{userId}/posts - create post
    /// GET: /users/{userId}/posts/{postId} - single post
    /// DELETE: /users/{userId}/posts/{postId} - delete the post
    ///
    /// Feed
    /// GET: /users/{userId}/feeds?limit=20 - get feeds
    ///
    /// Search
    /// GET: users/search - search users by keywords
}
