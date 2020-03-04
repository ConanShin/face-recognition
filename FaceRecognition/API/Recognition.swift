//
//  Recognition.swift
//  FaceRecognition
//
//  Created by Conan Shin on 2020/02/29.
//  Copyright © 2020 Conan Shin. All rights reserved.
//

import UIKit
import Foundation

public class Rekognition: UIViewController {
    var ADD_URL="https://j1po3p7ys1.execute-api.ap-northeast-2.amazonaws.com/dev/face"
    var SEARCH_URL="https://j1po3p7ys1.execute-api.ap-northeast-2.amazonaws.com/dev/face/search"
    var LIST_URL="https://j1po3p7ys1.execute-api.ap-northeast-2.amazonaws.com/dev/face"
    var DELETE_URL="https://j1po3p7ys1.execute-api.ap-northeast-2.amazonaws.com/dev/face"
    var request = Request()
    
    let progress = UILabel()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    fileprivate func showProgress () {
        DispatchQueue.main.async {
            self.view.addSubview(self.progress)
            self.progress.center(in: self.view)
            self.progress.text = "Waiting For Response"
        }
    }
    
    fileprivate func hideProgress () {
        DispatchQueue.main.async {
            self.progress.removeFromSuperview()
        }
    }
    
    func add (image: NSData, name: String, callback: @escaping () -> Void) {
        let body: NSMutableDictionary = NSMutableDictionary()
        body.setValue(image.base64EncodedString(options: NSData.Base64EncodingOptions.lineLength64Characters), forKey: "data")
        body.setValue(name, forKey: "id")
        
        do {
            try self.request.post(url: URL(string: ADD_URL)!, body: body, completionHandler: { data, response, error in
                callback()
            })
        } catch {
            print(error)
        }
    }
    
    func search (image: NSData, callback: @escaping (String) -> Void) {
        let body: NSMutableDictionary = NSMutableDictionary()
        body.setValue(image.base64EncodedString(options: NSData.Base64EncodingOptions.lineLength64Characters), forKey: "data")

        do {
            try self.request.post(url: URL(string: SEARCH_URL)!, body: body, completionHandler: { data, response, error in
                do {
                    let dict = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:Any]
                    callback(dict["data"] as! String)
                } catch {
                    print(error)
                }
            })
        } catch {
            print(error)
        }
    }
    
    func list (callback: @escaping ([Face]) -> Void) {
        showProgress()
        self.request.get(url: URL(string: LIST_URL)!, completionHandler: { data, response, error in
            do {
                var faces = [Face]()
                let data = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:Any]
                for face in data["data"] as! [[String: Any]] {
                    faces.append(Face(faceId: face["id"] as! String, name: face["name"] as! String))
                }
                self.hideProgress()
                callback(faces)
            } catch {
                print(error)
            }
        })
    }
    
    func delete (faceId: String, callback: @escaping () -> Void) {
        showProgress()
        let body: NSMutableDictionary = NSMutableDictionary()
        body.setValue(faceId, forKey: "data")
        do {
            try self.request.delete(url: URL(string: DELETE_URL)!, body: body, completionHandler: { data, response, error in
                callback()
            })
        } catch {
            print(error)
        }
        
    }
}
