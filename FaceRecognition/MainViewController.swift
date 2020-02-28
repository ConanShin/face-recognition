//
//  MainViewController.swift
//  FaceRecognition
//
//  Created by Conan Shin on 2020/02/28.
//  Copyright © 2020 Conan Shin. All rights reserved.
//

import TinyConstraints

class MainViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Main"
        addButton()
    }
    
    fileprivate func addButton () {
        let faceDetectionButton = UIButton()
        view.addSubview(faceDetectionButton)
        faceDetectionButton.width(to: view, multiplier: 0.5)
        faceDetectionButton.height(to: view, multiplier: 0.43)
        faceDetectionButton.topToSuperview(usingSafeArea: true)
        faceDetectionButton.backgroundColor = #colorLiteral(red: 1, green: 0.5960784314, blue: 0, alpha: 1)
        faceDetectionButton.setTitle("Face Detection", for: .normal)
        faceDetectionButton.addTarget(self, action: #selector(toDetection), for: .touchUpInside)
        
        let registerButton = UIButton()
        view.addSubview(registerButton)
        registerButton.width(to: view, multiplier: 0.5)
        registerButton.height(to: view, multiplier: 0.43)
        registerButton.trailingToSuperview()
        registerButton.topToSuperview(usingSafeArea: true)
        registerButton.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        registerButton.setTitle("New Face", for: .normal)
        registerButton.addTarget(self, action: #selector(toRegister), for: .touchUpInside)
        
        let faceListButton = UIButton()
        view.addSubview(faceListButton)
        faceListButton.size(to: view, multiplier: 0.5)
        faceListButton.topToBottom(of: faceDetectionButton)
        faceListButton.setTitle("Face List", for: .normal)
        faceListButton.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        faceListButton.addTarget(self, action: #selector(toList), for: .touchUpInside)
        
        let emptyView = UIView()
        view.addSubview(emptyView)
        emptyView.size(to: view, multiplier: 0.5)
        emptyView.topToBottom(of: registerButton)
        emptyView.trailingToSuperview()
        emptyView.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
    }
    
    @objc func toDetection(sender: UIButton!) {
        moveTo(view: FaceDetectionView())
    }
    
    @objc func toRegister(sender: UIButton!) {
        moveTo(view: NewFaceView())
    }
    
    @objc func toList(sender: UIButton!) {
        moveTo(view: FaceListView())
    }
}

