//
//  MapView.swift
//  dopravaBrno
//
//  Created by Thành Đỗ Long on 20/03/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import Foundation
import MapKit

public final class MapView: UIView {
    
    @IBOutlet weak var mapView: MKMapView! {
        didSet {
            mapView.showsUserLocation = true
            mapView.mapType = .standard
            mapView.userTrackingMode = .follow
        }
    }
    
    
}
