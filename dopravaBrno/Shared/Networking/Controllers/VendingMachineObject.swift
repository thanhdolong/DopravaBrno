//
//  VendingMachineObject.swift
//  dopravaBrno
//
//  Created by Michal Mrnustik on 24/03/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import Foundation
import Unbox

class VendingMachineObject: Unboxable {
    public var latitude: Double;
    public var longitude: Double;
    
    required init(unboxer: Unboxer) throws {
        self.latitude = try unboxer.unbox(key: "lat")
        self.longitude = try unboxer.unbox(key: "lon")
    }
}
