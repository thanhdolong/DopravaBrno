//
//  ApiResult.swift
//  challenge
//
//  Created by Do Long Thanh on 13/11/2018.
//  Copyright © 2016 ShengHua Wu. All rights reserved.
//

import Foundation
import Unbox
import Foundation

enum ApiResultEror: Error {
    case runtimeError(String)
}

class ApiResult<UnboxableObject: Unboxable> {
    private let data: Any?
    private let error: NetworkError?
    private let header: [AnyHashable : Any]?
    private let statusCode: Int?
    
    init(_ data: Any?,_ header: HTTPURLResponse? ,_ error: NetworkError?) {
        self.data = data
        self.error = error
        self.header = header?.allHeaderFields
        self.statusCode = header?.statusCode
    }
    
    func getStatusCode() throws -> Int {
        guard let statusCode = statusCode else {
            if let error = error { throw error }
            throw NetworkError.unsuccessError("[StatusCodeError] An error occured while trying get status code.")
        }
        return statusCode
    }
    
    func getBody() throws -> Any {
        guard let data = data else {
            if let error = error { throw error }
            throw NetworkError.unsuccessError("[BodyError] An error occured while trying unwrap body responze")
        }
        return data
    }
    
    func getHeader() throws -> [AnyHashable : Any] {
        guard let header = header else {
            if let error = error { throw error }
            throw NetworkError.unsuccessError("[HeaderError] An error occured while trying unwrap header responze")
        }
        return header
    }
    
    func getHeaderField(key: String) throws -> Any {
        do {
            let header = try getHeader()
            
            guard let result = header[key] else {
                if let error = error { throw error }
                throw NetworkError.unsuccessError("[HeaderError] An error occured while trying get specific key from header responze")
            }
            
            return result
        } catch (let error){
            throw error
        }
    }
    
    func unwrap() throws -> [UnboxableObject] {
        do {
            if let data = data as? [String: AnyObject] {
                print("1) unbox [String: AnyObject]")
                let unboxedJSON: UnboxableObject = try unbox(dictionary: data)
                return [unboxedJSON]
            }else if let data = data as? [[String: AnyObject]] {
                print("2) unbox [[String: AnyObject]]")
                let unboxedJSON: [UnboxableObject] = try unbox(dictionaries: data)
                return unboxedJSON
            } else if let data = data as? Data {
                print("3) unbox Data")
                let unboxedJSON: [UnboxableObject] = try unbox(data: data)
                return unboxedJSON
            } else {
                if let error = error { throw error }
                throw ApiResultEror.runtimeError("[DataError] An error occured while trying unwrap responze")
            }
        } catch (let error){
            throw error
        }
    }
}
