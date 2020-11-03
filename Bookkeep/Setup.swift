//
//  Setup.swift
//  Bookkeep
//
//  Created by aa on 2020/9/29.
//  Copyright © 2020 Bookkeep. All rights reserved.
//

import Foundation
import UIKit


class Setup {
    
    func initVar(){
        var isNew = true
        
        if let retrieveedString = KeychainWrapper.standard.string(forKey: "account"){
            GlobalValues.macAddress = retrieveedString
        }else{
            print("new uuid")
            GlobalValues.macAddress = (UIDevice.current.identifierForVendor?.uuidString)!
            let saveSuccessful : Bool = KeychainWrapper.standard.set(GlobalValues.macAddress, forKey: "account")
            if !saveSuccessful {
                print("save key fail")
            }
        }
        
        GlobalValues.accVars = accountVar().searchDB()
        
        let version =  accountVar().getDBVal(key: "DBVersion")
        if  version != "" { isNew = false }
    
        sycVersion()
        
        if isNew{
            
        }
    }
    
    var versionUpdates = ["1.0.0"]
    func sycVersion() {
        var ver = "1.0.0" // 資料庫版本
        let dbVersion = accountVar().getDBVal(key: "DBVersion")
        if  dbVersion != "" { ver = dbVersion }
        
        if ver <= GlobalValues.appVersion {
            for v in versionUpdates {
                if v >= ver {
                    dbUgrade(toVersion: v)
                }
            }
        }
        var emptyDBVersion = true
        var emptyAppBuildVersion = true
        let accVar = accountVar()
        for arr in GlobalValues.accVars{
            if arr.key == "DBVersion" {
                emptyDBVersion = false
                arr.value = GlobalValues.appVersion
                
                accVar.key = "DBVersion"
                accVar.value = arr.value
                GlobalValues.accVars.append(accVar)
                updatedbValues(valueClass:accVar)
            }
            if arr.key == "AppBuildVersion"{
                emptyAppBuildVersion = false
                arr.value = GlobalValues.appBuild
                
                accVar.key = "AppBuildVersion"
                accVar.value = arr.value
                GlobalValues.accVars.append(accVar)
                updatedbValues(valueClass:accVar)
            }
        }
        if emptyDBVersion{
            
            accVar.key = "DBVersion"
            accVar.value = GlobalValues.appVersion
            GlobalValues.accVars.append(accVar)
            updatedbValues(valueClass:accVar)
        }
        if emptyAppBuildVersion{
            
            accVar.key = "AppBuildVersion"
            accVar.value = GlobalValues.appBuild
            GlobalValues.accVars.append(accVar)
            updatedbValues(valueClass:accVar)
        }
    }
}

//MARK:上面func會呼叫的func
extension Setup{
    func dbUgrade(toVersion:String) {
        if let db = accountDB {
            var sql = ""
            switch toVersion {
                default :
                    break
            }
        }
    }
    func updatedbValues(valueClass:accountVar){
        if let db = accountDB {
            db.beginTransaction()
            var arg = [Any]()
            arg.append(valueClass.tag)
            arg.append(valueClass.key)
            db.executeUpdate("Delete from BookManage where tag = ? and key = ?", withArgumentsIn: arg)
            if db.hadError() {
                print(db.lastError())
            }
            arg.removeAll()
            arg.append(valueClass.tag)
            arg.append(valueClass.key)
            arg.append(valueClass.value)
            db.executeUpdate("INSERT INTO BookManage (tag,key,value) VALUES (?,?,?)", withArgumentsIn: arg)
        db.commit()
        }
    }
    func ckeckdb() -> Bool{
        if let db = accountDB {
            if let rs = db.executeQuery("SELECT * FROM BookManage ", withArgumentsIn: [Any]()) {
                while rs.next() {
                    if rs.getString(forColumn: "key") != ""{
                        return true
                    }
                }
                rs.close()
            }
        }
        return false
    }
}
