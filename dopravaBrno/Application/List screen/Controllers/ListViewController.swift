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
    var distance : Int

    required init(originalAnnotation: Annotation, distance: Int) {
        self.originalAnnotation = originalAnnotation
        self.distance = distance
    }
}

class ListViewController: UITableViewController {
    static let ListCellIdentififer = "ListCell";
    var locationManager = CLLocationManager()
    var listItems: [ListItemModel] = []
    
    public static func storyboardInit() -> ListViewController {
        let storyboard = UIStoryboard(name: "List", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController()! as! ListViewController
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        registerCellForReuse()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.locationManager.delegate = self
        self.locationManager.requestLocation()
    }
    
    func getAllAnnotations() -> [Annotation] {
        let vendingMachines: [Annotation] = Database().fetch(with: VendingMachine.all)
        let vehicles: [Annotation] = Database().fetch(with: Vehicle.all)
        return vendingMachines + vehicles;
    }
    
    func showRecalculatedDistance(location: CLLocation) {
        let annotations = self.getAllAnnotations()
        self.listItems = annotations.map ({
            (annotation) -> ListItemModel in
            let annotationLocation = CLLocation(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)
            let distance = annotationLocation.distance(from: location)
            return ListItemModel(originalAnnotation: annotation, distance: Int(distance))
        }).sorted(by: { $0.distance < $1.distance })
        self.tableView.reloadData()
    }
    
    func registerCellForReuse() {
        let cell = UINib(nibName: "PlaceTableViewCell", bundle: nil)
        self.tableView.register(cell, forCellReuseIdentifier: ListViewController.ListCellIdentififer)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListViewController.ListCellIdentififer, for: indexPath) as? PlaceTableViewCell else { return super.tableView(tableView, cellForRowAt: indexPath); }
        let model = self.listItems[indexPath.row]
        cell.name.text = model.originalAnnotation.title ?? ""
        cell.picture.image = model.originalAnnotation.image
        cell.picture.backgroundColor = model.originalAnnotation.color
        cell.distanceLabel.text = String(model.distance) + " m"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listItems.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
