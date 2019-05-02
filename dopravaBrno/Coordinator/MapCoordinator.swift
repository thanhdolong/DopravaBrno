//
//  HomeCoordinator.swift
//  dopravaBrno
//
//  Created by Thành Đỗ Long on 01/05/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import UIKit

class MapCoordinator: Coordinator {
    var children: [Coordinator] = []
    weak var viewController: MapViewController?
    let transportModule: TransportModule
    let router: Router
    
    public init(router: Router, transportModule: TransportModule) {
        self.router = router
        self.transportModule = transportModule
    }
    
    func present(animated: Bool, onDismissed: (() -> Void)?) {
        viewController = MapViewController.instanceFromStoryboard()
        viewController?.tabBarItem = UITabBarItem(title: "Map", image: nil, selectedImage: nil)
        transportModule.multicastDelegate.addDelegate(viewController!)
    }
}
