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
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
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
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation as? Annotation else { return }
        self.mapView.detailView.isHidden = false
        self.mapView.detailTitle.text = annotation.title ?? ""
        self.mapView.detailDescription.text = annotation.annotationDescription
        self.mapView.detailImage.image = annotation.image
        self.mapView.detailHeightConstraint.constant = 130
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        self.mapView.detailHeightConstraint.constant = 0
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
}
