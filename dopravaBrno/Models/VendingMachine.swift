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
import RealmSwift

// MARK: Vending machine
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

extension VendingMachine: Annotation {
    var annotationType: AnnotationType {
        get {
            return AnnotationType.VendingMachine
        }
    }
    
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
