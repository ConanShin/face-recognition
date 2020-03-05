//
//  Recognition.swift
//  FaceRecognition
//
//  Created by Conan Shin on 2020/02/29.
//  Copyright © 2020 Conan Shin. All rights reserved.
//

import UIKit
import Foundation

public class Rekognition {
    private static let sharedInstance = Rekognition()
    
    private static var ADD_URL="https://j1po3p7ys1.execute-api.ap-northeast-2.amazonaws.com/dev/face"
    private static var SEARCH_URL="https://j1po3p7ys1.execute-api.ap-northeast-2.amazonaws.com/dev/face/search"
    private static var LIST_URL="https://j1po3p7ys1.execute-api.ap-northeast-2.amazonaws.com/dev/face"
    private static var DELETE_URL="https://j1po3p7ys1.execute-api.ap-northeast-2.amazonaws.com/dev/face"
    private static var request = Request()
 
    fileprivate static func showProgress () {
        DispatchQueue.main.async {
            LoadingHUD.show()
        }
    }
    
    fileprivate static func hideProgress () {
        DispatchQueue.main.async {
            LoadingHUD.hide()
        }
    }
    
    class func add (image: NSData, name: String, callback: @escaping () -> Void) {
        showProgress()
        let body: NSMutableDictionary = NSMutableDictionary()
        body.setValue(image.base64EncodedString(options: NSData.Base64EncodingOptions.lineLength64Characters), forKey: "data")
        body.setValue(name, forKey: "id")
        
        do {
            try self.request.post(url: URL(string: ADD_URL)!, body: body, completionHandler: { data, response, error in
                hideProgress()
                callback()
            })
        } catch {
            print(error)
        }
    }
    
    class func search (image: UIImage, callback: @escaping (String) -> Void) {
        showProgress()
        let body: NSMutableDictionary = NSMutableDictionary()
        let imageData = image.jpegData(compressionQuality: 0.5)! as NSData
        body.setValue(imageData.base64EncodedString(options: NSData.Base64EncodingOptions.lineLength64Characters), forKey: "data")

        do {
            try self.request.post(url: URL(string: SEARCH_URL)!, body: body, completionHandler: { data, response, error in
                do {
                    let dict = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:Any]
                    self.hideProgress()
                    callback(dict["data"] as! String)
                } catch {
                    print(error)
                }
            })
        } catch {
            print(error)
        }
    }
    
    class func list (callback: @escaping ([Face]) -> Void) {
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
    
    class func delete (faceId: String, callback: @escaping () -> Void) {
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
