//
//  FaceDetectionView.swift
//  FaceRecognition
//
//  Created by Conan Shin on 2020/02/28.
//  Copyright © 2020 Conan Shin. All rights reserved.
//

import UIKit
import TinyConstraints

class FaceDetectionView: BaseViewController {
    var restApi = Rekognition()
    var faceImage: UIImage? = nil
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Face Detection"
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        setupView()
        checkFace()
    }
    
    fileprivate func setupView () {
        view.addSubview(label)
        label.center(in: view)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    fileprivate func checkFace () {
        Rekognition.search(image: faceImage!, callback: { name in
            DispatchQueue.main.async {
                self.label.text = name
            }
        })
    }
}
