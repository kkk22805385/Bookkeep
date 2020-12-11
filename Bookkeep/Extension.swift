//
//  Extension.swift
//  Bookkeep
//
//  Created by aa on 2020/9/11.
//  Copyright © 2020 Bookkeep. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(hexFromString:String) {
        let alpha:CGFloat = 1.0
        var cString:String = hexFromString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        var rgbValue:UInt32 = 10066329 //color #999999 if string has wrong format

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) == 6) {
            Scanner(string: cString).scanHexInt32(&rgbValue)
        }
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}

extension String{
func replace(target: String, withString: String) -> String{
    return self.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
    }
}

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
