//
//  Manager.swift
//  challenge
//
//  Created by Thành Đỗ Long on 13/11/2018.
//  Copyright © 2018 Thành Đỗ Long. All rights reserved.
//

import Foundation
import Alamofire
import Unbox

enum PostType {
    case formUrlencoded
    case formData
}

class Manager<EndPoint: EndPointType> {
    
    private let networkCLient = NetworkClient()
    
    func getJson(
        resourceUrl: EndPoint,
        params: [String: Any]?,
        paramsHead: [String: String]?,
        completion: @escaping (Any? , HTTPURLResponse?, NetworkError?) -> Void) {
        
        let resourceUrl = resourceUrl.baseURL.appendingPathComponent(resourceUrl.path)
        
        let encoding: URLEncoding = URLEncoding(destination: .queryString)
        
        networkCLient.requestJsonFor(resourceUrl: resourceUrl,
                                 method: .get,
                                 parametersBody: params,
                                 parametersHead: paramsHead,
                                 encoding: encoding) { (response, status) in
                                    
            switch status {
            case .success:
                self.responseParser(response: response, completion: completion)
            case .failure:
                completion(nil, nil, NetworkError(response: response.response))
            }
        }
    }
    
    func getData(resourceUrl: EndPoint,
                 params: [String: Any]?,
                 paramsHead: [String: String]?,
                 completion: @escaping (Data? , HTTPURLResponse?, NetworkError?) -> Void) {
        
        let resourceUrl = resourceUrl.baseURL.appendingPathComponent(resourceUrl.path)
        
        let encoding: URLEncoding = URLEncoding(destination: .queryString)
        
        networkCLient.requestDataFor(resourceUrl: resourceUrl,
                                     method: .get,
                                     parametersBody: params,
                                     parametersHead: paramsHead,
                                     encoding: encoding) { (response, status) in
                                        
                                        switch status {
                                        case .success:
                                            completion(response.result.value, response.response, nil)
                                        case .failure:
                                            completion(nil, nil, NetworkError(response: response.response))
                                        }
        }
    }
    
    func post(resourceUrl: EndPoint,
              paramsHead: [String: String]?,
              paramsBody: [String: Any]?,
              completion: @escaping (Any? , HTTPURLResponse?, NetworkError?) -> Void) {
        
        let resourceUrl = resourceUrl.baseURL.appendingPathComponent(resourceUrl.path)

        let encoding: URLEncoding = URLEncoding.default
        
        networkCLient.requestJsonFor(resourceUrl: resourceUrl,
                                 method: .post,
                                 parametersBody: paramsBody,
                                 parametersHead: paramsHead,
                                 encoding: encoding) { (response, status) in
                                    
                                    switch status {
                                    case .success:
                                        self.responseParser(response: response, completion: completion)
                                    case .failure:
                                        guard let data = response.data else {
                                            return completion(nil, response.response, NetworkError(response: response.response))
                                        }
                                        
                                        completion(data, response.response, NetworkError(response: response.response))
                                    }
        }
    }
    
    private func responseParser(
        response: DataResponse<Any>,
        completion: @escaping(Any?, HTTPURLResponse?, NetworkError?) -> Void) {
        guard let body = response.result.value, let header = response.response else {
            completion(nil, nil, NetworkError.unsuccessError("ResultError] Cannot return the result of responze serialization"))
            return
        }
        
        return completion(body, header, nil)
    }
}
