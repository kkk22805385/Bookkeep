//
//  MainViewController.swift
//  Bookkeep
//
//  Created by aa on 2020/9/11.
//  Copyright © 2020 Bookkeep. All rights reserved.
//

import UIKit

class MainViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet var dateCoView: UICollectionView!
    @IBOutlet var accTaView: UITableView!
    @IBOutlet var dateBgView: UIView!
    @IBOutlet var btnDate: UIButton!
    @IBOutlet var textData: UITextField!
    
    
    var tabBarHeight :CGFloat = 0
    
    let week = ["週日","週一","週二","週三","週四","週五","週六"]
    var year = Calendar.current.component(.year, from: Date())
    var month = Calendar.current.component(.month, from: Date())
    
    var days = [dateCoCell]()
    var bkps = [bookkeepingInfo]()
    var income = 0
    var expenditure = 0
    var total = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        dateCoView.register(UINib.init(nibName: "DateCoViewCell", bundle: nil), forCellWithReuseIdentifier: "DateCoViewCell")
        dateBgView.backgroundColor = UIColor(hexFromString: "#498C51")
        // Do any additional setup after loading the view
        
        accTaView.register(UINib.init(nibName: "BOMTaViewCell", bundle: nil),forCellReuseIdentifier:"BOMTaViewCell")
        accTaView.register(UINib.init(nibName: "DetailedTaViewCell", bundle: nil),forCellReuseIdentifier:"DetailedTaViewCell")
        accTaView.tableFooterView = UIView()
        accTaView.separatorStyle = .none
        
        let date = String(year) + "年" + String(month) + "月"
        bkps = bookkeepingInfo().bkpInfo(year: String(year), month: String(month))
        btnDate.setTitle(date , for: .normal)
        days = changeDayOfWeek()
        takeValue()
    }
    @IBAction func btnDate(_ sender: UIButton) {
        let height = view.bounds.height - 230 - tabBarHeight
        let width = UIScreen.main.bounds.width
        let picker : UIDatePicker = UIDatePicker()
        let inView = UIView(frame: CGRect(x: 0, y: height, width: width, height: 230))
        
        picker.datePickerMode = .date
        
        picker.locale = NSLocale(localeIdentifier: "zh_TW") as Locale
        
        picker.addTarget(self, action: #selector(dueDateChanged(sender:)), for: UIControl.Event.valueChanged)
        
        picker.backgroundColor = UIColor(hexFromString: "#EBEBEB")
        picker.frame = CGRect(x:0.0, y:0.0 , width:inView.bounds.width, height:230)
        

        let dateMax = Calendar.current.date(byAdding: .year, value: 30, to: Date())
        let dateMin = Calendar.current.date(byAdding: .year, value: -10, to: Date())
        picker.minimumDate = dateMin
        picker.maximumDate = dateMax
        picker.preferredDatePickerStyle = .wheels
        
        textData.inputView = picker
        
        textData.becomeFirstResponder()
        
        //sender.inputView = inView
        
        
    }
    @objc func dueDateChanged(sender:UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .none
        
        year = Calendar.current.component(.year, from: sender.date)
        month = Calendar.current.component(.month, from: sender.date)
        
        let newDate = String(year) + "年" + String(month) + "月"
        btnDate.setTitle(newDate, for: .normal)
        
        days = changeDayOfWeek()
        bkps = bookkeepingInfo().bkpInfo(year: String(year), month: String(month))
        takeValue()
        
        accTaView.reloadData()
        dateCoView.reloadData()
    }
}
extension MainViewController :UICollectionViewDelegate,UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return week.count
        }else{
            return days.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DateCoViewCell", for: indexPath) as! DateCoViewCell
        if indexPath.section == 0{
            cell.labelDate.textColor = UIColor(hexFromString: "#498C51")
            cell.labelDate.text = week[indexPath.row]
            cell.bgView.backgroundColor = UIColor.clear
            cell.isUserInteractionEnabled = false
        }else{
            cell.bgView.backgroundColor = UIColor.clear
            cell.labelDate.textColor = UIColor.black
            cell.isUserInteractionEnabled = true
            
            cell.labelDate.text = days[indexPath.row].date
            if days[indexPath.row].cellState == "1" {
                cell.bgView.backgroundColor = UIColor(hexFromString: "#498C51")
                cell.labelDate.textColor = UIColor.white
            }
            
            if days[indexPath.row].noThisMonthDay == "1" {
                cell.labelDate.textColor = UIColor.lightGray
                cell.bgView.backgroundColor = UIColor.clear
                cell.isUserInteractionEnabled = false
            }
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        textData.resignFirstResponder()
        for data in days {
            data.cellState = "0"
        }
        days[indexPath.row].cellState = "1"
        
        accTaView.reloadData()
        dateCoView.reloadData()
    }
}
extension MainViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 140
        }else{
            return 50
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else{
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "BOMTaViewCell", for: indexPath as IndexPath) as! BOMTaViewCell
            
            cell.labelMonth.text = String(month) + "月結餘"
            
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailedTaViewCell", for: indexPath as IndexPath) as! DetailedTaViewCell
            
            return cell
        }
    }
    
    
}

extension MainViewController{
    func dateConvStr(_ date:Date, dateFormat:String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_TW")
        formatter.dateFormat = dateFormat
        let date = formatter.string(from: date)
        return date
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func changeDayOfWeek()->[dateCoCell]{
        var beforeMonth = 0
        if month - 1 <= 0{ beforeMonth = 12 } else { beforeMonth = month - 1 }
        let beforeCom = DateComponents(year:year ,month: beforeMonth)
        let beforeDay = Calendar.current.date(from: beforeCom)!
        let beforeCount = Calendar.current.range(of: .day, in: .month, for: beforeDay)!.count
        
        let com = DateComponents(year:year ,month: month)
        let day = Calendar.current.date(from: com)!
        let dayCount = Calendar.current.component(.weekday, from: day) - 1
        let toDayCount = Calendar.current.range(of: .day, in: .month, for: day)!.count
        
        let minRange = beforeCount - dayCount + 1
        
        var retDate = [dateCoCell]()
        if dayCount > 0 {
            for i in minRange...beforeCount {
                let date = dateCoCell()
                date.date = "\(i)"
                date.cellState = "0"
                date.noThisMonthDay = "1"
                retDate.append(date)
            }
        }
        
        
        let toDay = Calendar.current.component(.day, from: Date())
        for i in 1...toDayCount{
            let date = dateCoCell()
            date.date = "\(i)"
            date.cellState = "0"
            date.noThisMonthDay = "0"
            if i == toDay { date.cellState = "1" }
            retDate.append(date)
        }
        let maxRange = 42 - dayCount - toDayCount
        
        if maxRange > 0 {
            for i in 1...maxRange{
                let date = dateCoCell()
                date.date = "\(i)"
                date.cellState = "0"
                date.noThisMonthDay = "1"
                retDate.append(date)
            }
        }
        return retDate
    }
    func takeValue(){
        for arr in bkps{
            income = 0
            expenditure = 0
            total = 0
            let bal = Int(arr.balanceSheet)
            if  bal! > 0 {
                income = income + bal!
            }else{
                expenditure = expenditure + bal!
            }
        }
        total = income + expenditure
    }
}
