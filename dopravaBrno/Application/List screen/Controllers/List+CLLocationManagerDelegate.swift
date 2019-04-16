//
//  List+CLLocationManagerDelegate.swift
//  dopravaBrno
//
//  Created by Michal Mrnustik on 16/04/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import CoreLocation

extension ListViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = manager.location {
            self.showRecalculatedDistance(location: location)
        }
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
