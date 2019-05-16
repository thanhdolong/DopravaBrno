//
//  DefaultTheme.swift
//  dopravaBrno
//
//  Created by Thành Đỗ Long on 07/04/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import Foundation
import UIKit

struct DefaultTheme: ThemeStrategy {
    var fonts: FontScheme
    var colours: ColourScheme
    
    var barStyle: UIBarStyle = .default
    
    var keyboardAppearance: UIKeyboardAppearance = .default
    
    init() {
        self.colours = DefaultColours()
        self.fonts = DefaultFonts()
    }
    
    init(colours: ColourScheme, fonts: FontScheme) {
        self.colours = colours
        self.fonts = fonts
    }
}

struct DefaultColours: ColourScheme {
    let mainColor: UIColor = UIColor(hexString: "#FF0033")
    let secondaryColor: UIColor = .orange
    
    let backgroundColor: UIColor = .white
    
    let primaryTextColor: UIColor = .black
    let primaryTextColorVariant: UIColor = .darkGray
    let secondaryTextColor: UIColor = .orange
}

struct DefaultFonts: FontScheme {
    let titleFont: UIFont = UIFont(name: "Montserrat-SemiBold", size: 17)!
    let subtitleFont: UIFont = UIFont(name: "Montserrat-Light", size: 15)!
    let bodyFont: UIFont = UIFont(name: "Montserrat-Regular", size: 15)!
    
    let tapBarFont: UIFont = UIFont(name: "Montserrat-Regular", size: 10)!
    let navigationBarFont: UIFont = UIFont(name: "Montserrat-Regular", size: 29)!
}
