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
    weak var transportModule: TransportModule?
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(refresh(_:)),
                                 for: UIControl.Event.valueChanged)

        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Data.")
        return refreshControl
    }()
    private var indicator: UIView?
    var latestLocation: CLLocation?
    var listItems: [ListItemModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    @objc func refresh(_ sender: UIRefreshControl) {
        // Code to refresh table view
        self.transportModule?.requestData(refreshControl)
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.addSubview(self.refreshControl)
        
        registerCellForReuse()
        
        transportModule?.multicastDelegate.addDelegate(self)
        transportModule?.requestData(refreshControl)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    func showRecalculatedDistance(location: CLLocation?) {
        guard let location = location else { return }
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
            return ListItemModel(originalAnnotation: item, distance: nil)
        })
        showRecalculatedDistance(location: latestLocation)
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
        latestLocation = location
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
