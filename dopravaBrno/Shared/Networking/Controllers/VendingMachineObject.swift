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
    public var location: Location;
    
    required init(unboxer: Unboxer) throws {
        let latitude: Double = try unboxer.unbox(key: "lat")
        let longitude: Double = try unboxer.unbox(key: "lon")
        self.location = Location(name: "Automat na jizdenky", latitude: latitude, longitude: longitude)
    }


}
