//
//  GlobalValues.swift
//  Bookkeep
//
//  Created by aa on 2020/9/29.
//  Copyright © 2020 Bookkeep. All rights reserved.
//

import Foundation

var accountDB : FMDatabase?
var accountDBqueue: FMDatabaseQueue?

struct GlobalValues{
    
    static var appVersion = ""
    static var appBuild = ""
    
    static var dbPath = ""
    
    static var macAddress = ""
    
    static var colorType = "light"
    
    static var accVars = [accountVar]()
}
