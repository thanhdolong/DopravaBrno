//
//  PlaceTableViewCell.swift
//  dopravaBrno
//
//  Created by Michal Mrnustik on 16/04/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import UIKit

class PlaceTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet var distanceLabel: UILabel!
    @IBOutlet var picture: UIImageView!
    @IBOutlet weak var name: UILabel!
}
