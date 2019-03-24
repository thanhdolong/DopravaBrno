//
//  VendingMachinesAPI.swift
//  dopravaBrno
//
//  Created by Michal Mrnustik on 24/03/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import Foundation
import Unbox

class VendingMachinesAPI {
    private let router = Manager<VendingMachinesEndpoint>()
    
    func getVendingMachines(completion: @escaping (_ :ApiResult<VendingMachineObject>) -> () ) {
        router.getJson(resourceUrl: .vendingMachines, params: nil, paramsHead: nil) { (data, response, error) in
            completion(ApiResult(data, response, error))
        }
    }
}
