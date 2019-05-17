//
//  SettingsView.swift
//  dopravaBrno
//
//  Created by Thành Đỗ Long on 16/05/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import Foundation
import UIKit

enum SettingsEnum: Int {
    case vehicle
    case stop
    case vendingMachine
    
    static let allCases: [SettingsEnum] = [.stop, .vehicle, .vendingMachine]
}

public final class SettingsView: UIView {
    
    @IBOutlet weak var container: UIView! {
        didSet {
            container.cornerRadius = 10.0
        }
    }
    
    @IBOutlet weak var vehicleSwitchItemView: SwitchItemView! {
        didSet {
            let setState = UserDefaults.standard.bool(forKey: String(SettingsEnum.vehicle.rawValue))
            vehicleSwitchItemView.textLabel.text = "Vehicles"
            vehicleSwitchItemView.imageView.image = UIImage(named: "vehicle")
            vehicleSwitchItemView.switchButton.tag = SettingsEnum.vehicle.rawValue
            vehicleSwitchItemView.switchButton.setOn(setState, animated: false)
        }
    }
    
    @IBOutlet weak var stopSwitchItemView: SwitchItemView! {
        didSet {
            let setState = UserDefaults.standard.bool(forKey: String(SettingsEnum.stop.rawValue))
            stopSwitchItemView.textLabel.text = "Stops"
            stopSwitchItemView.imageView.image = UIImage(named: "stop")
            stopSwitchItemView.switchButton.tag = SettingsEnum.stop.rawValue
            stopSwitchItemView.switchButton.setOn(setState, animated: false)
        }
    }
        
    @IBOutlet weak var vendingMachineSwitchItemView: SwitchItemView! {
        didSet {
            let setState = UserDefaults.standard.bool(forKey: String(SettingsEnum.vendingMachine.rawValue))
            vendingMachineSwitchItemView.textLabel.text = "Vending Machines"
            vendingMachineSwitchItemView.imageView.image = UIImage(named: "vendingMachine")
            vendingMachineSwitchItemView.switchButton.tag = SettingsEnum.vendingMachine.rawValue
            vendingMachineSwitchItemView.switchButton.setOn(setState, animated: false)
        }
    }
}
