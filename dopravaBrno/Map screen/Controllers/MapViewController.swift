//
//  MapViewController.swift
//  dopravaBrno
//
//  Created by Thành Đỗ Long on 20/03/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    var locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("hi")
        checkLocationServices()
        VendingMachinesAPI().getVendingMachines { (result) in
            do {
                let vendingMachines = try result.unwrap()
                for machine in vendingMachines {
                    print(machine.latitude)
                    print(machine.longitude)
                }
            } catch {
                self.showAlert(withTitle: nil, message: "error")
            }
        }
    }
}

extension MapViewController {
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            enableLocationServices()
        } else {
            showAlert(withTitle: nil, message: "Location services is not available on this device.")
        }
    }
    
    func enableLocationServices() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined, .restricted, .denied:
            print("Not determined status. Show request for using location.")
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
        }
    }
}

