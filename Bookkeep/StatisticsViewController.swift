//
//  StatisticsViewController.swift
//  Bookkeep
//
//  Created by aa on 2020/9/11.
//  Copyright © 2020 Bookkeep. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var labelIcom: UILabel!
    @IBOutlet var labelExp: UILabel!
    @IBOutlet var labelTotal: UILabel!
    @IBOutlet var btnDate: UIButton!
    @IBOutlet var textDate: UITextField!
    
    @IBOutlet var btnNext: UIButton!
    @IBOutlet var btnPre: UIButton!
    var picker = UIPickerView()
    var tableStats = [statistics]()
    var dates = [String]()
    
    var year = Calendar.current.component(.year, from: Date())
    override func viewDidLoad() {
        
        creatDatePicker()
        
        btnDate.setTitle(String(year) + "年", for: .normal)
        
        let bkpinfos = bookkeepingInfo().bkpInfo(year: String(year))
        
        tableStats = CalMonBalance(bkpinfos: bkpinfos)
        
        let icom = CalValue(str: "收入", bkps: bkpinfos)
        labelIcom.text = "$" + String(icom)
        labelIcom.textColor = UIColor(hexFromString: "#498C51")
        
        let exp = CalValue(str: "支出", bkps: bkpinfos)
        labelExp.text = "$" + String(exp)
        labelExp.textColor = UIColor(hexFromString: "#FE545A")
        
        let total = icom - exp
        labelTotal.text = "$" + String(total)
        
        tableView.register(UINib.init(nibName: "StatistTaViewCell", bundle: nil),forCellReuseIdentifier:"StatistTaViewCell")
        tableView.tableFooterView = UIView()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        view.addGestureRecognizer(tap)
        
        let offset = CGSize.init(width: 0, height: 3)
        let showColor = UIColor.black.cgColor
        let showOpacitybtn2 :Float = 0.6
        let redius = CGFloat(10)
           
        btnPre.layer.shadowOffset = offset//默认为0,-3
        btnPre.layer.shadowColor = showColor
        btnPre.layer.shadowOpacity = showOpacitybtn2//阴影透明度，默认0
        btnPre.layer.cornerRadius = redius
        
        btnNext.layer.shadowOffset = offset//默认为0,-3
        btnNext.layer.shadowColor = showColor
        btnNext.layer.shadowOpacity = showOpacitybtn2//阴影透明度，默认0
        btnNext.layer.cornerRadius = redius
    }
    override func viewDidAppear(_ animated: Bool) {
        statusBar(color: UIColor(hexFromString: "#498C51"))
    }
    
    @IBAction func btnDate(_ sender: Any) {
        textDate.becomeFirstResponder()
    }
    @IBAction func btnPreYear(_ sender: Any) {
        let btnStr = btnDate.titleLabel?.text?.replace(target: "年", withString: "")
        let btnInt = Int(btnStr!)
        let preInt = btnInt! - 1
        btnDate.setTitle(String(preInt) + "年", for: .normal )
        
        var select = 0
        for date in dates{
            if date == String(preInt){ break }
            select = select + 1
        }
        picker.selectRow(select, inComponent: 0, animated: false)
        
        let bkpinfos = bookkeepingInfo().bkpInfo(year: String(preInt))
        tableStats = CalMonBalance(bkpinfos: bkpinfos)
        tableView.reloadData()
        
    }
    @IBAction func btnNextYear(_ sender: Any) {
        let btnStr = btnDate.titleLabel?.text?.replace(target: "年", withString: "")
        let btnInt = Int(btnStr!)
        let nextInt = btnInt! + 1
        btnDate.setTitle(String(nextInt) + "年", for: .normal )
        
        var select = 0
        for date in dates{
            if date == String(nextInt){ break }
            select = select + 1
        }
        picker.selectRow(select, inComponent: 0, animated: false)
        
        let bkpinfos = bookkeepingInfo().bkpInfo(year: String(nextInt))
        tableStats = CalMonBalance(bkpinfos: bkpinfos)
        tableView.reloadData()
    }
    
    func CalValue(str:String,bkps:[bookkeepingInfo]) -> Int{
        var count = 0
        for bkp in bkps{
            if bkp.type == str{
                count = count + Int(bkp.balanceSheet)!
            }
        }
        return count
    }
    func CalMonBalance(bkpinfos:[bookkeepingInfo]) -> [statistics]{
        var stats = [statistics]()
        for i in 1...12{
            var income = 0
            var exp = 0
            var balance = 0
            let stat = statistics()
            for bkp in bkpinfos{
                if bkp.month == String(i){
                    if bkp.type == "收入"{
                        income = income + Int(bkp.balanceSheet)!
                    }else{
                        exp = exp + Int(bkp.balanceSheet)!
                    }
                }
            }
            balance = income - exp
            stat.income = String(income)
            stat.expenditure = String(exp)
            stat.balance = String(balance)
            stats.append(stat)
        }
        return stats
    }
    func creatDatePicker() {
        let width = Int(self.view.bounds.size.width)
        
        picker.frame = CGRect(x: 0, y: 0, width: width, height: 210)
        
        picker.delegate = self
        picker.dataSource = self
        
        dates.removeAll()
        for i in year - 10...year + 30{
            dates.append(String(i))
        }
        
        var select = 0
        for date in dates{
            if date == String(year){ break }
            select = select + 1
        }
        picker.selectRow(select, inComponent: 0, animated: false)

        textDate.inputView = picker
    }
    
    @objc func closeKeyboard(){
        self.view.endEditing(true)
    }
}

extension StatisticsViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 30
        }else {
            return 44
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else{
            return tableStats.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "StatistTaViewCell", for: indexPath as IndexPath) as! StatistTaViewCell
        if indexPath.section == 0{
            cell.selectionStyle = .none
            if #available(iOS 13.0, *) {
                cell.backgroundColor = UIColor.systemGray5
            } else {
                // Fallback on earlier versions
            }
            
            let color = UIColor.darkGray
            cell.labelMon.textColor = color
            cell.labelIcom.textColor = color
            cell.labelExp.textColor = color
            cell.labelBalance.textColor = color
            
            cell.labelMon.text = "月份"
            
            cell.labelIcom.text = "收入"
            
            cell.labelExp.text = "支出"
            
            cell.labelBalance.text = "餘額"
        }
        
        if indexPath.section == 1{
            cell.backgroundColor = UIColor.white
            let color = UIColor.black
            cell.labelMon.textColor = color
            cell.labelIcom.textColor = color
            cell.labelExp.textColor = color
            cell.labelBalance.textColor = color
            
            cell.labelMon.text = String(indexPath.row + 1) + "月"
            
            cell.labelIcom.text = tableStats[indexPath.row].income
            
            cell.labelExp.text = tableStats[indexPath.row].expenditure
            
            cell.labelBalance.text = tableStats[indexPath.row].balance
        }
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        closeKeyboard()
    }
    
}

extension StatisticsViewController:UIPickerViewDelegate,UIPickerViewDataSource{
    //有幾個區塊
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
   
    //裡面有幾列
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return dates.count
    }
    
    //選擇到的那列要做的事
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       
        btnDate.setTitle(dates[row] + "年", for: .normal) 
    }
    
    //設定每列PickerView要顯示的內容
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dates[row]
    }
    
    
}

class statistics{
    var income = ""
    var expenditure = ""
    var balance = ""
}

