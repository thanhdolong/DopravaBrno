//
//  LocationAPI.swift
//  challenge
//
//  Created by Thành Đỗ Long on 13/11/2018.
//  Copyright © 2018 Thành Đỗ Long. All rights reserved.
//

import Foundation
import Alamofire

class SandboxAPI {
    private let routerSandbox = Manager<SandboxEndPoint>()
    private let routerStatus = Manager<StatusEndPoint>()
    
    func getPosts( completion: @escaping (_ data: Any?, _ error: NetworkError?)->() ){
        routerSandbox.getJson(resourceUrl: .posts, params: nil, paramsHead: nil) { (data, header, error) in
            // Todo: Change into model
            
            completion(data, error)
            return
        }
    }
    
    func getStatus(id: Int, completion: @escaping (_ data: Any?, _ error: NetworkError?)->()) {
        routerStatus.getJson(resourceUrl: .status(id: id), params: nil, paramsHead: nil) { (data,header, error) in
            completion(data, error)
            return
        }
    }
    
}

