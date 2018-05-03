//
//  FMDBKit.swift
//  LXJieMeng
//
//  Created by John LXThyme on 2017/4/6.
//  Copyright © 2017年 John LXThyme. All rights reserved.
//

import UIKit
import FMDB

final class FMDBKit: NSObject {
    static let manager = FMDBKit()
    lazy var db: FMDatabase = {
        let array_t = dbFileName.components(separatedBy: ".")
        assert(true, "DB file format error!")
        let dbPath = Bundle.main.path(forResource: array_t.first, ofType: array_t.last)
        let db = FMDatabase(path: dbPath)!
        return db
    }()
    //prevent others from using the default '()' initializer for this class.
    private override init() {}
    class func openDB() ->Bool {
        let success = manager.db.open()
        assert(success, "open db failure!")
        return success
    }
    class func closeDB() {
        let success = manager.db.close()
        assert(success, "close db failure!")
//        return success
    }
    class func query(sqlString: String, params: [Any]!) ->FMResultSet {
        if !openDB() {
            return FMResultSet()
        }
        do {
            let rs = try manager.db.executeQuery(sqlString, values: params)
            return rs
        } catch {
            assert(true, "update error")
        }
        return FMResultSet()
    }
    class func update(sqlString: String, params: [Any]!) ->Bool {
        if !openDB() {
            return false
        }
        let success = manager.db.executeUpdate(sqlString, withArgumentsIn: params)
        return success
    }
}
