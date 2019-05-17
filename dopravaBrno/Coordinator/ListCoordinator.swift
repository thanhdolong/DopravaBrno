//
//  ListCoordinator.swift
//  dopravaBrno
//
//  Created by Thành Đỗ Long on 01/05/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import UIKit

class ListCoordinator: Coordinator {
    var children: [Coordinator] = []
    let transportModule: TransportModule
    let router: Router
    
    public init(router: Router, transportModule: TransportModule) {
        self.router = router
        self.transportModule = transportModule
    }
    
    func present(animated: Bool, onDismissed: (() -> Void)?) {
        let viewController = ListViewController.instanceFromStoryboard()
        viewController.transportModule = transportModule
        viewController.tabBarItem = UITabBarItem(title: "List", image: UIImage(named: "list"), selectedImage: UIImage(named: "selectedList"))
        router.present(viewController, animated: true)
    }
}
