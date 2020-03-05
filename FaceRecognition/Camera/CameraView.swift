//
//  CameraView.swift
//  FaceRecognition
//
//  Created by Conan Shin on 2020/02/28.
//  Copyright © 2020 Conan Shin. All rights reserved.
//

import UIKit
import AVFoundation
import MobileCoreServices

class CameraView: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var imagePicker: UIImagePickerController = UIImagePickerController()
    var callback: ((UIImage) -> Void)?
    
    init (control: Bool = false) {
        super.init()
        camera(showControl: control)
        overlay()
    }
    
    func takePicture (cb: @escaping (UIImage) -> Void) {
        callback = cb
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
            self.imagePicker.takePicture()
        })
        
    }
    
    fileprivate func camera (showControl: Bool) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.cameraDevice = .front
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = false
            imagePicker.cameraFlashMode = .off
            imagePicker.showsCameraControls = showControl
            imagePicker.modalPresentationStyle = .fullScreen
        } else {
            let alertController = UIAlertController.init(title: nil, message: "Device has no camera.", preferredStyle: .alert)
            let okAction = UIAlertAction.init(title: "Alright", style: .default, handler: {(alert: UIAlertAction!) in})
            alertController.addAction(okAction)
            imagePicker.present(alertController, animated: true, completion: nil)
        }
    }
    
    fileprivate func overlay () {
        let descriptionView = UIView(frame: CGRect(x: 0, y: 0, width: imagePicker.view.frame.size.width, height: 100))
        descriptionView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
        let text = UILabel()
        descriptionView.addSubview(text)
        text.center(in: descriptionView, offset: CGPoint(x: 0, y: 15))
        text.text = "Please look at the camera"
        text.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        text.font = text.font.withSize(20)
        
        imagePicker.cameraOverlayView = descriptionView
    }
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let uiImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
//        let compressedImage =  uiImage.jpegData(compressionQuality: 0.5)! as NSData
//        let flippedImage = UIImage(cgImage: uiImage.cgImage!, scale: uiImage.scale, orientation: .leftMirrored)
        
        self.callback!(uiImage)
        imagePicker.dismiss(animated: true, completion: nil)
    } 
}
