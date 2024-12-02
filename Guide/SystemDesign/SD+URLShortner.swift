//
//  URLShortner.swift
//  iOSInterviewGuide
//
//  Created by Karthik on 22/11/24.
//

import Foundation

/// Functional Requirement
/// - Short the orginal url
/// - track hit count, expiration time.
///
/// NonFunctional Requirement
/// Availabilty, Low latency, Scalability, Fault tolernace and Security.

enum URLShortner { }

extension URLShortner {

    /// Stage 1: ORM Implementation
    private struct User {
        let id: UUID = UUID()
        let name: String
        var urls: [URLModel]
    }
    
    class URLModel {
        let id: UUID = UUID()
        let originalUrl: String
        let shortUrl: String
        /// Meta
        let createdAt: Date
        let expiresAt: Date?
        var hitCount: Int = 0
        
        init(
            originalUrl: String,
            shortUrl: String,
            createdAt: Date,
            expiresAt: Date?,
            hitCount: Int
        ) {
            self.originalUrl = originalUrl
            self.shortUrl = shortUrl
            self.createdAt = createdAt
            self.expiresAt = expiresAt
            self.hitCount = hitCount
        }
    }
    
    /// Capacity Esitimation
    /// Request count: How many url shorted per day ?
    /// Timeframe: How long url should be retained in database ?
    /// According to the retention time, we shuld choose either 5 or 6 char for the shortUrl
    /// A 6-character key using alphanumeric characters (62^6) supports `56 billion` combinations.
    /// if 1 million url shorted perday, then 365 million url shorted per year.
    /// so for 5 years of horizon, we might need 365*5 = 1825 million database storage needed.
    
    /// Stage 2: Api Implementation
    ///
    /// POST: /shorten - Creates shorten url for given url
    /// GET: /shortURL - Redirect to original ulr and increment the hit count
    /// DELETE: /shortURL: Delete a shorted url.
        
    /// Stage 3: Service / Component
    class URLShortnerService {
        
        /// Instead of this, connect it with database.
        var cache = [String: URLModel]()
        
        /// Shortens given url
        func shortenUrl(for originalUrl: String) -> URLModel {
            let shortUrl = generateShortUrl(for: originalUrl)
            let shortenedURL = URLModel(
                originalUrl: originalUrl,
                shortUrl: generateShortUrl(for: originalUrl),
                createdAt: Date(),
                expiresAt: nil,
                hitCount: 0
            )
            cache[shortUrl] = shortenedURL
            return shortenedURL
        }
        
        /// Retrive orinal url for short url
        func getOriginalUrl(for shortUrl: String) -> URLModel? {
            return cache[shortUrl]
        }
        
        /// Redirect to original url for the given shortUrl
        func redirectToOriginal(for shortUrl: String) {
            incrementHitCount(for: shortUrl)
            guard let orignalUrl = getOriginalUrl(for: shortUrl) else { return }
        }
        
        // - MARK: Privates
        private func generateShortUrl(for url: String) -> String {
            return ""
        }
        
        private func incrementHitCount(for shortUrl: String) {
            if let urlModel = getOriginalUrl(for: shortUrl) {
                urlModel.hitCount += 1
            }
        }
    }
    
    /// Stage 4: 
    class MainApp {
        let urlShortnerService = URLShortnerService()
        
        func shortUrl(for orignalURL: String) -> URLModel? {
            return urlShortnerService.shortenUrl(for: orignalURL)
        }
        
        func redirectToOrinal(forShortUrl url: String) {
            urlShortnerService.redirectToOriginal(for: url)
        }
    }
}
