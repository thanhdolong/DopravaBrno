//
//  SwitchItemView.swift
//  dopravaBrno
//
//  Created by Thành Đỗ Long on 16/05/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import UIKit

@IBDesignable
class SwitchItemView: UIView {
    var contentView: UIView?

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var switchButton: UISwitch!
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    func xibSetup() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        contentView = view
        contentView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

    @IBAction func switchTapped(_ sender: UISwitch) {
        
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}
