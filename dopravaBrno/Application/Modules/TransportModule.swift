//
//  Datasource.swift
//  dopravaBrno
//
//  Created by Thành Đỗ Long on 25/04/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import Foundation
import MapKit

protocol TransportDelegate {
    func didChange(vendingMachines: [VendingMachine])
    func didChange(vehicles: [Vehicle])
    func didChange(stops: [Stop])
    func didChange(location: CLLocation?)
}

class TransportModule: NSObject {
    let multicastDelegate = MulticastDelegate<TransportDelegate>()
    var locationManager = CLLocationManager()
    
    var timer = Timer()
    var vendingMachines: [VendingMachine] = [] {
        didSet {
            multicastDelegate.invokeDelegates { [weak self] vm in
                if let vendingMachines = self?.vendingMachines {
                    vm.didChange(vendingMachines: vendingMachines)
                }
            }
        }
    }

    var vehicles: [Vehicle] = [] {
        didSet {
            multicastDelegate.invokeDelegates { [weak self] vm in
                if let vehicles = self?.vehicles {
                    vm.didChange(vehicles: vehicles)
                }
            }
        }
    }
    
    var stops: [Stop] = [] {
        didSet {
            multicastDelegate.invokeDelegates { [weak self] vm in
                if let stops = self?.stops {
                    vm.didChange(stops: stops)
                }
            }
        }
    }
    
    var latestLocation: CLLocation? {
        didSet {
            multicastDelegate.invokeDelegates { [weak self] vm in
                if let latestLoation = self?.latestLocation {
                    vm.didChange(location: latestLoation)
                }
            }
        }
    }
}

extension TransportModule {
    func start() {
        enableLocationServices()
        
        startReceivingVehicleUpdates()
        loadStops()
        loadVendingMachines()
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
    
    func stopReceivingVehicleUpdates() {
        timer.invalidate()
    }
    
    private func startReceivingVehicleUpdates() {
        self.reloadVehicles()
        timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { _ in
            self.reloadVehicles()
        }
    }
    
    private func reloadVehicles() {
        VehiclesModule().requestVehicles { (vehicles) in
            self.vehicles = vehicles
        }
    }
    
    private func loadStops() {
        StopsModule().requestStops { (stops) in
            self.stops = stops
        }
    }
    
    private func loadVendingMachines() {
        VendingMachineModule().requestVendingMachines { (vendingMachines) in
            self.vendingMachines = vendingMachines
        }
    }
}

extension TransportModule: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.latestLocation = locations.last
    }
}
