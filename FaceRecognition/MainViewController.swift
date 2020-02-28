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
        view.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        addButton()
    }
    
    fileprivate func addButton () {
        let faceDetectionButton = UIButton()
        view.addSubview(faceDetectionButton)
        faceDetectionButton.size(to: view, multiplier: 0.5)
        faceDetectionButton.topToSuperview(usingSafeArea: true)
        faceDetectionButton.backgroundColor = #colorLiteral(red: 1, green: 0.5960784314, blue: 0, alpha: 1)
        faceDetectionButton.setTitle("Face Detection", for: .normal)
        faceDetectionButton.addTarget(self, action: #selector(toDetection), for: .touchUpInside)
        
        let registerButton = UIButton()
        view.addSubview(registerButton)
        registerButton.size(to: view, multiplier: 0.5)
        registerButton.leadingToTrailing(of: faceDetectionButton)
        registerButton.topToSuperview(usingSafeArea: true)
        registerButton.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        registerButton.setTitle("New Face", for: .normal)
        registerButton.addTarget(self, action: #selector(toRegister), for: .touchUpInside)
        
    }
    
    @objc func toDetection(sender: UIButton!) {
        moveTo(view: FaceDetectionView())
    }
    
    @objc func toRegister(sender: UIButton!) {
        moveTo(view: FaceDetectionView())
    }
}

