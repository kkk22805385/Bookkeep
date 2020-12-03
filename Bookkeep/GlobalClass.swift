//
//  globalClass.swift
//  Bookkeep
//
//  Created by aa on 2020/9/28.
//  Copyright © 2020 Bookkeep. All rights reserved.
//

import Foundation

@objcMembers class dateCoCell : NSObject{
    var date = ""
    var cellState = ""
    var noThisMonthDay = ""
    
}

@objcMembers class accountVar : NSObject {
    var tag = ""
    var key = ""
    var value = ""
    
    func searchDB() -> Array<accountVar> {
        var accVars = [accountVar]()
        if let db = accountDB {
            if let rs = db.executeQuery("SELECT * FROM BookManage ", withArgumentsIn: [Any]()) {
                while rs.next() {
                    let accVar = accountVar()
                    accVar.tag = rs.getString(forColumn: "tag")
                    accVar.key = rs.getString(forColumn: "key")
                    accVar.value = rs.getString(forColumn: "value")
                    accVars.append(accVar)
                }
                rs.close()
            }
        }
        return accVars
    }
    func getDBVal(key:String) -> String{
        for data in GlobalValues.accVars{
            if data.key == key{
                return data.value
            }
        }
        return ""
    }
}

@objcMembers class bookkeepingInfo : NSObject{
    var year = ""
    var month = ""
    var day = ""
    var week = ""
    var type = ""
    var balanceSheet = ""
    var remark = ""
    
    func bkpInfo(year:String,month:String) -> [bookkeepingInfo]{
        var bkps = [bookkeepingInfo]()
        if let db = accountDB {
            var arg = [Any]()
            arg.append(year)
            arg.append(month)
            if let rs = db.executeQuery("SELECT * FROM BKPInfo WHERE year = ? and month = ? ", withArgumentsIn:arg ) {
                while rs.next() {
                    let bkp = bookkeepingInfo()
                    bkp.year = rs.getString(forColumn: "balanceSheet")
                    bkp.month = rs.getString(forColumn: "balanceSheet")
                    bkp.day = rs.getString(forColumn: "balanceSheet")
                    bkp.week = rs.getString(forColumn: "balanceSheet")
                    bkp.balanceSheet = rs.getString(forColumn: "balanceSheet")
                    bkp.remark = rs.getString(forColumn: "balanceSheet")
                    bkp.balanceSheet = rs.getString(forColumn: "balanceSheet")
                    
                    bkps.append(bkp)
                }
                rs.close()
            }
        }
        return bkps
    }
}

@objcMembers class typeInfo : NSObject{
    var type = ""
    var name = ""
    
    func searchTypeDB(str:String) -> [typeInfo]{
        var types = [typeInfo]()
        
        var condictionDB = ""
        if str == ""{
            condictionDB = "SELECT * FROM typeInfo"
        }else{
            condictionDB = "SELECT * FROM typeInfo WHERE type = '\(str)'"
        }
        
        if let db = accountDB {
            if let rs = db.executeQuery( condictionDB , withArgumentsIn:[Any]() ) {
                while rs.next() {
                    let type = typeInfo()
                    type.type = rs.getString(forColumn: "type")
                    type.name = rs.getString(forColumn: "name")
                    
                    types.append(type)
                }
                rs.close()
            }
        }
        return types
    }
}


