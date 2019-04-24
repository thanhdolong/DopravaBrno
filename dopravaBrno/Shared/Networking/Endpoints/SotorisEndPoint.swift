//
//  SotorisEndPoint.swift
//  dopravaBrno
//
//  Created by Thành Đỗ Long on 22/03/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import Foundation

public enum SotorisEndPoint {

//  Get all vehicles
    case vehicles
    
//  This filter allows you to list only specific lines (currently only one). It can be entered according to both the classic line number (route parameter) or routeLabel
    case vehicle(route:String)
}

extension SotorisEndPoint: EndPointType {
    var path: String {
        switch self {
        case .vehicles:
            return "vehiclesBrno.aspx"
        case .vehicle(let route):
            return "vehiclesBrno.aspx?route=" + route
        }
    }

    fileprivate var environmentBaseURL: String {
        switch NetworkClient.environment {
        case .production: return "https://sotoris.cz/DataSource/CityHack2015/"
        case .develop: return "https://sotoris.cz/DataSource/CityHack2015/"
        }
    }

    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else {
            fatalError("baseURL could not be configured.")
        }
        return url
    }
}
