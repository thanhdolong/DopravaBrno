//
//  Location.swift
//  dopravaBrno
//
//  Created by Thành Đỗ Long on 22/03/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import Foundation
import MapKit

final class Location: NSObject {
    let name: String
    let latitude: Double
    let longitude: Double

    var location: CLLocation { return CLLocation(latitude: latitude, longitude: longitude) }

    init(
         name: String,
         latitude: Double,
         longitude: Double) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
}

extension Location: MKAnnotation {
    var coordinate: CLLocationCoordinate2D {
        get {
            return location.coordinate
        }
    }
    
    var title: String? {
        get {
            return self.name
        }
    }
}

