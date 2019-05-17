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

public protocol MapViewControllerDelegate: class {
    func mapViewControllerDidPressSettings(_ viewController: MapViewController)
}

public class MapViewController: UIViewController {
    public weak var delegate: MapViewControllerDelegate?
    weak var transportModule: TransportModule?
    
    var locationManager = CLLocationManager()
    var lastLocation: CLLocation?
    var mapView: MapView! {
        guard isViewLoaded else { return nil }
        return (view as! MapView)
    }
    
    @IBAction func zoomToCurrentLocation(_ sender: UIButton) {
        mapView.map.zoomToUserLocation()
    }
    
    @IBAction func closeDetail(_ sender: UIButton) {
        mapView.detailHeightConstraint.constant = 0
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction internal func didPressedSettings(_ sender: AnyObject) {
        delegate?.mapViewControllerDidPressSettings(self)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.mapView?.map.delegate = self
        self.mapView.map.register(MapAnnotationView.self, forAnnotationViewWithReuseIdentifier: "annotationView")
        self.transportModule?.multicastDelegate.addDelegate(self)
        self.transportModule?.requestData()
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationManager.delegate = self
        checkLocationServices()
    }

}

extension MapViewController: StoryboardInstantiable {
    public class func instantiate(delegate: MapViewControllerDelegate) -> MapViewController {
        let viewController = instanceFromStoryboard()
        viewController.delegate = delegate
        return viewController
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
        self.lastLocation = location
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
