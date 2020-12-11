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
    var monIncome = 0
    var monExpenditure = 0
    var monTotal = 0
    var dayIncome = 0
    var dayExpenditure = 0
    var bkpInfos = [bookkeepingInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCell()
        
        days = changeDayOfWeek()
        
        var bkps = bookkeepingInfo().bkpInfo(year: String(year), month: String(month))
        takeMonbal(bkps:bkps)
        
        let date = String(year) + "年" + String(month) + "月"
        btnDate.setTitle(date , for: .normal)
        
        
        let day = Calendar.current.component(.day, from: Date())
        bkps = bookkeepingInfo().bkpInfo(year: String(year), month: String(month), day: String(day))
        takeDatebal(bkps: bkps)
        bkpInfos = bkps
        
        //accTaView.setEditing(true, animated: false)
    }

    override func viewDidAppear(_ animated: Bool) {
        statusBar(color: UIColor(hexFromString: "#498C51"))
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
        
        let bkps = bookkeepingInfo().bkpInfo(year: String(year), month: String(month))
        takeMonbal(bkps: bkps)
        accTaView.reloadData()
        //sender.inputView = inView
        
        
    }
    @IBAction func btnAddRecord(_ sender: Any) {
        var dateStr = ""
        for date in days{
            if date.cellState == "1"{
                dateStr = (btnDate.titleLabel?.text)! + date.date + "日"
            }
        }
                
        let view = AddRecordViewController(nibName: "AddRecordViewController", bundle: nil)
        view.delegate = self
        view.date = dateStr
        present(view, animated: true, completion: nil)
    }
    
    //MARK:轉換時間
    @objc func dueDateChanged(sender:UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .none
        
        year = Calendar.current.component(.year, from: sender.date)
        month = Calendar.current.component(.month, from: sender.date)
        
        let newDate = String(year) + "年" + String(month) + "月"
        btnDate.setTitle(newDate, for: .normal)
        
        days = changeDayOfWeek()
        let bkps = bookkeepingInfo().bkpInfo(year: String(year), month: String(month))
        takeMonbal(bkps:bkps)
        
        accTaView.reloadData()
        dateCoView.reloadData()
    }
    
    func setCell(){
        dateCoView.register(UINib.init(nibName: "DateCoViewCell", bundle: nil), forCellWithReuseIdentifier: "DateCoViewCell")
        dateBgView.backgroundColor = UIColor(hexFromString: "#498C51")
        // Do any additional setup after loading the view
        
        accTaView.register(UINib.init(nibName: "BOMTaViewCell", bundle: nil),forCellReuseIdentifier:"BOMTaViewCell")
        accTaView.register(UINib.init(nibName: "DetailedTaViewCell", bundle: nil),forCellReuseIdentifier:"DetailedTaViewCell")
        accTaView.register(UINib.init(nibName: "IncomeDetailTaViewCell", bundle: nil),forCellReuseIdentifier:"IncomeDetailTaViewCell")
        accTaView.tableFooterView = UIView()
        accTaView.separatorStyle = .none
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
        
        let bkps = bookkeepingInfo().bkpInfo(year: String(year), month: String(month), day: days[indexPath.row].date)
        takeDatebal(bkps: bkps)
        
        bkpInfos = bkps
        
        accTaView.reloadData()
        dateCoView.reloadData()
        closeKeyboard()
    }
}
extension MainViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 120
        }else if indexPath.section == 1{
            return 80
        }else{
            return 50
        }
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else if section == 1{
            return 1
        }else{
            return bkpInfos.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "BOMTaViewCell", for: indexPath as IndexPath) as! BOMTaViewCell
            
            cell.labelMonth.text = String(month) + "月結餘"
            cell.labelBal.text = "$" + String(monTotal)
            cell.labelIncome.text = "$" + String(monIncome)
            cell.labelExpenses.text = "$" + String(monExpenditure)
            
            if monTotal > 0 {
                cell.labelBal.textColor = UIColor(hexFromString: "#498C51")
            }else{
                cell.labelBal.textColor = UIColor(hexFromString: "#FE545A")
            }
            cell.labelIncome.textColor = UIColor(hexFromString: "#498C51")
            cell.labelExpenses.textColor = UIColor(hexFromString: "#FE545A")
            
            cell.selectionStyle = .none
            
            return cell
            
        }else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailedTaViewCell", for: indexPath as IndexPath) as! DetailedTaViewCell
            
            cell.labelDate.text = searchDay(days: days) + "日"
            cell.labelIcome.text = "$" + String(dayIncome)
            cell.labelExpenditure.text = "$" + String(dayExpenditure)
            
            cell.selectionStyle = .none
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "IncomeDetailTaViewCell", for: indexPath as IndexPath) as! IncomeDetailTaViewCell
            
            
            cell.labelBalance.text = "$" + bkpInfos[indexPath.row].balanceSheet
            cell.labelReMark.text = bkpInfos[indexPath.row].remark
            cell.labelTypeName.text = bkpInfos[indexPath.row].typeName
            
            if bkpInfos[indexPath.row].type == "支出" {
                cell.labelBalance.textColor = UIColor(hexFromString: "#FE545A")
            }else{
                cell.labelBalance.textColor = UIColor(hexFromString: "#498C51")
            }
                    
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2{
            let view = AddRecordViewController(nibName: "AddRecordViewController", bundle: nil)
            view.delegate = self
            view.bkpInfo = bkpInfos[indexPath.row]
            present(view, animated: true, completion: nil)
        }
        
        closeKeyboard()
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                let delSuc = bookkeepingInfo().bkpDelete(bkp: bkpInfos[indexPath.row])
                
                if delSuc{
                    title = "刪除成功"
                }else{
                    title = "刪除失敗"
                }
                let alertController = UIAlertController(title: title, message: "", preferredStyle: .alert)
                self.present(alertController, animated: true, completion: nil)
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) { [self] in
                        self.presentedViewController?.dismiss(animated: false, completion: nil)
                        var bkps = bookkeepingInfo().bkpInfo(year: String(self.year), month: String(self.month))
                        self.takeMonbal(bkps:bkps)
                    
                        bkps = bookkeepingInfo().bkpInfo(year: String(self.year), month: String(self.month),day: searchDay(days: days))
                        self.takeDatebal(bkps: bkps)
                            
                        bkpInfos = bkps
                    
                        self.accTaView.reloadData()
                }
            }
    }
    
}

extension MainViewController{
    
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
    
    func takeMonbal(bkps :[bookkeepingInfo]){
        monIncome = 0
        monExpenditure = 0
        monTotal = 0
        
        for arr in bkps{
            let bal = Int(arr.balanceSheet)!
            if  arr.type == "收入" {
                monIncome = monIncome + bal
            }else{
                monExpenditure = monExpenditure + bal
            }
        }
        monTotal = monIncome - monExpenditure
        
        accTaView.reloadData()
    }
    func takeDatebal(bkps :[bookkeepingInfo]){
        dayIncome = 0
        dayExpenditure = 0
        
        for arr in bkps{
            let bal = Int(arr.balanceSheet)!
            if  arr.type == "收入" {
                dayIncome = dayIncome + bal
            }else{
                dayExpenditure = dayExpenditure + bal
            }
        }
        
        accTaView.reloadData()
    }
    func searchDay(days:[dateCoCell]) -> String{
        for day in days{
            if day.cellState == "1"{
                return day.date
            }
        }
        return ""
    }
    
    @objc func closeKeyboard(){
        self.view.endEditing(true)
    }
}

extension MainViewController:reloadTableView{
    func reloadAcc() {
        var bkps = bookkeepingInfo().bkpInfo(year: String(self.year), month: String(self.month))
        self.takeMonbal(bkps:bkps)
    
        bkps = bookkeepingInfo().bkpInfo(year: String(self.year), month: String(self.month),day: searchDay(days: days))
        self.takeDatebal(bkps: bkps)
            
        bkpInfos = bkps
    
        self.accTaView.reloadData()
    }
}
