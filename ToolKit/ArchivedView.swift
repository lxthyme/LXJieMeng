//
//  ArchivedView.swift
//  LXJieMeng
//
//  Created by John LXThyme on 2017/4/17.
//  Copyright © 2017年 John LXThyme. All rights reserved.
//

import Foundation
extension UIView {
    func copyView<T: UIView>() -> T {
        return NSKeyedUnarchiver.unarchiveObject(with: NSKeyedArchiver.archivedData(withRootObject: self)) as! T
    }
}
