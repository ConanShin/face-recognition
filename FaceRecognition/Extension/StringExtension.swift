//
//  StringExtension.swift
//  FaceRecognition
//
//  Created by Conan Shin on 2020/03/08.
//  Copyright © 2020 Conan Shin. All rights reserved.
//

import UIKit

extension String{
    
    func regexCheck(regex: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: self, range: NSRange(self.startIndex..., in: self))
            let matchingString = results.map {
                String(self[Range($0.range, in: self)!])
            }.joined()
            print(self)
            print(matchingString)
            return self == matchingString
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return false
        }
    }
}
