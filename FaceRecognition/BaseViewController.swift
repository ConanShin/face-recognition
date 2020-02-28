//
//  BaseViewController.swift
//  FaceRecognition
//
//  Created by Conan Shin on 2020/02/28.
//  Copyright © 2020 Conan Shin. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    func moveTo (view: UIViewController) {
        self.navigationController?.pushViewController(view, animated: true)
    }
}
