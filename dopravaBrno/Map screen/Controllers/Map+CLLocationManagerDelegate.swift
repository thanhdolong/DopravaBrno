//
//  MapScreen+CLLocationManagerDelegate.swift
//  challenge
//
//  Created by Thành Đỗ Long on 12/11/2018.
//  Copyright © 2018 Thành Đỗ Long. All rights reserved.
//

import CoreLocation

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined, .authorizedAlways, .authorizedWhenInUse:
            break
        case .restricted, .denied:
            showAlert(withTitle:"Warning", message: "Your geotification is saved but will only be activated once you grant ESN Challenge permission to access the device location.")
            locationManager.requestWhenInUseAuthorization()
        @unknown default:
            fatalError()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Update location
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let error = error as? CLError, error.code == .denied {
            // Location updates are not authorized.
            manager.stopUpdatingLocation()
            print("Access to the location service was denied by the user. Error: \(error)")
            showAlert(withTitle: nil, message: "Access to the location service was denied.")
            return
        }
        
        print("Location Manager failed with the following error: \(error)")
    }
}

