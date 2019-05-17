//
// Created by Michal Mrnustik on 2019-04-20.
// Copyright (c) 2019 Thành Đỗ Long. All rights reserved.
//

import Foundation
import Unbox
class IdsJmkAPI {
    private let router = Manager<IdsJmkEndpoint>()

    func getStops(completion: @escaping (_: ApiResult<StopObject>) -> Void) {
        router.getJson(resourceUrl: .stops, params: nil, paramsHead: nil) { (data, response, error) in
            completion(ApiResult(data, response, error))
        }
    }
    
    func getVehicles(completion: @escaping (_: ApiResult<VehicleObject>) -> Void) {
        router.getJson(resourceUrl: .vehicles, params: nil, paramsHead: nil) { (data, response, error) in
           
            completion(ApiResult(data, response, error))
        }
    }
}
