//
//  SettingsCoordinator.swift
//  dopravaBrno
//
//  Created by Thành Đỗ Long on 16/05/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import Foundation

class SettingsCoordinator: Coordinator {
    var children: [Coordinator] = []
    let transportModule: TransportModule
    let router: Router
    
    public init(router: Router, transportModule: TransportModule) {
        self.router = router
        self.transportModule = transportModule
    }
    
    func present(animated: Bool, onDismissed: (() -> Void)?) {
        let viewController = SettingsViewController.instantiate(delegate: self)
        viewController.transportModule = transportModule
        viewController.modalPresentationStyle = .custom
        viewController.modalTransitionStyle = .crossDissolve
        router.present(viewController, animated: animated, onDismissed: onDismissed)
    }
}

extension SettingsCoordinator: SettingsViewControllerDelegate {
    func settingsViewControllerDidPressCancel(_ viewController: SettingsViewController) {
        router.dismiss(animated: true)
    }
}
