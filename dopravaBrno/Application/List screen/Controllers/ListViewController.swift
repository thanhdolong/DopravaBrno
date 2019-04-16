//
//  ListViewController.swift
//  dopravaBrno
//
//  Created by Michal Mrnustik on 10/04/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

class ListViewController: UITableViewController {
    let ListCellIdentififer = "ListCell";
    
    var locationManager = CLLocationManager()
    var vendingMachines: [VendingMachine] = []
    
    public static func storyboardInit() -> ListViewController {
        let storyboard = UIStoryboard(name: "List", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController()! as! ListViewController
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCellForReuse()
        self.vendingMachines = Database().fetch(with: VendingMachine.all)
    }
    
    func registerCellForReuse() {
        let cell = UINib(nibName: "ListTableViewCell", bundle: nil)
        self.tableView.register(cell, forCellReuseIdentifier: self.ListCellIdentififer)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.ListCellIdentififer, for: indexPath) as? ListTableViewCell else { return super.tableView(tableView, cellForRowAt: indexPath); }
        let machine = self.vendingMachines[indexPath.row]
        cell.nameLabel?.text = machine.title
        cell.itemImage.image = UIImage(named: machine.annotationType.rawValue)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vendingMachines.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
