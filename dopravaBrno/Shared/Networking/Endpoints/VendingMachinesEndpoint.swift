//
//  VendingMachinesEndpoint.swift
//  dopravaBrno
//
//  Created by Michal Mrnustik on 24/03/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import Foundation

public enum VendingMachinesEndpoint {
    case vendingMachines
}

extension VendingMachinesEndpoint : EndPointType {
    var path: String {
        switch self {
        case .vendingMachines:
            return "vending-machines.json"
        default:
            return ""
        }
    }
    
    fileprivate var environmentBaseURL : String {
        switch NetworkClient.environment {
        case .production: return "https://hejbejbrnem.cz/exports/"
        case .develop: return "https://hejbejbrnem.cz/exports/"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
}
