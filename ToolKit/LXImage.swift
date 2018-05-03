//
//  LXImage.swift
//  MyGitHub
//
//  Created by John LXThyme on 2017/3/30.
//  Copyright © 2017年 John LXThyme. All rights reserved.
//

import UIKit

extension UIImage {
    class func image(with color: UIColor) ->UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)

        let theImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return theImage!
    }

    class func image(with image:UIImage, reSize:CGSize) ->UIImage {
        UIGraphicsBeginImageContext(reSize)
        image .draw(in: CGRect(origin: CGPoint.zero, size: reSize))

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
}
