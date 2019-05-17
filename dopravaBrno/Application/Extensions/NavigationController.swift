//
//  NavigationController.swift
//  dopravaBrno
//
//  Created by Thành Đỗ Long on 17/05/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import Foundation
import UIKit

class NavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.tintColor = .black
        navigationBar.barTintColor = .white
        navigationBar.shadowImage = UIImage()
    }
}
