//
//  LXConf.swift
//  LXJieMeng
//
//  Created by John LXThyme on 2017/4/6.
//  Copyright © 2017年 John LXThyme. All rights reserved.
//

import Foundation

let dbFileName = "ssmeng.db"

typealias LXMengCategoryType = (id: Int32, categoryName: String)
typealias LXMengSecondCategoryType = (id: Int32, cateID: Int32, mengName: String)
typealias LXMengInfoType = (id: Int32, mengID: Int32, mengName: String)


let kMengTopCategoryNameUserDefaultsKey = "kMengTopCategoryNameUserDefaultsKey"
let kMengSecondryCategoryNameUserDefaultsKey = "kMengSecondryCategoryNameUserDefaultsKey"


