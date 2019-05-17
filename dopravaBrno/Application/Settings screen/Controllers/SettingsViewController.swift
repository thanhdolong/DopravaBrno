//
//  SettingsViewController.swift
//  dopravaBrno
//
//  Created by Thành Đỗ Long on 16/05/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import UIKit

public protocol SettingsViewControllerDelegate: class {
    func settingsViewControllerDidPressCancel(_ viewController: SettingsViewController)
}

public class SettingsViewController: UIViewController {
    public weak var delegate: SettingsViewControllerDelegate?
    weak var transportModule: TransportModule?
    var settingsView: SettingsView! {
        guard isViewLoaded else { return nil }
        return (view as! SettingsView)
    }
    
    @IBAction func didPressedCancel(_ sender: UIButton) {
        transportModule?.requestData()
        delegate?.settingsViewControllerDidPressCancel(self)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        settingsView.vehicleSwitchItemView.switchButton.addTarget(self, action: #selector(switchButtonTapped(_:)), for: .valueChanged)
        settingsView.stopSwitchItemView.switchButton.addTarget(self,  action: #selector(switchButtonTapped(_:)), for: .valueChanged)
        settingsView.vendingMachineSwitchItemView.switchButton.addTarget(self, action: #selector(switchButtonTapped(_:)), for: .valueChanged)
    }
    
    @objc func switchButtonTapped(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: String(sender.tag))
    }
}

extension SettingsViewController: StoryboardInstantiable {
    public class func instantiate(delegate: SettingsViewControllerDelegate) -> SettingsViewController {
        let viewController = instanceFromStoryboard()
        viewController.delegate = delegate
        return viewController
    }
}
