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
    let transportModule: TransportModule
    let router: Router
    
    public init(router: Router, transportModule: TransportModule) {
        self.router = router
        self.transportModule = transportModule
    }
    
    func present(animated: Bool, onDismissed: (() -> Void)?) {
        let viewController = MapViewController.instantiate(delegate: self)
        viewController.transportModule = transportModule
        viewController.tabBarItem = UITabBarItem(title: "Map", image: UIImage(named: "map"), selectedImage: UIImage(named: "selectedMap"))
        router.present(viewController, animated: true)
    }
}

extension MapCoordinator: MapViewControllerDelegate {
    public func mapViewControllerDidPressSettings(_ viewController: MapViewController) {
        let router = ModalRouter(parentViewController: viewController)
        let coordinator = SettingsCoordinator(router: router, transportModule: transportModule)
        presentChild(coordinator, animated: true)
    }
}
