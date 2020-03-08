//
//  NewFaceView.swift
//  FaceRecognition
//
//  Created by Conan Shin on 2020/02/28.
//  Copyright © 2020 Conan Shin. All rights reserved.
//

import UIKit

class NewFaceView: UIViewController {
    let camera = CameraView(control: true)
    var imageTaken: UIImage? = nil
    let pictureArea = UIView()
    let textField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "New Face"
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        setupView()
        drawEmptyPerson()
        drawCameraButton()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
          view.endEditing(true)
    }
    
    fileprivate func setupView () {
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveFace))
        navigationItem.rightBarButtonItem = saveButton
        
        view.addSubview(pictureArea)
        pictureArea.clipsToBounds = true
        pictureArea.center(in: view)
        pictureArea.size(CGSize(width: 200, height: 200))
        pictureArea.layer.cornerRadius = 100
        pictureArea.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        
        let label = UILabel()
        view.addSubview(label)
        label.text = "Enter your name."
        label.center(in: view, offset: CGPoint(x: 0, y: 150))
        
        view.addSubview(textField)
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 2, 0)
        textField.center(in: view, offset: CGPoint(x: 0, y: 200))
        textField.size(CGSize(width: 200, height: 30))
        textField.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        textField.font = UIFont(name: "AppleSDGothicNeo-Light", size: 12.0)
        textField.text = ""
        textField.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    }
    
    fileprivate func removeEmptyPerson () {
        for view in pictureArea.subviews{
            view.removeFromSuperview()
        }
    }
    
    fileprivate func drawEmptyPerson () {
        let body = UIView()
        pictureArea.addSubview(body)
        body.size(CGSize(width: 200, height: 200))
        body.centerY(to: pictureArea, offset: 145)
        body.layer.cornerRadius = 100
        body.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        let head = UIView()
        pictureArea.addSubview(head)
        head.size(CGSize(width: 90, height: 90))
        head.center(in: pictureArea)
        head.layer.cornerRadius = 45
        head.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    fileprivate func drawCameraButton () {
        let image = UIImage(systemName: "camera.circle")
        let button = UIButton(frame: CGRect(x: 220, y: 440, width: 70, height: 70))
        button.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        button.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        button.setBackgroundImage(image, for: .normal)
        button.addTarget(self, action: #selector(showCamera), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc fileprivate func saveFace () {
        view.endEditing(true)
        if imageTaken == nil {
            let alertController = UIAlertController.init(title: "", message: "사진촬영을 해주세요.", preferredStyle: .alert)
            let okAction = UIAlertAction.init(title: "알겠습니다", style: .default, handler: {(alert: UIAlertAction!) in})
            alertController.addAction(okAction)
            return present(alertController, animated: true, completion: nil)
        }
        let name = textField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if name.regexCheck(regex: "[a-z0-9]") == false {
            let alertController = UIAlertController.init(title: "", message: "이름으로 알파벳과 숫자만 가능합니다.", preferredStyle: .alert)
            let okAction = UIAlertAction.init(title: "알겠습니다", style: .default, handler: {(alert: UIAlertAction!) in})
            alertController.addAction(okAction)
            return present(alertController, animated: true, completion: nil)
        }
//        if name == "" {
//            let alertController = UIAlertController.init(title: "", message: "이름을 넣어주세요.", preferredStyle: .alert)
//            let okAction = UIAlertAction.init(title: "알겠습니다", style: .default, handler: {(alert: UIAlertAction!) in})
//            alertController.addAction(okAction)
//            return present(alertController, animated: true, completion: nil)
//        }
        let imageData = imageTaken!.jpegData(compressionQuality: 0.5)
        Rekognition.add(image: imageData! as NSData, name: name, callback: {
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        })
    }
    
    @objc fileprivate func showCamera () {
        camera.callback = { image in
            self.removeEmptyPerson()
            self.imageTaken = image
            let face = UIImageView(frame: CGRect(x: 0, y: -50, width: 200, height: 250))
            face.image = image
            self.pictureArea.addSubview(face)
        }
        present(camera.imagePicker, animated: true, completion: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= (keyboardSize.height - 100)
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}
