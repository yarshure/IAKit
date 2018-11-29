//
//  ViewController.swift
//  IA
//
//  Created by yarshure on 2018/11/29.
//  Copyright © 2018 yarshure. All rights reserved.
//

import UIKit
import IAKit

class ViewController: IATableViewController {
   
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let image =  UIColor.init(red: 0x21/255, green: 0x66/255, blue: 0xce/255, alpha: 1.0).image()
        self.navigationController?.navigationBar.setBackgroundImage(image, for: .default)
       
        
        // Do any additional setup after loading the view, typically from a nib.
    }
   
    
}

