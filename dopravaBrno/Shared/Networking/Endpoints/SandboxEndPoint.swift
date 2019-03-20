//
//  SandboxEndPoint.swift
//  challenge
//
//  Created by Thành Đỗ Long on 13/11/2018.
//  Copyright © 2018 Thành Đỗ Long. All rights reserved.
//

import Foundation

public enum SandboxEndPoint {
    case posts
    case post(id:Int)

    case comments
    case comment(id:Int)
    
    case albums
    case album(id:Int)
    
    case photos
    case photo(id:Int)
    
    case todos
    case todo(id:Int)
    
    case users
    case user(id:Int)
}

extension SandboxEndPoint: EndPointType {

    fileprivate var environmentBaseURL : String {
        switch NetworkClient.environment {
        case .production: return "https://jsonplaceholder.typicode.com/"
        case .develop: return "https://jsonplaceholder.typicode.com/"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    
    var path: String {
        switch self {
        case .posts:
            return "posts"
        case .post(let id):
            return "posts\(id)"
        case .comments:
            return "comments"
        case .comment(let id):
            return "comments/\(id)"
        case .albums:
            return "albums"
        case .album(let id):
            return "albums\(id)"
        case .photos:
            return "photos"
        case .photo(let id):
            return "photos\(id)"
        case .todos:
            return "todos"
        case .todo(let id):
            return "todos\(id)"
        case .users:
            return "users"
        case .user(let id):
            return "users\(id)"
        }
    }
}
