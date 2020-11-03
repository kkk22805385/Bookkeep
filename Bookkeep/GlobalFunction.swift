//
//  GlobalFunction.swift
//  Bookkeep
//
//  Created by aa on 2020/9/29.
//  Copyright © 2020 Bookkeep. All rights reserved.
//

import Foundation

//MARK:取得資料庫路徑
func getDBPath() -> String {
    let appUrl = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    let dbPath = (appUrl.path as NSString).appendingPathComponent("account.db")
    
    return dbPath
}
