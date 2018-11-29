//
//  UIImage+Ext.swift
//  IAKit
//
//  Created by yarshure on 2018/11/29.
//  Copyright © 2018 yarshure. All rights reserved.
//

import UIKit

extension UIColor {
    public func image() -> UIImage {
        let rect = CGRect(x: CGFloat(0.0), y: CGFloat(0.0), width: CGFloat(1.0), height: CGFloat(1.0))
        UIGraphicsBeginImageContext(rect.size)
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(self.cgColor)
            context.fill(rect)
        }
        let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
