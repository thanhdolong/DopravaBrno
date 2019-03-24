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
