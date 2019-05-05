//
//  CircleAnnotationView.swift
//  dopravaBrno
//
//  Created by Michal Mrnustik on 05/05/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import UIKit
import CoreGraphics

public class CircleAnnotationView: UIView {
    @IBOutlet var contentView: CircleAnnotationView!
    @IBOutlet weak var backrgoundView: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var arrowImage: UIImageView!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("AnnotationView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.frame
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        let center = backrgoundView.center
        let newFrame = CGRect(x: backrgoundView.frame.origin.x, y: backrgoundView.frame.origin.y, width: 50, height: 50)
        backrgoundView.frame = newFrame;
        backrgoundView.layer.cornerRadius = 50 / 2.0;
        backrgoundView.center = center;
        backrgoundView.borderWidth = 2
    }
}
