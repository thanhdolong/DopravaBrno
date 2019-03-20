//
//  Int+HTTPStatusCode.swift
//  challenge
//
//  Created by Thành Đỗ Long on 12/11/2018.
//  Copyright © 2018 Thành Đỗ Long. All rights reserved.
//

import Foundation

extension Int {
    public var isSuccessHTTPCode: Bool {
        return 200 <= self && self < 300
    }
}

