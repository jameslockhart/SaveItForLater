//
//  Resize.swift
//  SaveItForLater
//
//  Created by Jamie Lockhart on 2017-01-20.
//  Copyright © 2017 iLockhart. All rights reserved.
//

import Foundation
import UIKit

class Resize: NSObject {
    
    //http://stackoverflow.com/questions/31966885/ios-swift-resize-image-to-200x200pt-px (swift_dan)
    static func resizeImage(image: UIImage, newWidth: CGFloat, newHeight: CGFloat) -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}
