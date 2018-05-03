//
//  LXConstant.swift
//  LXJieMeng
//
//  Created by John LXThyme on 2017/4/17.
//  Copyright © 2017年 John LXThyme. All rights reserved.
//

import UIKit

enum UserDefaultsKey: String {
    case parentView = "UserDefaultsParentKey"
}

struct LXMengUI {
    static let bgColor = UIColor(fromHexString: "#e4ceb3")
}
/* com.jason.lxmeng
 4911de0c-295d-11e7-b16d-e435c87f069a    banner3
 464ee9ee-295d-11e7-b16d-e435c87f069a   banner2
 1b17c08d-295d-11e7-b16d-e435c87f069a   banner
 2461d779-295d-11e7-b16d-e435c87f069a 开屏
 3b7b755a-295d-11e7-b16d-e435c87f069a  插屏

 d3248b07-28d8-11e7-b16d-e435c87f069a appkey
 */
struct LXMengApi {
    static let appKey = "d3248b07-28d8-11e7-b16d-e435c87f069a"
    static let openScreen = "2461d779-295d-11e7-b16d-e435c87f069a"
    static let tpBanner = "1b17c08d-295d-11e7-b16d-e435c87f069a"
    static let spBanner = "464ee9ee-295d-11e7-b16d-e435c87f069a"
    static let dpBanner = "4911de0c-295d-11e7-b16d-e435c87f069a"
    static let interstital = "3b7b755a-295d-11e7-b16d-e435c87f069a"
}
