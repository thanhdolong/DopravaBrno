//
//  Datasource.swift
//  dopravaBrno
//
//  Created by Thành Đỗ Long on 25/04/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import Foundation
import MapKit

protocol TransportDelegate: class {
    func didChange(vendingMachines: [VendingMachine])
    func didChange(vehicles: [Vehicle])
    func didChange(stops: [Stop])
    func didChange(location: CLLocation?)
}

class TransportModule: NSObject {
    let multicastDelegate = MulticastDelegate<TransportDelegate>()
    var locationManager = CLLocationManager()
    
    override init() {
        super.init()
        startReceivingVehicleUpdates()
        if UserDefaults.standard.bool(forKey: "firstSetup") == false {
            for item in SettingsEnum.allCases {
                UserDefaults.standard.set(true, forKey: String(item.rawValue))
            }
            UserDefaults.standard.set(true, forKey: "firstSetup")
        }
    }
        
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
    func requestData() {
        enableLocationServices()
        loadVehicles()
        loadStops()
        loadVendingMachines()
    }
    
    func requestData(_ refreshControl: UIRefreshControl) {
        enableLocationServices()
        loadVehicles()
        loadStops()
        loadVendingMachines()
        refreshControl.endRefreshing()
    }
    
    func enableLocationServices() {
        locationManager.delegate = self
    }
    
    func stopReceivingVehicleUpdates() {
        timer.invalidate()
    }
    
    private func startReceivingVehicleUpdates() {
        self.loadVehicles()
        timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { _ in
            self.loadVehicles()
        }
    }
    
    private func loadVehicles() {
        switch UserDefaults.standard.bool(forKey: String(SettingsEnum.vehicle.rawValue)) {
        case true:
            VehiclesModule().requestVehicles { (vehicles) in
                self.vehicles = vehicles
            }
        case false:
            self.vehicles = []
        }
    }
    
    private func loadStops() {
        switch UserDefaults.standard.bool(forKey: String(SettingsEnum.stop.rawValue)) {
        case true:
            StopsModule().requestStops { (stops) in
                self.stops = stops
            }
        case false:
            self.stops = []
        }
    }
    
    private func loadVendingMachines() {
        switch UserDefaults.standard.bool(forKey: String(SettingsEnum.vendingMachine.rawValue)) {
        case true:
            VendingMachineModule().requestVendingMachines { (vendingMachines) in
                self.vendingMachines = vendingMachines
            }
        case false:
            self.vendingMachines = []
        }
    }
}

extension TransportModule: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.latestLocation = locations.last
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        case .restricted, .denied, .notDetermined:
            locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let error = error as? CLError, error.code == .denied {
            // Location updates are not authorized.
            manager.stopUpdatingLocation()
            print("Access to the location service was denied by the user. Error: \(error)")
            return
        }
        
        print("Location Manager failed with the following error: \(error)")
    }
}
