//
//  PlaceTableViewCell.swift
//  dopravaBrno
//
//  Created by Michal Mrnustik on 16/04/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import UIKit
import RealmSwift

class PlaceTableViewCell: UITableViewCell, ReusableView {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var item: ListItemModel? {
        didSet {
            guard let item = item else { return }
            let distance = item.distance ?? 0
            
            switch item.originalAnnotation {
            case is VendingMachine:
                name.text = "Ticket Machine"
                distanceLabel.text = "\(String(distance)) m "
            case let vehicle as Vehicle:
                name.text = "\(vehicle.lineName) \(vehicle.finalStop.name ?? "")"
                if let distance = item.distance {
                    distanceLabel.text = "\(distance) m | Delay: \(vehicle.delay) min"
                } else {
                    distanceLabel.text = "Delay: \(vehicle.delay) min"
                }
            default:
                name.text = item.originalAnnotation.title!
                distanceLabel.text = "\(String(distance)) m "
            }
            
            picture.image = item.originalAnnotation.image?.withRenderingMode(.alwaysTemplate)
            picture.tintColor = item.originalAnnotation.color
        }
    }
    
    @IBOutlet var distanceLabel: UILabel!
    @IBOutlet var picture: UIImageView!
    @IBOutlet weak var name: UILabel!
}
