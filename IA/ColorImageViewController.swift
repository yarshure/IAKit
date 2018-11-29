//
//  ColorImageViewController.swift
//  IA
//
//  Created by yarshure on 2018/11/29.
//  Copyright © 2018 yarshure. All rights reserved.
//

import UIKit
import IAKit
class ColorImageViewController: IAViewController,BarcodeScanDelegate,UITextFieldDelegate,KeyboardToolbarDelegate {

    func barcodeScanDidScan(controller: BarcodeScanViewController, configString: String) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func barcodeScanCancelScan(controller: BarcodeScanViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .lightContent
    }
    func keyboardToolbar(button: UIBarButtonItem, type: KeyboardToolbarButton, tappedIn toolbar: KeyboardToolbar) {
        inputField.resignFirstResponder()
    }
    @IBOutlet weak var inputField:SFTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let colors: [CGFloat] = [
            0xFA / 255.0, 0x7f / 255.0, 0x67 / 255.0, 1.00,
            //0xb5 / 255.0,  0x3a / 255.0, 0x40 / 255.0, 1.00,
            // 29.0 / 255.0, 156.0 / 255.0, 215.0 / 255.0, 1.00,
            0xb5 / 255.0,  0x3a / 255.0, 0x40 / 255.0, 1.00
        ]
        let v = UIImageView.init(image: UIColor.imageGradient(colors: colors, size: CGSize.init(width: 100, height: 100)))
        v.center = self.view.center
        self.view.addSubview(v)
        
        inputField.delegate = self
        let toolbar = KeyboardToolbar()
        toolbar.toolBarDelegate = self
        toolbar.setup(leftButtons: [KeyboardToolbarButton.done], rightButtons: [KeyboardToolbarButton.back,KeyboardToolbarButton.forward])
        inputField.inputAccessoryView = toolbar
        // Do any additional setup after loading the view.
    }
    

    @IBAction func showAlert(_ sender:Any){
        self.alertMessageAction(message: "Test") {
            print("done")
        }
        
    }
    @IBAction func showAlert2(_ sender:Any){
        self.alertMessageAction(title: "Alert", messages: ["A","B","C"]) { (idx) in
            self.alertMessageAction(message: "\(idx) clicked", complete: nil)
        }
    }
    @IBAction func qr(_ sender:Any){
        let vc = UIStoryboard.init(name: "Qrscan", bundle: Bundle.init(for: BarcodeScanViewController.self)).instantiateInitialViewController()! as! BarcodeScanViewController
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
