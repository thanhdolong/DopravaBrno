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

class MapViewController: UIViewController, StoryboardInstantiable {
    var locationManager = CLLocationManager()
    var mapView: MapView! {
        guard isViewLoaded else { return nil }
        return (view as! MapView)
    }
    
    @IBAction func zoomToCurrentLocation(_ sender: UIButton) {
        mapView.map.zoomToUserLocation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.mapView?.map.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationManager.delegate = self
        checkLocationServices()
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
            locationManager.delegate = self
        }
    }
    
    private func removeAnnotationOfType(type: AnnotationType) {
        mapView.map.removeAnnotations(mapView.map.annotations.filter { annotation in
            guard let annotation = annotation as? Annotation else {
                return true
            }
            return annotation.annotationType == type
        })
    }
}

extension MapViewController: TransportDelegate {
    func didChange(stops: [Stop]) {
        removeAnnotationOfType(type: AnnotationType.Stop)
        mapView.map.addAnnotations(stops)
    }
    
    func didChange(location: CLLocation?) {
        // do anything
    }
    
    func didChange(vehicles: [Vehicle]) {
        removeAnnotationOfType(type: AnnotationType.Vehicle)
        mapView.map.addAnnotations(vehicles)
    }
    
    func didChange(vendingMachines: [VendingMachine]) {
        removeAnnotationOfType(type: AnnotationType.VendingMachine)
        mapView.map.addAnnotations(vendingMachines)
    }
    
}
