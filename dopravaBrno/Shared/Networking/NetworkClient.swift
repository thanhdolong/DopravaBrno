//
//  NetworkClient.swift
//  challenge
//
//  Created by Thành Đỗ Long on 13/11/2018.
//  Copyright © 2018 Thành Đỗ Long. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

public final class NetworkClient {
    static let environment: NetworkEnvironment = .develop
    
    fileprivate let sessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        
        var headers = SessionManager.defaultHTTPHeaders
        headers["Accept"] = "application/json"
        headers["lang"] = NSLocale.current.languageCode
        headers["platform"] = "IOS"
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            headers["client-version"] = version
        }
        headers["X-Device-Identifier"] = UUID().uuidString
        
        configuration.httpAdditionalHeaders = headers
        configuration.requestCachePolicy = .reloadIgnoringCacheData
        return Alamofire.SessionManager(configuration: configuration)
    }()
    
    
    func requestDataFor(resourceUrl: URL, method: Alamofire.HTTPMethod, parametersBody: [String: Any]?, parametersHead: [String: String]?, encoding: URLEncoding, completion: @escaping(DataResponse<Data>, Result<Data>) -> Void) {
        var headers = [String : String]()
        if let parametersHead = parametersHead {
            headers = parametersHead
        }
        
        sessionManager.request(resourceUrl, method: method, parameters: parametersBody, encoding: encoding, headers: headers).validate().responseData { (response) in
            completion(response, response.result)
        }
    }

    func requestJsonFor(resourceUrl: URL, method: Alamofire.HTTPMethod, parametersBody: [String: Any]?, parametersHead: [String: String]?, encoding: URLEncoding, completion: @escaping(DataResponse<Any>, Result<Any>) -> Void) {
        var headers = [String : String]()
        if let parametersHead = parametersHead {
            headers = parametersHead
        }
        
            sessionManager.request(resourceUrl, method: method, parameters: parametersBody, encoding: encoding, headers: headers).validate().responseJSON { (response) in
                completion(response, response.result)
        }
    }
}
