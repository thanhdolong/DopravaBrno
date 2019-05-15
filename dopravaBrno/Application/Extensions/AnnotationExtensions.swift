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
            return nil
        case .VendingMachine:
            return UIImage(named: "vendingMachine")
        case .Vehicle:
            return UIImage(named: "vehicle")
        case .Stop:
            return UIImage(named: "stop")
        }
    }
    
    var color: UIColor {
        switch self.annotationType {
        case .VendingMachine:
            return UIColor(hexString: "#0A59F8")
        case .Stop:
            return UIColor(hexString: "#FFBD2A")
        case .Vehicle:
            return UIColor(hexString: "#FF0033")
        default:
            return UIColor.gray
        }
    }
}
