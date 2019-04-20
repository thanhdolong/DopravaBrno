//
// Created by Michal Mrnustik on 2019-04-20.
// Copyright (c) 2019 Thành Đỗ Long. All rights reserved.
//

import Foundation

enum IdsJmkEndpoint {
    case stops
}

extension IdsJmkEndpoint: EndPointType {


    var baseURL: URL {
        guard let url = URL(string: "https://mapa.idsjmk.cz/api/") else {
            fatalError("Invalid url set for the endpoint")
        }
        return url
    }

    var path: String {
        switch self {
        case .stops:
            return "stops.json"
        }
    }


}
