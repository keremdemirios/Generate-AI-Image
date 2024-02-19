//
//  APIUrls.swift
//  AI Image
//
//  Created by Kerem Demir on 19.02.2024.
//

import Foundation

enum APIUrls {
    static func getImageUrl() -> String {
        return "https://api.openai.com/v1/images/generations"
    }
//    
//    static func getUsersFollowers(userID: String, count: Int, end_cursor: Int) -> String {
//        return "https://api.instagapi.com/userfollowers/\(userID)/\(count)/\(end_cursor)"
//    }
//    
//    static func getUsersFollowing(userID: String, count:Int, end_cursor: Int) -> String {
//        return "https://api.instagapi.com/userfollowing/\(userID)/\(count)/\(end_cursor)"
//    }
//    
//    static func getUserID(username: String) -> String {
//        "https://api.instagapi.com/userid/\(username)"
//    }
    
}

enum APIError: Error {
    case unableToCreateImageURL
    case unableToConvertDataIntoImage
    case unableToCreateURLForURLRequest
}
