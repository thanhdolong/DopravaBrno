//
//  Location.swift
//  dopravaBrno
//
//  Created by Thành Đỗ Long on 22/03/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//



import Foundation
import MapKit

class Location: NSObject {
    let latitude: Double
    let longitude: Double
    
    var location: CLLocation { return CLLocation(latitude: latitude, longitude: longitude) }

    init(latitude: Double,
         longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

