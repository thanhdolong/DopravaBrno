//
// Created by Michal Mrnustik on 2019-04-19.
// Copyright (c) 2019 Thành Đỗ Long. All rights reserved.
//

import Foundation
import MapKit
import Unbox
import RealmSwift

class Vehicle: NSObject {
    let latitude: Double
    let longitude: Double
    let route: String
    let headSign: String
    var location: CLLocation {
        return CLLocation(latitude: latitude, longitude: longitude)
    }

    init(latitude: Double, longitude: Double, route: String, headSign: String) {
        self.latitude = latitude
        self.longitude = longitude
        self.route = route
        self.headSign = headSign
    }

    init(object: VehicleObject) {
        self.latitude = object.latitude
        self.longitude = object.longitude
        self.headSign = object.headSign
        self.route = object.route
    }
}

extension Vehicle: Annotation {
    var annotationType: AnnotationType {
        get {
            return AnnotationType.Vehicle
        }
    }

    var coordinate: CLLocationCoordinate2D {
        get {
            return location.coordinate
        }
    }

    var title: String? {
        get {
            return self.route + " - " + self.headSign
        }
    }

}

class VehicleObject: Object, Unboxable {
    @objc dynamic var latitude: Double = 0.0
    @objc dynamic var longitude: Double = 0.0
    @objc dynamic var route: String = ""
    @objc dynamic var headSign: String = ""

    required convenience init(unboxer: Unboxer) throws {
        self.init()
        self.latitude = try unboxer.unbox(key: "latitude")
        self.longitude = try unboxer.unbox(key: "longitude")
        self.headSign = try unboxer.unbox(key: "headsign")
        self.route = try unboxer.unbox(key: "route")
    }

}

extension VehicleObject {


    convenience init(latitude: Double, longitude: Double, route: String, headSign: String) {
        self.init()

        self.latitude = latitude
        self.longitude = longitude
        self.route = route
        self.headSign = headSign
    }

    convenience init(object: VehicleObject) {
        self.init()
        self.latitude = object.latitude
        self.longitude = object.longitude
        self.headSign = object.headSign
        self.route = object.route
    }
}
