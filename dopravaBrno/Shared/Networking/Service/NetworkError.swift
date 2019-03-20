//
//  NetworkError.swift
//  challenge
//
//  Created by Thành Đỗ Long on 12/11/2018.
//  Copyright © 2018 Thành Đỗ Long. All rights reserved.
//

import Foundation

public enum NetworkError: Error {
    
    case badRequest
    case notAuthenticated
    case forbidden
    case notFound
    case serverDown
    case unsuccessError(String)
    
    case networkProblem
    case unknown(HTTPURLResponse?)
    case userCancelled
    
    public init(error: Error) {
        self = .networkProblem
    }
    
    public init(response: URLResponse?) {
        guard let response = response as? HTTPURLResponse else {
            self = .unknown(nil)
            return
        }
        switch response.statusCode {
        case NetworkError.badRequest.statusCode: self = .badRequest
        case NetworkError.notAuthenticated.statusCode: self = .notAuthenticated
        case NetworkError.forbidden.statusCode: self = .forbidden
        case NetworkError.notFound.statusCode: self = .notFound
        case NetworkError.serverDown.statusCode: self = .serverDown
        default: self = .unknown(response)
        }
    }
    
    public var isAuthError: Bool {
        switch self {
        case .notAuthenticated: return true
        default: return false
        }
    }
    
    public var statusCode: Int {
        switch self {
        case .badRequest:       return 400
        case .notAuthenticated: return 401
        case .forbidden:        return 403
        case .notFound:         return 404
        case .serverDown:       return 500
            
        case .networkProblem: return 10001
        case .unknown:        return 10002
        case .userCancelled:  return 99999
        case .unsuccessError: return 88888
        }
    }
    
    public var errorMessages: String {
        switch self {
        case .forbidden: return NSLocalizedString("Your access was forbidden", comment: "Error message")
        case .badRequest:  return NSLocalizedString("Your request is bad", comment: "Error message")
        case .unsuccessError(let message): return message
        case .networkProblem: return NSLocalizedString("You seem to be offline.", comment: "Error message")
        default: return NSLocalizedString("We are sorry, the service is unavailable.", comment: "Error message")
        }
    }
}

// MARK: - Equatable
extension NetworkError: Equatable {
    public static func ==(lhs: NetworkError, rhs: NetworkError) -> Bool {
        return lhs.statusCode == rhs.statusCode
    }
}

