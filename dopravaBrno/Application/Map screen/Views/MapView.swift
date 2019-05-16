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
    
    @IBOutlet weak var map: MKMapView! {
        didSet {
            map.showsUserLocation = true
            map.mapType = .standard
            map.userTrackingMode = .follow
        }
    }
    
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var detailView: UIView! {
        didSet {
            detailView.round(corners: [.topLeft, .topRight], radius: 10)
        }
    }
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailHeightConstraint: NSLayoutConstraint! {
        didSet {
            detailHeightConstraint.constant = 0
        }
    }
    
    @IBOutlet weak var settingsButton: UIButton! {
        didSet {
           settingsButton.tintColor = DefaultTheme().colours.mainColor
        }
    }
    
    @IBOutlet weak var zoomUserLocationButton: UIButton! {
        didSet {
            zoomUserLocationButton.tintColor = DefaultTheme().colours.mainColor
        }
    }
    
    @IBOutlet weak var container: UIView! {
        didSet {
            container.cornerRadius = 10.0
        }
    }
}
