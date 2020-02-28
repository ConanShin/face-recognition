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
        
        self.title = "Title"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
//        let backButton = UIBarButtonItem()
//        let backImage = UIImage(systemName: "arrowtriangle.left.fill")
//        backButton.image = backImage
//        backButton.target = self
//        backButton.style = UIBarButtonItem.Style.plain
//        backButton.action = #selector(back(_:))
//        self.navigationItem.backBarButtonItem = backButton
    }
//    @objc fileprivate func back (_ sender: Any) {
//       print("back pressed")
//    }
    func moveTo (view: UIViewController) {
        self.navigationController?.pushViewController(view, animated: true)
    }
}
