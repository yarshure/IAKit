//
//  IAViewController.swift
//  IAKit
//
//  Created by yarshure on 2018/11/29.
//  Copyright © 2018 yarshure. All rights reserved.
//

import UIKit

open class IAViewController: UIViewController {

    override open func viewDidLoad() {
        super.viewDidLoad()
        //self.view.addSubview(<#T##view: UIView##UIView#>)
        // Do any additional setup after loading the view.
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    public func alertMessageAction(message:String,complete:(() -> Void)?) {
        var style:UIAlertController.Style = .alert
        let deviceIdiom = UIScreen.main.traitCollection.userInterfaceIdiom
        switch deviceIdiom {
        case .pad:
            style = .alert
        default:
            break
            
        }
        let alert = UIAlertController.init(title: "Alert".localized, message: message, preferredStyle: style)
        let action = UIAlertAction.init(title: "OK".localized, style: .default) { (action:UIAlertAction) -> Void in
            if let callback = complete {
                callback()
            }
        }
        alert.addAction(action)
        self.present(alert, animated: true) { () -> Void in
            
        }
    }
    open func alertMessageAction(title:String ,messages:[String],complete:((Int) -> Void)?) {
        var style:UIAlertController.Style = .actionSheet
        let deviceIdiom = UIScreen.main.traitCollection.userInterfaceIdiom
        switch deviceIdiom {
        case .pad:
            style = .alert
        default:
            break
            
        }
        let alert = UIAlertController.init(title: "Alert".localized, message: title, preferredStyle: style)
        var idx:Int = 0
        for message in messages {
            let action = UIAlertAction.init(title: message, style: .default) { (action:UIAlertAction) -> Void in
                if let callback = complete {
                    callback(idx)
                }
                
            }
            idx += 1
            alert.addAction(action)
        }
        let action = UIAlertAction.init(title: "Cancel", style: .cancel) { (action:UIAlertAction) -> Void in
            //            if let callback = complete {
            //               callback()
            //            }
        }
        alert.addAction(action)
        self.present(alert, animated: true) { () -> Void in
            
        }
    }
}
