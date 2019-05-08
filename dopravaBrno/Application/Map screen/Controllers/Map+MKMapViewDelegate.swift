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
            let identifier = "marker"
            var view:AnnotationView
            view = AnnotationView(annotation: annotation, reuseIdentifier: identifier)
            return view
        } else if let cluster = annotation as? MKClusterAnnotation {
            guard let annotation = cluster.memberAnnotations.first as? Annotation else { return nil }
            let identifier = "marker"
            var view:AnnotationView
            view = AnnotationView(annotation: annotation, reuseIdentifier: identifier)
            return view
        }
        return nil
    }
    
    
}
