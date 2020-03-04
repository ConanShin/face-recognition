//
//  FaceDetectionView.swift
//  FaceRecognition
//
//  Created by Conan Shin on 2020/02/28.
//  Copyright © 2020 Conan Shin. All rights reserved.
//

import SwiftUI
import TinyConstraints

class FaceDetectionView: BaseViewController {
    var restApi = Rekognition()
    var faceImage: NSData? = nil
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Face Detection"
        view.backgroundColor = #colorLiteral(red: 1, green: 0.5960784314, blue: 0, alpha: 1)
        setupView()
        checkFace()
    }
    
    fileprivate func setupView () {
        view.addSubview(label)
        label.center(in: view)
        label.textColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        label.text = "Searching For Face"
    }
    
    fileprivate func checkFace () {
        restApi.search(image: faceImage!, callback: { name in
            DispatchQueue.main.async {
                self.label.text = name
            }
        })
    }
}
