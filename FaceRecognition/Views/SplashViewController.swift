//
//  SplashViewController.swift
//  FaceRecognition
//
//  Created by Conan Shin on 2020/03/08.
//  Copyright © 2020 Conan Shin. All rights reserved.
//

import Foundation
import UIKit
import Gifu

class SplashViewController: UIViewController {
    let window = UIWindow(frame: UIScreen.main.bounds)
    let popupView = GIFImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view.addSubview(popupView)
        popupView.size(CGSize(width: 200, height: 140))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        popupView.center(in: view)
        popupView.animate(withGIFNamed: "loading.gif")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            self.popupView.stopAnimating()
            self.popupView.removeFromSuperview()
            let rootViewController = MainViewController()
            let navigationController = NavigationController(rootViewController: rootViewController)
            UIView.transition(with: self.window, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                self.window.rootViewController = navigationController
                self.window.makeKeyAndVisible()
            }, completion: nil)
        })
    }
}
