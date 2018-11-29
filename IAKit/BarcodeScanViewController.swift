//
//  ViewController.swift
//  QcodeCapture
//
//  Created by kiwi on 15/11/18.
//  Copyright © 2015年 kiwi. All rights reserved.
//

import UIKit
import AVFoundation

/// The tunnel delegate protocol.
@objc public  protocol BarcodeScanDelegate: class {
    func barcodeScanDidScan(controller: BarcodeScanViewController, configString:String)
    func barcodeScanCancelScan(controller: BarcodeScanViewController)
    
}

open class BarcodeScanViewController: IAViewController,AVCaptureMetadataOutputObjectsDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    let kScanQRCodeQueueName = "ScanQRCodeQueueName"
    var captureSession: AVCaptureSession?
   @IBOutlet weak  var containerView:UIView!
    var videoPreviewLayer : AVCaptureVideoPreviewLayer?
    var lastResult : Bool!
    
    public weak var delegate:BarcodeScanDelegate?
  
    override open func viewDidLoad() {
        super.viewDidLoad()
       
        self.view.backgroundColor = UIColor.gray
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Cancel", style: .done, target: self, action: #selector(cancel(_:)))
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func  turnOn(_ sender:Any){
        guard let avDevice = AVCaptureDevice.default(for: AVMediaType.video) else {return}
        
        // check if the device has torch
        if avDevice.hasTorch {
            // lock your device for configuration
            do {
                _ = try avDevice.lockForConfiguration()
            } catch {
                print("aaaa")
            }
            
            // check if your torchMode is on or off. If on turns it off otherwise turns it on
            if avDevice.isTorchActive {
                avDevice.torchMode = AVCaptureDevice.TorchMode.off
            } else {
                // sets the torch intensity to 100%
                do {
                    _ = try avDevice.setTorchModeOn(level: 1.0)
                } catch {
                    print("bbb")
                }
                //    avDevice.setTorchModeOnWithLevel(1.0, error: nil)
            }
            // unlock your device
            avDevice.unlockForConfiguration()
        }
    
    }
     @objc public func cancel(_ sender:Any){
        if let p  = self.presentingViewController {
            p.dismiss(animated: true, completion: nil)
        }else {
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let cameraMediaType = AVMediaType.video
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: cameraMediaType)
        
        switch cameraAuthorizationStatus {
            
        // The client is authorized to access the hardware supporting a media type.
        case .authorized:
            _ = startReading()
            
            // The client is not authorized to access the hardware for the media type. The user cannot change
        // the client's status, possibly due to active restrictions such as parental controls being in place.
        case .restricted:
            alertMessageAction(message: "Camera Have Restricted", complete: nil)
            
        // The user explicitly denied access to the hardware supporting a media type for the client.
        case .denied:
            alertMessageAction(message: "Camera Have Denied, Please Enable in System Settings", complete: nil)
            
        // Indicates that the user has not yet made a choice regarding whether the client can access the hardware.
        case .notDetermined:
            // Prompting user for the permission to use the camera.
            AVCaptureDevice.requestAccess(for: cameraMediaType) { [unowned self ] granted in
                if granted {
                    DispatchQueue.main.async {
                        _ = self.startReading()
                    }
                    
                    //print("Granted access to \(cameraMediaType)")
                } else {
                    print("Not granted access to \(cameraMediaType)")
                }
            }
        }

    }
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancleAction(_ sender: AnyObject) {
        guard let d = self.delegate else{
            return
        }
        //self.navigationController?.popViewController(animated:(<#T##animated: Bool##Bool#>)
        d.barcodeScanCancelScan(controller: self)
    }
    func  startReading() -> Bool{
//        let error: NSError?
        if captureSession == nil {
            
            guard let captureDevice: AVCaptureDevice = AVCaptureDevice.default(for: AVMediaType.video) else  {
                return false
            }
            
            let input = try! AVCaptureDeviceInput(device: captureDevice)
            
            captureSession = AVCaptureSession()
            captureSession?.addInput(input)
            
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession?.addOutput(captureMetadataOutput)
            
            let dispatchQueue = DispatchQueue(label:kScanQRCodeQueueName)
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: dispatchQueue)
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
            videoPreviewLayer = AVCaptureVideoPreviewLayer.init(session: captureSession!)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoPreviewLayer?.frame = self.view.frame
            //self.view.layer.addSublayer(!)
            self.view.layer.insertSublayer(videoPreviewLayer!, at:0)
            
        }
       
        
        
        
       
        if captureSession?.isRunning == false {
            captureSession?.startRunning()
        }
        
        
        return true
    }
    
    func stopReading(){
        captureSession?.stopRunning()
        
    }
    public func metadataOutput(_ captureOutput: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection){
    
        if let metadataObj = metadataObjects.first as? AVMetadataMachineReadableCodeObject {
            var result: String?
            
            if metadataObj.type == AVMetadataObject.ObjectType.qr{
                result = metadataObj.stringValue
            }
            let q = DispatchQueue.main
            q.async {
                self.reportScanResult(result: result)
            }
            
        }
        
    }
    
    
    func reportScanResult(result:String!){
        stopReading()
        
//        alertMessageAction(message: "scan result: " + result) {
//            
//        }
        guard let d = self.delegate else{
            return
        }
        
        d.barcodeScanDidScan(controller: self, configString: result)
    }
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func scanbarCodeFromPhotoLibrary(_ sender:AnyObject){
        let picker = UIImagePickerController()
        let src = UIImagePickerController.SourceType.savedPhotosAlbum
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: src)!
        
        picker.delegate = self
        self .present(picker, animated: true) { () -> Void in
            
        }
        
    }
    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        self.dismiss(animated: true) { () -> Void in
            
        }
        
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        let ciImage:CIImage = CIImage(image: image)!
        var message:String = ""
        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy: CIDetectorAccuracyHigh])
        
        let features = detector!.features(in: ciImage)
        
        if features.count > 0{
            
            for feature in features as! [CIQRCodeFeature]{
                message += feature.messageString!
            }
            if let _ = NSURL.init(string: message ) {
                delegate?.barcodeScanDidScan(controller: self, configString: message)
            }else {
//                if let data = NSData.init(base64EncodedString: message, options:.IgnoreUnknownCharacters){
//                    if let _ = String.init(data: data, encoding: NSUTF8StringEncoding) {
//                        delegate?.barcodeScanDidScan(self, configString: message)
//                    }else {
//                        alertMessageAction("\(message) Invalid", complete: nil)
//                    }
//                }
                //
                delegate?.barcodeScanDidScan(controller: self, configString: message)
            }
            

            
            
            //self.convertConfigString(message)
            
            
        }else{
            
            let alert = UIAlertController.init(title: "Error", message: "No Valid QRCode Detected", preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "OK", style: .cancel, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true) { () -> Void in
            
        }
//        if let session = captureSession {
//            videoPreviewLayer = AVCaptureVideoPreviewLayer.init(session: captureSession)
//            videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
//            videoPreviewLayer?.frame = self.view.frame
//            //self.view.layer.addSublayer(!)
//            self.view.layer.insertSublayer(videoPreviewLayer!, atIndex:0)
//            session.startRunning()
//        }
    }
    open override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator){
        coordinator.animateAlongsideTransition(in: self.view, animation: { (ctx) in
            let transition = CATransition()
            transition.duration = ctx.transitionDuration
            
            // Make it fade
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            transition.type = CATransitionType.fade
            self.videoPreviewLayer?.add(transition, forKey: "Fade")
            if size.width > size.height {
                //land
                self.videoPreviewLayer?.setAffineTransform( CGAffineTransform(rotationAngle: -.pi/2))
            }else {
                self.videoPreviewLayer?.setAffineTransform(CGAffineTransform(rotationAngle: 0.0))
            }
            self.videoPreviewLayer?.frame.origin = self.view.frame.origin
        }) { (ctx) in
            
        }
        
    }
}

