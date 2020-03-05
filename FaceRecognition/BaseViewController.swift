//
//  BaseViewController.swift
//  FaceRecognition
//
//  Created by Conan Shin on 2020/03/01.
//  Copyright © 2020 Conan Shin. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func moveTo (view: UIViewController, animation: Bool = false) {
        self.navigationController?.pushViewController(view, animated: animation)
    }
}
