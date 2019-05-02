//
//  Router.swift
//  dopravaBrno
//
//  Created by Thành Đỗ Long on 01/05/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import UIKit

public protocol Router: class {
    func present(_ viewController: UIViewController, animated: Bool)
    func present(_ viewController: UIViewController,
                 animated: Bool,
                 onDismissed: (() -> Void)?)
    func dismiss(animated: Bool)
}

extension Router {
    public func present(_ viewController: UIViewController,
                        animated: Bool) {
        present(viewController, animated: animated, onDismissed: nil)
    }
}
