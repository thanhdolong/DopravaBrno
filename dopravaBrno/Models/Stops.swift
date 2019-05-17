//
// Created by Michal Mrnustik on 2019-04-20.
// Copyright (c) 2019 Thành Đỗ Long. All rights reserved.
//

import Foundation
import Unbox
import MapKit
import RealmSwift

final class Stop: Location {
    let stopID: Int
    let name: String
    let transportZone: Int

    init(stopID: Int, latitude: Double, longitude: Double, name: String, zone: Int) {
        self.stopID = stopID
        self.name = name
        self.transportZone = zone
        super.init(latitude: latitude, longitude: longitude)
    }

    init(object: StopObject) {
        self.stopID = object.stopID
        self.name = object.name
        self.transportZone = object.transportZone
        super.init(latitude: object.latitude, longitude: object.longitude)
    }
}

extension Stop: Annotation {
    var annotationType: AnnotationType {
        return AnnotationType.Stop
    }

    var coordinate: CLLocationCoordinate2D {
        return location.coordinate
    }

    var title: String? {
        return self.name
    }
    
    var annotationDescription: String {
        return "Latitude: \(coordinate.latitude) \nLongitude: \(coordinate.longitude)"
    }
    
    var heading: Double? {
        return nil
    }
}

class StopObject: Object, Unboxable {
    @objc dynamic var stopID: Int = 0
    @objc dynamic var latitude: Double = 0.0
    @objc dynamic var longitude: Double = 0.0
    @objc dynamic var name: String = ""
    @objc dynamic var transportZone: Int = 0
    
    override static func primaryKey() -> String? {
        return "stopID"
    }

    required convenience init(unboxer: Unboxer) throws {
        self.init()
        self.stopID = try unboxer.unbox(key: "StopID")
        self.latitude = try unboxer.unbox(key: "Latitude")
        self.longitude = try unboxer.unbox(key: "Longitude")
        self.name = try unboxer.unbox(key: "Name")
        self.transportZone = try unboxer.unbox(key: "Zone")
    }

}

extension StopObject {
    convenience init(stopID: Int, latitude: Double, longitude: Double, name: String, zone: Int) {
        self.init()
        self.stopID = stopID
        self.latitude = latitude
        self.longitude = longitude
        self.name = name
        self.transportZone = zone
    }

    convenience init(object: StopObject) {
        self.init()
        self.stopID = object.stopID
        self.latitude = object.latitude
        self.longitude = object.longitude
        self.name = object.name
        self.transportZone = object.transportZone
    }
}
