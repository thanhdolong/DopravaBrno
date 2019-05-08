//
//  AnnotationExtensions.swift
//  dopravaBrno
//
//  Created by Michal Mrnustik on 16/04/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import Foundation
import UIKit

extension Annotation {
    var image: UIImage? {
        switch self.annotationType {
        case .Default:
            return UIImage(named: "Vehicle")
        case .VendingMachine:
            return UIImage(named: "VendingMachine")
        case .Vehicle:
            return UIImage(named: "Vehicle")
        case .Stop:
            return UIImage(named: "Stop")
        }
    }
    
    var color: UIColor {
        switch self.annotationType {
        case .VendingMachine:
            return UIColor.blue
        case .Stop:
            return UIColor.brown
        default:
            return UIColor.red
        }
    }
}
