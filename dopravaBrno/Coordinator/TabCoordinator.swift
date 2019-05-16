//
//  TabCoordinator.swift
//  dopravaBrno
//
//  Created by Thành Đỗ Long on 01/05/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import UIKit

final class TabCoordinator: NSObject, UITabBarControllerDelegate, Coordinator {
    var children: [Coordinator] = []
    var router: Router
    let transportModule: TransportModule
    
    public init(router: Router, transportModule: TransportModule) {
        self.router = router
        self.transportModule = transportModule
    }
    
    func present(animated: Bool, onDismissed: (() -> Void)?) {
        let tabController = UITabBarController()
        setAppearance(tabController)
        
        let listCoordinator = ListCoordinator(router: router, transportModule: transportModule)
        listCoordinator.present(animated: true, onDismissed: nil)
        
        let mapCoordinator = MapCoordinator(router: router, transportModule: transportModule)
        mapCoordinator.present(animated: true, onDismissed: nil)
        
        tabController.setViewControllers([listCoordinator.viewController!, mapCoordinator.viewController!], animated: true)
        tabController.selectedViewController = mapCoordinator.viewController
        tabController.delegate = self
        
        router.present(tabController, animated: false)
    }
    
    func setAppearance(_ tabController: UITabBarController) {
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: DefaultTheme().fonts.tapBarFont], for: .normal)

        tabController.tabBar.layer.borderWidth = 0
        tabController.tabBar.clipsToBounds = true
        tabController.tabBar.tintColor = DefaultTheme().colours.mainColor
        tabController.tabBar.layer.backgroundColor = UIColor(red: 255, green: 255, blue: 255).withAlphaComponent(0).cgColor
    }
}
