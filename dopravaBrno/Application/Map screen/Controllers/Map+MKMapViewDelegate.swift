//
//  Map+MKMapViewDelegate.swift
//  dopravaBrno
//
//  Created by Michal Mrnustik on 10/04/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import Foundation
import MapKit

extension MapViewController: MKMapViewDelegate {
    public func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? Annotation {
            var view = mapView.dequeueReusableAnnotationView(withIdentifier: "annotationView")
            if view == nil {
                view = MapAnnotationView(annotation: annotation, reuseIdentifier: "annotationView")
            } else {
                view?.annotation = annotation
            }
            return view
        } else if let cluster = annotation as? MKClusterAnnotation {
            guard let annotation = cluster.memberAnnotations.first as? Annotation else { return nil }
            var view = mapView.dequeueReusableAnnotationView(withIdentifier: "annotationView")
            if view == nil {
                view = MapAnnotationView(annotation: annotation, reuseIdentifier: "annotationView")
            } else {
                view?.annotation = annotation
            }
            return view
        }
        return nil
    }
    
    public func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation as? Annotation else { return }
        
        if let location = lastLocation {
            let distance = CLLocation(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)
            self.mapView.distanceLabel.text = "\(Int(distance.distance(from: location))) m"
        } else {
            self.mapView.distanceLabel.text = ""
        }
        
        if view.annotation is VendingMachine {
            self.mapView.detailTitle.text = "Ticket Machine"
        }
        
        if let vehicle = view.annotation as? Vehicle {
            self.mapView.detailTitle.text = "\(vehicle.lineName)"
            if let finalDestination = vehicle.finalStop.name {
                self.mapView.detailTitle.text?.append(contentsOf: " • \(finalDestination)")
            }
            
            self.mapView.distanceLabel.text?.append(contentsOf: " | Delay: \(vehicle.delay) min")
        } 
        
        self.mapView.detailImage.image = annotation.image?.withRenderingMode(.alwaysTemplate)
        self.mapView.detailImage.tintColor = annotation.color
        
        self.mapView.detailHeightConstraint.constant = 120
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    public func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        self.mapView.detailHeightConstraint.constant = 0
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
}
