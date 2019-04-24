//
// Created by Michal Mrnustik on 2019-04-19.
// Copyright (c) 2019 Thành Đỗ Long. All rights reserved.
//

import Foundation

class SotorisAPI {
    private let router = Manager<SotorisEndPoint>()

    func getVehicles(completion: @escaping (_: ApiResult<VehicleObject>) -> Void) {
        router.getJson(resourceUrl: .vehicles, params: nil, paramsHead: nil) { (data, response, error) in
            completion(ApiResult(data, response, error))
        }
    }
}
