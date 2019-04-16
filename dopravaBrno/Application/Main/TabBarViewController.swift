//
//  TabBarViewController.swift
//  dopravaBrno
//
//  Created by Thành Đỗ Long on 06/04/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: 1st VC
        let firstViewController = ListViewController.storyboardInit()
        firstViewController.tabBarItem = UITabBarItem(title: "List", image: nil, selectedImage: nil)

        // Mark: 2nd VC
        let secondViewController = MapViewController.storyboardInit()
        secondViewController.tabBarItem = UITabBarItem(title: "Map", image: nil, selectedImage: nil)
        
        // Mark: 3rd VC
        let thirdViewController = UIViewController()
        thirdViewController.view.backgroundColor = .blue
        thirdViewController.navigationItem.title = "Settings"
        let thirdNavigationController = UINavigationController(rootViewController: thirdViewController)
        thirdNavigationController.tabBarItem = UITabBarItem(title: "Settings", image: nil, selectedImage: nil)

        self.viewControllers = [firstViewController, secondViewController, thirdNavigationController]
        self.selectedViewController = secondViewController

    }
}
