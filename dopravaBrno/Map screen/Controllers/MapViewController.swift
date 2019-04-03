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
import RealmSwift

class MapViewController: UIViewController {
    var locationManager = CLLocationManager()
    var mapView: MapView! {
        guard isViewLoaded else { return nil }
        return (view as! MapView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        checkLocationServices()
        loadVendingMachines()
        addVendingMachinesToMap()
    }

    private func loadVendingMachines() {
        VendingMachinesAPI().getVendingMachines { (result) in
            do {
                let vendingMachinesObjects = try result.unwrap()
                self.saveVendingMachines(vendingMachinesObjects)
                self.addVendingMachinesToMap()
            } catch {
                self.showAlert(withTitle: nil, message: "An error occurred when loading vending machines")
            }
        }
    }
    
    private func saveVendingMachines(_ vendingMachines: [Object]) {
        do {
            try Database().delete(type: VendingMachineObject.self)
            try Database().insertObjects(vendingMachines, update: false)
        } catch (let error) {
            print(error)
        }
    }
    
    private func addVendingMachinesToMap() {
        mapView.map.removeAnnotations(mapView.map.annotations.filter({$0.title == "Vending Machine"}))
        
        let vendingMachines = Database().fetch(with: VendingMachine.all)
        mapView.map.addAnnotations(vendingMachines)
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

