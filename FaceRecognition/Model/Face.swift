//
//  Face.swift
//  FaceRecognition
//
//  Created by Conan Shin on 2020/02/29.
//  Copyright © 2020 Conan Shin. All rights reserved.
//

import Foundation

class Face {
    var faceId: String
    var name: String
    
    init (faceId: String, name: String){
        self.faceId = faceId
        self.name = name
    }
}
