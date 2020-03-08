//
//  MainViewController.swift
//  FaceRecognition
//
//  Created by Conan Shin on 2020/02/28.
//  Copyright © 2020 Conan Shin. All rights reserved.
//

import UIKit
import TinyConstraints

class MainViewController: BaseViewController {
//    let camera = CameraView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Main"
        addButton()
    }
    
    fileprivate func addButton () {
        let wrapper1 = UIView()
        let wrapper2 = UIView()
        let wrapper3 = UIView()
        let wrapper4 = UIView()
        view.addSubview(wrapper1)
        view.addSubview(wrapper2)
        view.addSubview(wrapper3)
        view.addSubview(wrapper4)
        view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
        let boxWidth = CGFloat(0.5)
        let boxHeight = CGFloat(0.423)
        wrapper1.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        wrapper1.width(to: view, multiplier: boxWidth)
        wrapper1.height(to: view, multiplier: boxHeight)
        wrapper1.leadingToSuperview()
        wrapper1.topToSuperview(usingSafeArea: true)
        wrapper2.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        wrapper2.width(to: view, multiplier: boxWidth)
        wrapper2.height(to: view, multiplier: boxHeight)
        wrapper2.trailingToSuperview()
        wrapper2.topToSuperview(usingSafeArea: true)
        wrapper3.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        wrapper3.width(to: view, multiplier: boxWidth)
        wrapper3.height(to: view, multiplier: boxHeight)
        wrapper3.leadingToSuperview()
        wrapper3.bottomToSuperview(usingSafeArea: true)
        wrapper4.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        wrapper4.width(to: view, multiplier: boxWidth)
        wrapper4.height(to: view, multiplier: boxHeight)
        wrapper4.trailingToSuperview()
        wrapper4.bottomToSuperview(usingSafeArea: true)

        let faceDetectionButton = UIButton()
        wrapper1.addSubview(faceDetectionButton)
        faceDetectionButton.edges(to: wrapper1, insets: TinyEdgeInsets(top: 5, left: 5, bottom: 2.5, right: 2.5))
        faceDetectionButton.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        faceDetectionButton.setTitle("Face Detection", for: .normal)
        faceDetectionButton.addTarget(self, action: #selector(toDetection), for: .touchUpInside)
        
        let registerButton = UIButton()
        wrapper2.addSubview(registerButton)
        registerButton.edges(to: wrapper2, insets: TinyEdgeInsets(top: 5, left: 2.5, bottom: 2.5, right: 5))
        registerButton.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        registerButton.setTitle("New Face", for: .normal)
        registerButton.addTarget(self, action: #selector(toRegister), for: .touchUpInside)
        
        let faceListButton = UIButton()
        wrapper3.addSubview(faceListButton)
        faceListButton.edges(to: wrapper3, insets: TinyEdgeInsets(top: 2.5, left: 5, bottom: 5, right: 2.5))
        faceListButton.setTitle("Face List", for: .normal)
        faceListButton.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        faceListButton.addTarget(self, action: #selector(toList), for: .touchUpInside)
    }
    
    @objc func toDetection(sender: UIButton!) {
//        present(camera.imagePicker, animated: true, completion: nil)
//        camera.takePicture(cb: { faceImage in
//            let nextView = FaceDetectionView()
//            nextView.faceImage = faceImage
//            self.moveTo(view: nextView)
//        })
    }
    
    @objc func toRegister(sender: UIButton!) {
        moveTo(view: NewFaceView(), animation: true)
    }
    
    @objc func toList(sender: UIButton!) {
        moveTo(view: FaceListView())
    }
}

