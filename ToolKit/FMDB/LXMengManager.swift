
//
//  LXJieMengManager.swift
//  LXJieMeng
//
//  Created by John LXThyme on 2017/4/6.
//  Copyright © 2017年 John LXThyme. All rights reserved.
//

import UIKit

class LXMengManager: NSObject {
    class func queryTopCategory() ->[LXMengCategoryType] {
        let sqlString = "SELECT * FROM \"meng_category\";"
        let rs = FMDBKit.query(sqlString: sqlString, params: nil)
        var categoryList = [LXMengCategoryType]()
        while rs.next() {
            let id = rs.int(forColumn: "ID")
            let categoryName = rs.string(forColumn: "CategoryName")!
            let item = LXMengCategoryType(id, categoryName)
            categoryList.append(item)
        }
        FMDBKit.closeDB()
        return categoryList
    }
    class func querySecondCategory(cateID: Int32) ->[LXMengSecondCategoryType] {
//        SELECT * FROM meng WHERE CateID =  '1';
        var sqlString = "SELECT * FROM \"meng\""
        if cateID > 0 {
            sqlString += " where CateID = \"\(cateID)\"";
        }
        let rs = FMDBKit.query(sqlString: sqlString, params: nil)
        var categoryList = [LXMengSecondCategoryType]()
        while rs.next() {
            let id = rs.int(forColumn: "ID")
            let cateID = rs.int(forColumn: "CateID")
            let name = rs.string(forColumn: "MengName")!
            let item = LXMengSecondCategoryType(id, cateID, name)
            categoryList.append(item)
        }
        FMDBKit.closeDB()
        return categoryList.sorted(by: {$0.mengName > $1.mengName})
    }
    class func queryMengInfo(id: Int32) ->[LXMengInfoType] {
        let sqlString = "SELECT * FROM \"meng_jiemeng\" WHERE MengID = \"\(id)\";"
        let rs = FMDBKit.query(sqlString: sqlString, params: nil)
        var categoryList = [LXMengInfoType]()
        while rs.next() {
            let id = rs.int(forColumn: "ID")
            let mengID = rs.int(forColumn: "MengID")
            let jieMeng = rs.string(forColumn: "JieMeng")!
            let item = LXMengInfoType(id, mengID, jieMeng)
            categoryList.append(item)
        }
        FMDBKit.closeDB()
        return categoryList
    }
}
