//
//  CameraView.swift
//  FaceRecognition
//
//  Created by Conan Shin on 2020/02/28.
//  Copyright © 2020 Conan Shin. All rights reserved.
//

import UIKit
import MobileCoreServices

class CameraView: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet var imageView: UIImageView!
    var newMedia: Bool?
    
    @IBAction func useCamera(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
            newMedia = true
        }
    }
    
    @IBAction func useCameraRoll(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true, completion: nil)
            newMedia = false
        }
    }
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let uiImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        let imageData:NSData = uiImage.jpegData(compressionQuality: 0.5)! as NSData
        
        self.dismiss(animated: true, completion: nil)
        
        if (newMedia == true) {
            // 이미지 저장
            // 성공, 실패 여부를 알려주기 위한 메서드가 호출된다.
            print(imageData)
        }
    }
    // 실패 여부 알려주는 메서드 (성공 실패 상관없이 액션이 끝나면 호출됨)
    @objc func image(image: UIImage, didFinishSavingWithError error: ErrorPointer, contextInfo:UnsafeRawPointer) {
        if error != nil {
            let alert = UIAlertController(title: "Detection Failed", message: "Failed to detect face", preferredStyle: UIAlertController.Style.alert)
            
            let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
}
