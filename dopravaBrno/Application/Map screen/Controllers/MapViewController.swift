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
    var timer = Timer()
    var mapView: MapView! {
        guard isViewLoaded else { return nil }
        return (view as! MapView)
    }
    
    static func storyboardInit() -> MapViewController {
        let storyboard = UIStoryboard(name: "Map", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController()! as! MapViewController
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.mapView?.map.delegate = self
        loadVendingMachines()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        locationManager.delegate = self
        checkLocationServices()
        startReceivingVehicleUpdates()
    }

    private func startReceivingVehicleUpdates() {
        timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { timer in
            self.reloadVehicles()
        }
    }

    private func reloadVehicles() {
        SotorisAPI().getVehicles { (result) in
            do {
                let vehicles = try result.unwrap()
                self.saveVehicles(vehicles)
                self.addVehiclesToMap()
            } catch {
                self.showAlert(withTitle: nil, message: "An error occurred when loading vehicles")
            }
        }
    }

    private func saveVehicles(_ vehicles: [VehicleObject]) {
        do {
            try Database().delete(type: VehicleObject.self)
            try Database().insertObjects(vehicles, update: false)
        } catch (let error) {
            print(error)
        }
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

    private func addVehiclesToMap() {
        mapView.map.removeAnnotations(mapView.map.annotations.filter { annotation in
            guard let annotation = annotation as? Annotation else {
                return true
            }
            return annotation.annotationType == AnnotationType.Vehicle
        });
        let vehicles = Database().fetch(with: Vehicle.all)
        mapView.map.addAnnotations(vehicles)
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

