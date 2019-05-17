//
//  ModalRouter.swift
//  dopravaBrno
//
//  Created by Thành Đỗ Long on 16/05/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import Foundation
import UIKit

public class ModalRouter: NSObject {
    // MARK: - Instance Properties
    public unowned let parentViewController: UIViewController
    
    private var onDismissForViewController:
        [UIViewController: (() -> Void)] = [:]
    
    // MARK: - Object Lifecycle
    public init(parentViewController: UIViewController) {
        self.parentViewController = parentViewController
    }
}

// MARK: - Router
extension ModalRouter: Router {
    
    public func present(_ viewController: UIViewController,
                        animated: Bool,
                        onDismissed: (() -> Void)?) {
        onDismissForViewController[viewController] = onDismissed
        presentModally(viewController, animated: animated)
    }
    
    private func presentModally(
        _ viewController: UIViewController,
        animated: Bool) {
        parentViewController.present(viewController,
                                     animated: animated,
                                     completion: nil)
    }
    
    public func dismiss(animated: Bool) {
        parentViewController.dismiss(animated: animated,
                                     completion: nil)
    }
    
    private func performOnDismissed(for viewController: UIViewController) {
        guard let onDismiss = onDismissForViewController[viewController] else { return }
        onDismiss()
        onDismissForViewController[viewController] = nil
    }
}
