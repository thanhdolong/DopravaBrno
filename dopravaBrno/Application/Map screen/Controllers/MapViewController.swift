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
        loadStops()
    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationManager.delegate = self
        checkLocationServices()
        startReceivingVehicleUpdates()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stopReceivingVehicleUpdates()
    }

    private func stopReceivingVehicleUpdates() {
        timer.invalidate()
    }

    private func startReceivingVehicleUpdates() {
        timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { timer in
            self.reloadVehicles()
        }
    }

    private func reloadVehicles() {
        VehiclesModule().requestVehicles(completion: addVehiclesToMap)
    }

    private func loadStops() {
        StopsModule().requestStops(completion: addStopsToMap)
    }

    private func loadVendingMachines() {
        VendingMachineModule().requestVendingMachines(completion: addVendingMachinesToMap)
    }

    private func addStopsToMap(stops: [Stop]) {
        removeAnnotationOfType(type: AnnotationType.Stop)
        mapView.map.addAnnotations(stops)
    }

    private func addVehiclesToMap(vehicles: [Vehicle]) {
        removeAnnotationOfType(type: AnnotationType.Vehicle)
        mapView.map.addAnnotations(vehicles)
    }

    private func addVendingMachinesToMap(vendingMachines: [VendingMachine]) {
        removeAnnotationOfType(type: AnnotationType.VendingMachine)
        mapView.map.addAnnotations(vendingMachines)
    }

    private func removeAnnotationOfType(type: AnnotationType) {
        mapView.map.removeAnnotations(mapView.map.annotations.filter { annotation in
            guard let annotation = annotation as? Annotation else {
                return true
            }
            return annotation.annotationType == type
        });
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

