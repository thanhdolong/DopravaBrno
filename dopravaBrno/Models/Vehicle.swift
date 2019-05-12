//
// Created by Michal Mrnustik on 2019-04-19.
// Copyright (c) 2019 Thành Đỗ Long. All rights reserved.
//

import Foundation
import Unbox
import RealmSwift
import MapKit

final class Vehicle: Location {
    let route: String
    let headSign: String
    let direction: Double
    
    init(latitude: Double, longitude: Double, route: String, headSign: String, direction: Double) {
        self.route = route
        self.headSign = headSign
        self.direction = direction
        super.init(latitude: latitude, longitude: longitude)
    }

    init(object: VehicleObject) {
        self.headSign = object.headSign
        self.route = object.route
        self.direction = object.direction
        super.init(latitude: object.latitude, longitude: object.longitude)
    }
}

extension Vehicle: Annotation {
    var heading: Double? {
        return self.direction
    }
    
    var annotationType: AnnotationType {
            return AnnotationType.Vehicle
    }

    var coordinate: CLLocationCoordinate2D {
            return location.coordinate
    }
    
    var annotationDescription : String {
        return "Direction: \(self.headSign)\nLatitude: \(coordinate.latitude)\nLongitude: \(coordinate.longitude)"
    }

    var title: String? {
            return self.route
    }
}

class VehicleObject: Object, Unboxable {
    @objc dynamic var latitude: Double = 0.0
    @objc dynamic var longitude: Double = 0.0
    @objc dynamic var route: String = ""
    @objc dynamic var headSign: String = ""
    @objc dynamic var direction: Double = 0.0

    required convenience init(unboxer: Unboxer) throws {
        self.init()
        self.latitude = try unboxer.unbox(key: "latitude")
        self.longitude = try unboxer.unbox(key: "longitude")
        self.headSign = (try? unboxer.unbox(key: "headsign")) ?? ""
        self.route = try unboxer.unbox(key: "route")
        self.direction = (try? unboxer.unbox(key: "bearing")) ?? 0
    }

}

extension VehicleObject {

    convenience init(latitude: Double, longitude: Double, route: String, headSign: String, direction: Double) {
        self.init()
        self.latitude = latitude
        self.longitude = longitude
        self.route = route
        self.headSign = headSign
        self.direction = direction
    }

    convenience init(object: VehicleObject) {
        self.init()
        self.latitude = object.latitude
        self.longitude = object.longitude
        self.headSign = object.headSign
        self.route = object.route
        self.direction = object.direction
    }
}
