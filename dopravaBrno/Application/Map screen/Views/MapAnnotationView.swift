//
//  MapAnnotationView.swift
//  dopravaBrno
//
//  Created by Michal Mrnustik on 10/04/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import Foundation
import MapKit

public class MapAnnotationView: MKMarkerAnnotationView {
    override public var annotation: MKAnnotation? {
        willSet {
            guard let annotation = newValue as? Annotation else { return }
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            markerTintColor = annotation.color
            glyphImage = annotation.image
        }
    }
}
