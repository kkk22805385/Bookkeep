//
//  GlobalValues.swift
//  Bookkeep
//
//  Created by aa on 2020/9/29.
//  Copyright © 2020 Bookkeep. All rights reserved.
//

import Foundation
import UIKit

var accountDB : FMDatabase?
var accountDBqueue: FMDatabaseQueue?

struct GlobalValues{
    
    static var appVersion = ""
    static var appBuild = ""
    
    static var dbPath = ""
    
    static var macAddress = ""
    
    static var colorType = "light"
    
    static var accVars = [accountVar]()
    
    let arrayCountry = ["全台","基隆","台北","桃園","新竹","苗栗","台中","彰化","南投","雲林", "嘉義" ,"台南","高雄" ,"屏東" ,"宜蘭"  ,"花蓮" ,"台東","澎湖", "媽祖"]
}


