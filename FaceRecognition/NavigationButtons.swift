//
//  NavigationButtons.swift
//  FaceRecognition
//
//  Created by Conan Shin on 2020/02/28.
//  Copyright © 2020 Conan Shin. All rights reserved.
//

import UIKit

class NavigationButtons: UIViewController {
    override func viewDidLoad () {
        super.viewDidLoad()
        let customButton = UIBarButtonItem(barButtonSystemItem: .undo, target: self, action: #selector(back(_:)))
        self.navigationItem.leftBarButtonItem = customButton
    }
    
    @objc fileprivate func back (_ sender: Any) {
        print("back pressed")
    }
}
