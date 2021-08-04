//
//  CoffeeDetailViewController.swift
//  Bookkeep
//
//  Created by aa on 2021/7/30.
//  Copyright © 2021 Bookkeep. All rights reserved.
//

import UIKit

class CoffeeDetailViewController: UIViewController {

    @IBOutlet var labelCoffeeName: UILabel!
    var coffeeData :CoffeeData?
    @IBOutlet var dataTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataTable.register(UINib.init(nibName: "ScoreCell", bundle: nil),forCellReuseIdentifier:"ScoreCell")
        dataTable.register(UINib.init(nibName: "DataCell", bundle: nil),forCellReuseIdentifier:"DataCell")

        
        labelCoffeeName.text = coffeeData?.name
        // Do any additional setup after loading the view.
    }
}

extension CoffeeDetailViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DataCell", for: indexPath as IndexPath) as! DataCell
            
            cell.labelLeft.text = "地址"
            cell.labelRight.text = coffeeData?.address
                        
            cell.selectionStyle = .none
            
            return cell
        }
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DataCell", for: indexPath as IndexPath) as! DataCell
            
            cell.labelLeft.text = "營業時間"
            cell.labelRight.text = coffeeData?.open_time
            
            cell.selectionStyle = .none
            
            return cell
        }

        else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreCell", for: indexPath as IndexPath) as! ScoreCell
            
            cell.labelLeft.text = "wifi穩定"
                        
            cell.labelRight.text = String(Int(coffeeData!.wifi))
            
            cell.selectionStyle = .none
            
            return cell
        }

        else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreCell", for: indexPath as IndexPath) as! ScoreCell
            
            cell.labelLeft.text = "通常有位"
            cell.labelRight.text = String(Int(coffeeData!.seat))
            
            return cell
        }

        else if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreCell", for: indexPath as IndexPath) as! ScoreCell
            
            cell.labelLeft.text = "安靜程度"
            cell.labelRight.text = String(Int(coffeeData!.quiet))
            
            cell.selectionStyle = .none
            
            return cell
        }

        else if indexPath.row == 5 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreCell", for: indexPath as IndexPath) as! ScoreCell
            
            cell.labelLeft.text = "咖啡好喝"
            cell.labelRight.text = String(Int(coffeeData!.tasty))
            
            cell.selectionStyle = .none
            
            return cell
        }
        
        else if indexPath.row == 6 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreCell", for: indexPath as IndexPath) as! ScoreCell
            
            cell.labelLeft.text = "價格"
            cell.labelRight.text = String(Int(coffeeData!.cheap))
            
            return cell
        }

        else if indexPath.row == 7 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreCell", for: indexPath as IndexPath) as! ScoreCell
            
            cell.labelLeft.text = "裝潢音樂"
            cell.labelRight.text = String(Int(coffeeData!.music))
            
            return cell
        }
        
        else if indexPath.row == 8 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DataCell", for: indexPath as IndexPath) as! DataCell
            
            cell.labelLeft.text = "網址"
            cell.labelRight.text = coffeeData?.url
            
            cell.labelRight.textColor = .blue
            let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
            let underlineAttributedString = NSAttributedString(string: "StringWithUnderLine", attributes: underlineAttribute)
            cell.labelRight.attributedText = underlineAttributedString
            cell.selectionStyle = .none
            
            return cell
        }
        else if indexPath.row == 9 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DataCell", for: indexPath as IndexPath) as! DataCell
            
            cell.labelLeft.text = "有無限時"
            cell.labelRight.text = change(str: coffeeData!.limited_time)
            
            return cell
        }
        else  if indexPath.row == 10 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DataCell", for: indexPath as IndexPath) as! DataCell
            
            cell.labelLeft.text = "插座充足"
            cell.labelRight.text = change(str: coffeeData!.socket)
            
            cell.selectionStyle = .none
            
            return cell
        }
        else if indexPath.row == 11 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DataCell", for: indexPath as IndexPath) as! DataCell
            
            cell.labelLeft.text = "可站立工作"
            cell.labelRight.text = change(str: coffeeData!.standing_desk)
            
            cell.selectionStyle = .none
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DataCell", for: indexPath as IndexPath) as! DataCell
            
            cell.labelLeft.text = "捷運站"
            cell.labelRight.text = coffeeData?.mrt
            
            cell.selectionStyle = .none
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 8{
            openUrl(urlString: coffeeData?.url)
        }
    }
}

extension CoffeeDetailViewController{
    func change(str:String) -> String{
        if str == "maybe"{
            return "可能"
        }else if str == "yes"{
            return "有"
        }else{
            return "無"
        }
    }
    
    func openUrl(urlString:String!) {
        let url = URL(string: urlString)!
        if #available(iOS 10.0, *) {
         UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
         UIApplication.shared.openURL(url)
        }
    }
}
