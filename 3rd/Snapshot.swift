//
//  Snapshot.swift
//  LXJieMeng
//
//  Created by John LXThyme on 2017/5/25.
//  Copyright © 2017年 John LXThyme. All rights reserved.
//
import UIKit
import Foundation

extension UIView {

    /// 截取 UIView 的内容, 以位图的形式（bitmap）保存到UIImage
    ///
    /// - Returns: 截图 Snapshot Image
    func snapshot(opaque:Bool = true, scale: CGFloat = 0) ->UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, opaque, scale)
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        let snapshotImg = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return snapshotImg
    }
}
