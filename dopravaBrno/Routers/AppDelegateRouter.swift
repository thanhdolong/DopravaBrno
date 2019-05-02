//
//  AppDelegateRouter.swift
//  dopravaBrno
//
//  Created by Thành Đỗ Long on 01/05/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import UIKit

public class AppDelegateRouter: Router {
    public let window: UIWindow
    
    public init(window: UIWindow) {
        self.window = window
    }
    
    public func present(_ viewController: UIViewController, animated: Bool, onDismissed: (() -> Void)?) {
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
    
    public func dismiss(animated: Bool) {
        // do anything
    }
}
