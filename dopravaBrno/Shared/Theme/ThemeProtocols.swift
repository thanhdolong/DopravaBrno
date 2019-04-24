//
//  Theme.swift
//  dopravaBrno
//
//  Created by Thành Đỗ Long on 06/04/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//  Theme class for creating standard UI elements for the app
//

import UIKit

protocol ThemeStrategy {
    var fonts: FontScheme {get}
    var colours: ColourScheme {get}
    
    var barStyle: UIBarStyle { get }
    var keyboardAppearance: UIKeyboardAppearance { get }
}

protocol ColourScheme {
    // Colors
    var mainColor: UIColor { get }
    var secondaryColor: UIColor { get }
    
    // Backgrounds
    var backgroundColor: UIColor { get }
    
    // Primary text color: the color displayed most frequently across your app’s screens and components.
    // Primary text color variant: a light or dark variation of the primary color.
    // Secondary text color: Provides ways to accent and distinguish your product. Floating action buttons use the secondary color.
    var primaryTextColor: UIColor { get }
    var primaryTextColorVariant: UIColor { get }
    var secondaryTextColor: UIColor { get }
}

protocol FontScheme {
    var titleFont: UIFont {get}
    var subtitleFont: UIFont {get}
    var bodyFont: UIFont {get}
    
    var tapBarFont: UIFont {get}
    var navigationBarFont: UIFont {get}
}
