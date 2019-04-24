//
//  Annotation.swift
//  dopravaBrno
//
//  Created by Michal Mrnustik on 10/04/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import Foundation
import MapKit

public enum AnnotationType: String {
    case Default
    case VendingMachine
    case Vehicle
    case Stop
}

public protocol Annotation: MKAnnotation {
    var annotationType: AnnotationType { get }
}
