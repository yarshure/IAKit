//
//  ViewController.swift
//  IA
//
//  Created by yarshure on 2018/11/29.
//  Copyright © 2018 yarshure. All rights reserved.
//

import UIKit
import IAKit
class ViewController: IATableViewController,BarcodeScanDelegate {
    func barcodeScanDidScan(controller: BarcodeScanViewController, configString: String) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func barcodeScanCancelScan(controller: BarcodeScanViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let image =  UIColor.init(red: 0x21/255, green: 0x66/255, blue: 0xce/255, alpha: 1.0).image()
        self.navigationController?.navigationBar.setBackgroundImage(image, for: .default)
        self.alertMessageAction(message: "Test") {
            self.showQR()
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    func showQR()  {
        let vc = UIStoryboard.init(name: "Qrscan", bundle: Bundle.init(for: BarcodeScanViewController.self)).instantiateInitialViewController()! as! BarcodeScanViewController
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
}

