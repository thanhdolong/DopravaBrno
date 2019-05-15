//
//  ListViewController.swift
//  dopravaBrno
//
//  Created by Michal Mrnustik on 10/04/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit
import UIKit

class ListItemModel {
    var originalAnnotation: Annotation
    var distance: Int?

    required init(originalAnnotation: Annotation, distance: Int?) {
        self.originalAnnotation = originalAnnotation
        self.distance = distance
    }
}

class ListViewController: UIViewController, StoryboardInstantiable, UITableViewDataSource, UITableViewDelegate {
    var listItems: [ListItemModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        registerCellForReuse()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    func showRecalculatedDistance(location: CLLocation) {
        listItems = listItems.map { (listItem) -> ListItemModel in
            let itemLocation = CLLocation(latitude: listItem.originalAnnotation.coordinate.latitude, longitude: listItem.originalAnnotation.coordinate.longitude)
            let distance = itemLocation.distance(from: location)
            
            listItem.distance = Int(distance)
            return listItem
        }.sorted(by: {$0.distance! < $1.distance!})
        self.tableView.reloadData()
    }
        
    func appendListItems(sequnce items: [Annotation]) {
        listItems += items.map({ (item) -> ListItemModel in
            if let vehicle = item as? Vehicle {
                vehicle.route = "\(vehicle.route) \(vehicle.headSign)"
                return ListItemModel(originalAnnotation: vehicle, distance: nil)
            } else {
                return ListItemModel(originalAnnotation: item, distance: nil)
            }
        })
        self.tableView.reloadData()
    }
    
    func removeFromListItems(type: AnnotationType) {
        listItems.removeAll { (listItem) -> Bool in
            return listItem.originalAnnotation.annotationType == type
        }
    }
    
    func registerCellForReuse() {
        self.tableView.register(PlaceTableViewCell.nib, forCellReuseIdentifier: PlaceTableViewCell.reuseIdentifier)
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: PlaceTableViewCell.reuseIdentifier, for: indexPath) as? PlaceTableViewCell else { return self.tableView(tableView, cellForRowAt: indexPath); }
        cell.selectionStyle = .none
        cell.item = listItems[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listItems.count
    }
}

extension ListViewController: TransportDelegate {
    func didChange(stops: [Stop]) {
        removeFromListItems(type: AnnotationType.Stop)
        appendListItems(sequnce: stops)
    }
    
    func didChange(location: CLLocation?) {
        guard let location = location else { return }
        self.showRecalculatedDistance(location: location)
    }
    
    func didChange(vehicles: [Vehicle]) {
        removeFromListItems(type: AnnotationType.Vehicle)
        appendListItems(sequnce: vehicles)
    }
    
    func didChange(vendingMachines: [VendingMachine]) {
        removeFromListItems(type: AnnotationType.VendingMachine)
        appendListItems(sequnce: vendingMachines)
    }
}
