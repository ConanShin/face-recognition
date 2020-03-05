//
//  LoadingHUD.swift
//  FaceRecognition
//
//  Created by Conan Shin on 2020/03/05.
//  Copyright © 2020 Conan Shin. All rights reserved.
//

import Foundation
import UIKit
import Gifu

class LoadingHUD {
    private static let sharedInstance = LoadingHUD()
    
    private var backgroundView: UIView?
    private var popupView: UIImageView?
    private var loadingLabel: UILabel?
    
    class func show() {
        let backgroundView = UIView()
        
        let popupView = GIFImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        popupView.contentMode = .scaleAspectFit
        popupView.animate(withGIFNamed: "loading")
        
        let loadingLabel = UILabel(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
        loadingLabel.text = "Loading ..."
        loadingLabel.font = UIFont.boldSystemFont(ofSize: 20)
        loadingLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first!
        UIView.transition(with: window, duration: 0.5, options: [.transitionCrossDissolve], animations: {
            window.addSubview(backgroundView)
            window.addSubview(popupView)
//            window.addSubview(loadingLabel)
        }, completion: nil)
        
        backgroundView.frame = CGRect(x: 0, y: 0, width: window.frame.maxX, height: window.frame.maxY)
        backgroundView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        popupView.center = window.center
        popupView.startAnimating()
        
        loadingLabel.layer.position = CGPoint(x: window.frame.midX, y: popupView.frame.maxY + 10)
        
        sharedInstance.backgroundView?.removeFromSuperview()
        sharedInstance.popupView?.removeFromSuperview()
        sharedInstance.loadingLabel?.removeFromSuperview()
        sharedInstance.backgroundView = backgroundView
        sharedInstance.popupView = popupView
        sharedInstance.loadingLabel = loadingLabel
    }
    
    class func hide() {
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first!
        if let popupView = sharedInstance.popupView,
            let loadingLabel = sharedInstance.loadingLabel,
            let backgroundView = sharedInstance.backgroundView {
            popupView.stopAnimating()
            UIView.transition(with: window, duration: 0.5, options: [.transitionCrossDissolve], animations: {
              backgroundView.removeFromSuperview()
              popupView.removeFromSuperview()
              loadingLabel.removeFromSuperview()
            }, completion: nil)
        }
    }
}
