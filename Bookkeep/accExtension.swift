//
//  accExtension.swift
//  Bookkeep
//
//  Created by aa on 2020/9/29.
//  Copyright © 2020 Bookkeep. All rights reserved.
//

import Foundation

//MARK:FMResultSet
extension FMResultSet {
    func getString(forColumn: String) -> String {
        if let r = string(forColumn: forColumn) {
            return r
        }
        return ""
    }
    func getInt(forColumn: String) -> Int {
        let r = int(forColumn: forColumn)
        return Int(r)
    }
}
