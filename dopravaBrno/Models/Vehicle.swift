//
// Created by Michal Mrnustik on 2019-04-19.
// Copyright (c) 2019 Thành Đỗ Long. All rights reserved.
//

import Foundation
import Unbox
import RealmSwift
import MapKit

final class Vehicle: Location {
    var lineName: String
    let lastStop: Int
    var finalStop: (id: Int,name: String?)
    let direction: Double
    let delay: Int
    
    init(latitude: Double, longitude: Double, route: String, lastStop: Int, finalStop: Int, direction: Double, delay: Int) {
        self.lineName = route
        self.lastStop = lastStop
        self.finalStop = (finalStop,nil)
        self.direction = direction
        self.delay = delay
        super.init(latitude: latitude, longitude: longitude)
    }

    init(object: VehicleObject) {
        self.lineName = object.lineName
        self.finalStop = (object.finalStop,nil)
        self.lastStop = object.lastStop
        self.direction = object.direction
        self.delay = object.delay
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
    
    var annotationDescription: String {
        return "Direction: \(self.finalStop)\nLatitude: \(coordinate.latitude)\nLongitude: \(coordinate.longitude)"
    }

    var title: String? {
            return "\(lineName)"
    }
}

class VehicleObject: Object, Unboxable {
    @objc dynamic var latitude: Double = 0.0
    @objc dynamic var longitude: Double = 0.0
    @objc dynamic var lineName: String = ""
    @objc dynamic var lastStop: Int = 0
    @objc dynamic var finalStop: Int = 0
    @objc dynamic var direction: Double = 0.0
    @objc dynamic var delay: Int = 0

    required convenience init(unboxer: Unboxer) throws {
        self.init()
        self.latitude = try unboxer.unbox(key: "Lat")
        self.longitude = try unboxer.unbox(key: "Lng")
        self.lastStop = try unboxer.unbox(key: "LastStopID")
        self.finalStop = try unboxer.unbox(key: "FinalStopID")
        self.lineName = try unboxer.unbox(key: "LineName")
        self.direction = try unboxer.unbox(key: "Bearing")
        self.delay = try unboxer.unbox(key: "Delay")
    }

}

extension VehicleObject {

    convenience init(latitude: Double, longitude: Double, route: String, lastStop: Int, finalStop: Int, direction: Double, delay: Int) {
        self.init()
        self.latitude = latitude
        self.longitude = longitude
        self.lineName = route
        self.lastStop = lastStop
        self.finalStop = finalStop
        self.direction = direction
        self.delay = delay
    }

    convenience init(object: VehicleObject) {
        self.init()
        self.latitude = object.latitude
        self.longitude = object.longitude
        self.lastStop = object.lastStop
        self.finalStop = object.finalStop
        self.lineName = object.lineName
        self.direction = object.direction
        self.delay = object.delay
    }
}
