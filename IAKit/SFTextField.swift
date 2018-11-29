//
//  SFTextField.swift
//  UnionpayInt
//
//  Created by yarshure on 27/11/2018.
//  Copyright © 2018 yarshure. All rights reserved.
//

import UIKit

public class SFTextField: UITextField {

    override public func awakeFromNib() {
        let footerView = UIView.init(frame: CGRect.init(x: 0, y: self.frame.size.height-8, width: self.frame.width, height: 1))
        footerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(footerView)
        let cn16 = NSLayoutConstraint(item: footerView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0)
        let cn17 = NSLayoutConstraint(item: footerView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0)
        let cn18 = NSLayoutConstraint(item: footerView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 1)
        //let cn19 = NSLayoutConstraint(item: footerView, attribute: .width, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 400)
        let cn20 = NSLayoutConstraint(item: footerView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -12)
        self.addConstraint(cn16)
        self.addConstraint(cn17)
        self.addConstraint(cn18)
        //self.addConstraint(cn19)
        self.addConstraint(cn20)
        //self.addConstraint(cn21)
        //v.center.x = self.center.x
        //v.addConstraint(NSLayoutConstraint(item: v, attribute: .width, relatedBy: .equal, toItem: v.superview, attribute: .width, multiplier: 1, constant: 0))
        //self.addConstraint(NSLayoutConstraint(item: v, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 1))
       // v.addConstraint(NSLayoutConstraint(item: v, attribute: .leading, relatedBy: .equal, toItem: v.superview, attribute: .leading, multiplier: 1, constant: 0))
        //self.addConstraint(NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: v, attribute: .bottom, multiplier: 1, constant: 8))
        footerView.backgroundColor = UIColor.gray
        
        
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
class SFButton: UIButton {
    override func awakeFromNib() {
        self.layer.cornerRadius = 10
    }
}
