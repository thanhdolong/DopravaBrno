//
//  VendingMachine.swift
//  dopravaBrno
//
//  Created by Thành Đỗ Long on 01/04/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import Foundation
import MapKit
import Unbox

final class VendingMachine: NSObject {
    let latitude: Double
    let longitude: Double
    var location: CLLocation { return CLLocation(latitude: latitude, longitude: longitude) }
    
    init(latitude: Double,
         longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    init(object: VendingMachineObject) {
        self.latitude = object.latitude
        self.longitude = object.longitude
    }
}

extension VendingMachine: MKAnnotation {
    var coordinate: CLLocationCoordinate2D {
        get {
            return location.coordinate
        }
    }
    
    var title: String? {
        get {
            return "Vending Machine"
        }
    }
    
}
