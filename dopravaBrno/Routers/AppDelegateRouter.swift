//
//  AppDelegateRouter.swift
//  dopravaBrno
//
//  Created by Thành Đỗ Long on 01/05/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import UIKit

final class AppDelegateRouter: NSObject, UITabBarControllerDelegate, Router {
    private let tabController = UITabBarController()
    private var viewControllers: [UIViewController] = []
    public let window: UIWindow
    
    public init(window: UIWindow) {
        self.window = window
        
        super.init()
        setAppearance(tabController)
        tabController.delegate = self
        window.rootViewController = tabController
        window.makeKeyAndVisible()
    }
    
    public func present(_ viewController: UIViewController, animated: Bool, onDismissed: (() -> Void)?) {
        viewControllers.append(viewController)
        tabController.viewControllers = viewControllers
    }
    
    public func dismiss(animated: Bool) {
        // do anything
    }
    
    func setAppearance(_ tabController: UITabBarController) {
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: DefaultTheme().fonts.tapBarFont], for: .normal)
        
        tabController.tabBar.layer.borderWidth = 0
        tabController.tabBar.clipsToBounds = true
        tabController.tabBar.tintColor = DefaultTheme().colours.mainColor
        tabController.tabBar.layer.backgroundColor = UIColor(red: 255, green: 255, blue: 255).withAlphaComponent(0).cgColor
    }
}
