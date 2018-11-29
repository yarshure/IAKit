//
//  Extension.swift
//  UnionpayInt
//
//  Created by yarshure on 8/11/2018.
//  Copyright © 2018 yarshure. All rights reserved.
//

import UIKit
extension UINavigationController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        if let t = topViewController {
            return  t.preferredStatusBarStyle
        }
        return .default
    }
}

