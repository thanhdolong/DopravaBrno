//
//  VendingMachine.swift
//  dopravaBrno
//
//  Created by Thành Đỗ Long on 01/04/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import Foundation
import Unbox
import RealmSwift
import MapKit

// MARK: Vending machine
final class VendingMachine: Location {
    
    init(object: VendingMachineObject) {
        super.init(latitude: object.latitude, longitude: object.longitude)
    }
}

extension VendingMachine: Annotation {
    var annotationType: AnnotationType {
            return AnnotationType.VendingMachine
    }
    
    var coordinate: CLLocationCoordinate2D {
            return location.coordinate
    }
    
    var title: String? {
            return "Ticket machine"
    }
    
    var annotationDescription: String {
        return "Latitude: \(coordinate.latitude) \nLongitude: \(coordinate.longitude)"
    }
    
    var heading: Double? {
        return nil
    }
}

// MARK: Vending Machine Object
class VendingMachineObject: Object, Unboxable {
    @objc dynamic var latitude: Double = 0.0
    @objc dynamic var longitude: Double = 0.0
    
    required convenience init(unboxer: Unboxer) throws {
        self.init()
        
        self.latitude = try unboxer.unbox(key: "lat")
        self.longitude = try unboxer.unbox(key: "lon")
        //        self.location = Location(name: "Automat na jizdenky", latitude: latitude, longitude: longitude)
    }
}

extension VendingMachineObject {
    convenience init(latitude: Double,
                     longitude: Double) {
        self.init()
        
        self.latitude = latitude
        self.longitude = longitude
    }
    
    convenience init(vendingMachine: VendingMachine) {
        self.init()
        
        self.latitude = vendingMachine.latitude
        self.longitude = vendingMachine.longitude
    }
}
