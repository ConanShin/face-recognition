//
//  FaceDetectionView.swift
//  FaceRecognition
//
//  Created by Conan Shin on 2020/02/28.
//  Copyright © 2020 Conan Shin. All rights reserved.
//

import UIKit

class FaceDetectionView: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Face Detection"
        view.backgroundColor = #colorLiteral(red: 1, green: 0.5960784314, blue: 0, alpha: 1)
        
        moveTo(view: CameraView())
    }
}
