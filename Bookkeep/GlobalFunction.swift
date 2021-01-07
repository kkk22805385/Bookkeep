//
//  GlobalFunction.swift
//  Bookkeep
//
//  Created by aa on 2020/9/29.
//  Copyright © 2020 Bookkeep. All rights reserved.
//

import Foundation
import UIKit

//MARK:取得資料庫路徑
func getDBPath() -> String {
    let appUrl = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    let dbPath = (appUrl.path as NSString).appendingPathComponent("account.db")
    
    return dbPath
}



func statusBar(color:UIColor){
    if #available(iOS 13.0, *) {
        let statusBar = UIView(frame: UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero)
        statusBar.backgroundColor = color
        statusBar.tag = 100
        UIApplication.shared.keyWindow?.addSubview(statusBar)

    } else {

        let statusBar = UIApplication.shared.value(forKeyPath:"statusBarWindow.statusBar") as? UIView
        statusBar?.backgroundColor = color

    }
    if color == UIColor.black{
        UIApplication.shared.statusBarStyle = .lightContent
    }else{
        if #available(iOS 13.0, *) {
            UIApplication.shared.statusBarStyle = .darkContent
        } else {
            UIApplication.shared.statusBarStyle = .default
        }
    }
}
func dateConvStr(_ date:Date, dateFormat:String = "yyyy-MM-dd HH:mm:ss") -> String {
    let formatter = DateFormatter()
    formatter.locale = Locale.init(identifier: "zh_TW")
    formatter.dateFormat = dateFormat
    let date = formatter.string(from: date)
    return date
}
