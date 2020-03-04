//
//  FaceListView.swift
//  FaceRecognition
//
//  Created by Conan Shin on 2020/02/28.
//  Copyright © 2020 Conan Shin. All rights reserved.
//

import UIKit

class FaceListView: UIViewController {
    var restApi = Rekognition()
    var rows: [UIView] = []
    let progress = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Face List"
        view.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        view.addSubview(restApi.view)
        readFaceList()
    }
    
    fileprivate func readFaceList () {
        removeRows()
        restApi.list(callback: { faces in
            print("faces", faces)
            DispatchQueue.main.async {
                self.setupView(list: faces)
            }
        })
    }
    
    fileprivate func removeRows () {
        DispatchQueue.main.async {
            for row in self.rows {
                row.removeFromSuperview()
            }
        }
    }
    
    fileprivate func setupView (list: [Face]) {
        var previousFace: UIView? = nil
        for face in list {
            let row = UIView()
            view.addSubview(row)
            row.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
            if previousFace == nil {
                row.top(to: self.navigationController!.navigationBar, offset: 50)
            } else {
                row.topToBottom(of: previousFace!, offset: 5)
            }
            row.width(to: view, offset: -10)
            row.height(70)
            row.centerX(to: view)
            
            let name = UILabel()
            row.addSubview(name)
            name.centerY(to: row)
            name.leading(to: row, offset: 10)
            name.text = face.name
            name.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            
            let trash = ParamButton()
            row.addSubview(trash)
            trash.titleEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
            trash.size(CGSize(width: 20, height: 20))
            trash.trailing(to: row, offset: -10)
            trash.centerY(to: row)
            trash.setImage(UIImage(named: "trash"), for: .normal)
            trash.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            trash.params["name"] = face.name
            trash.params["id"] = face.faceId
            trash.addTarget(self, action: #selector(deleteFace(sender:)), for: .touchUpInside)
            
            rows.append(row)
            previousFace = row
        }
    }
    
    @objc fileprivate func deleteFace (sender: ParamButton) {
        removeRows()
        self.restApi.delete(faceId: sender.params["id"] as! String, callback: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.readFaceList()
            }
        })
    }
}
