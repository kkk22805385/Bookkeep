//
//  AddRecordViewController.swift
//  Bookkeep
//
//  Created by aa on 2020/11/4.
//  Copyright © 2020 Bookkeep. All rights reserved.
//

import UIKit

class AddRecordViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet var textMoney: UITextField!
    @IBOutlet var textDate: UITextField!
    @IBOutlet var textType: UITextField!
    @IBOutlet var textRemark: UITextView!
    @IBOutlet var textPay: UITextField!
    
    var picker = UIPickerView()
    var typeDate = [typeInfo]()
    
    var Operator = ""
    var MoneyOri = ""
    
    var MoneyOp = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        textRemark.layer.borderWidth = 1
        textRemark.layer.borderColor = UIColor.black.cgColor
        
        textMoney.delegate = self
        textMoney.inputView = calView
        
        textType.delegate = self
        textType.inputView = typeView
        
        typeDate = typeInfo().searchTypeDB(str: "支出")
        picker.selectRow(typeDate.count / 2, inComponent: 0, animated: false)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        view.addGestureRecognizer(tap)
        
        textType.text = typeDate[typeDate.count / 2].name + "(支出)"
        // Do any additional setup after loading the view.
    }
   
    override func viewWillAppear(_ animated: Bool) {
        statusBar(color: UIColor.black)
    }
    override func viewWillDisappear(_ animated: Bool) {
        statusBar(color: UIColor(hexFromString: "#498C51"))
    }
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnSave(_ sender: Any) {
        
    }
    
    @objc func btnCalView(_ sender: UIButton) {
        
        switch sender.tag{
            //AC
            case 1:
                Operator = ""  //驗算方式
                MoneyOri = ""  //原始金額
                MoneyOp = ""   //驗算金額
                textMoney.text = MoneyOri
                break
            //mul
            case 2:
                Calculation(str: "mul")
                break
            //div
            case 3:
                Calculation(str: "div")
                break
            //del
            case 4:
                if Operator == ""{
                    MoneyOri = String(MoneyOri.dropLast())
                }else{
                    MoneyOp = String(MoneyOp.dropLast())
                }
                if Operator == ""{
                    textMoney.text = MoneyOri
                }else{
                    textMoney.text = MoneyOp
                }
                break
            //add
            case 5:
                Calculation(str: "add")
                break
            //less
            case 6:
                Calculation(str: "less")
                break
            //equ
            case 7:
                if Operator != "" {
                    Calculation(str: "equ")
                }
                break
            default:
                if Operator == ""{
                    MoneyOri = MoneyOri + (sender.titleLabel?.text)!
                }else{
                    MoneyOp = MoneyOp + (sender.titleLabel?.text)!
                }
                print("MoneyOri:",MoneyOri,"MoneyOp:",MoneyOp)
                
                if Operator == ""{
                    textMoney.text = MoneyOri
                }else{
                    textMoney.text = MoneyOp
                }
                break
            }
    }
    func Calculation(str:String){
        var numOri = 0
        var numOp = 0
        if MoneyOri == "" {numOri = 0} else { numOri = Int(MoneyOri)!}
        if MoneyOp == "" {numOp = 0} else { numOp = Int(MoneyOp)!}
        
        if Operator == "" { Operator = str }
        else{
            if numOp != 0{
                switch Operator {
                case "mul":
                    MoneyOri = String(numOri * numOp)
                    break
                case "div":
                    MoneyOri = String(numOri / numOp)
                    break
                case "add":
                    MoneyOri = String(numOri + numOp)
                    break
                case "less":
                    MoneyOri = String(numOri - numOp)
                    break
                default:
                    break
                }
            }
            textMoney.text = MoneyOri
            MoneyOp = ""
            if str != "equ" { Operator = str }
            
        }
        
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
            UIApplication.shared.statusBarStyle = .darkContent
        }
    }
    
    @objc func dismissKeyBoard(){
        self.view.endEditing(true)
    }
    
    @objc func closeKeyboard(){
        self.view.endEditing(true)
    }
}

//textfield inptView
extension AddRecordViewController{
    var calView: UIView {
        var width = Int(self.view.bounds.size.width)
        var height = 220
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width:width , height: height + 20))
        view.backgroundColor = UIColor.clear
        
        let rightWidth = width - Int(width*3/4)
        width = Int(width / 4)
        height = height / 5
        
        let topText = UIColor.white
        let topBG = UIColor.init(hexFromString: "#82B38A")
        let topTextHight = UIColor.init(hexFromString: "#8091BF")
        
        let rightText = UIColor.white
        let rightBG = UIColor.orange
        
        let othText = UIColor.black
        let othBg = UIColor.init(hexFromString: "#F5F5F5")
        
        let borColor = UIColor.darkGray.cgColor
        
        let btnAC = UIButton.init(frame: CGRect(x: 0, y: 0, width: width, height: height))
        btnAC.setTitle("AC", for: .normal)
        btnAC.setTitleColor(topText, for: .normal)
        btnAC.setTitleColor(topTextHight, for: .highlighted)
        btnAC.backgroundColor = topBG
        btnAC.layer.borderWidth = 1
        btnAC.layer.borderColor = borColor
        btnAC.tag = 1
        btnAC.addTarget(self,action: #selector(btnCalView(_:)),for: .touchUpInside)
        view.addSubview(btnAC)
        
        let btnMult = UIButton.init(frame: CGRect(x: width, y: 0, width: width, height: height))
        btnMult.setImage(UIImage(systemName: "multiply"), for: .normal)
        btnMult.tintColor = topText
        btnMult.backgroundColor = topBG
        btnMult.layer.borderWidth = 1
        btnMult.layer.borderColor = borColor
        btnMult.tag = 2
        btnMult.addTarget(self,action: #selector(btnCalView(_:)),for: .touchUpInside)
        view.addSubview(btnMult)
        
        let btnDiv = UIButton.init(frame: CGRect(x: width*2, y: 0, width: width, height: height))
        btnDiv.setImage(UIImage(systemName: "divide"), for: .normal)
        btnDiv.tintColor = topText
        btnDiv.backgroundColor = topBG
        btnDiv.layer.borderWidth = 1
        btnDiv.layer.borderColor = borColor
        btnDiv.tag = 3
        btnDiv.addTarget(self,action: #selector(btnCalView(_:)),for: .touchUpInside)
        view.addSubview(btnDiv)
        
        let btnDel = UIButton.init(frame: CGRect(x: width*3, y: 0, width: rightWidth, height: height))
        btnDel.setImage(UIImage(systemName: "delete.left.fill"), for: .normal)
        btnDel.tintColor = rightText
        btnDel.backgroundColor = rightBG
        btnDel.layer.borderWidth = 1
        btnDel.layer.borderColor = borColor
        btnDel.tag = 4
        btnDel.addTarget(self,action: #selector(btnCalView(_:)),for: .touchUpInside)
        view.addSubview(btnDel)
        
        let btn7 = UIButton.init(frame: CGRect(x: 0, y: height, width: width, height: height))
        btn7.setTitle("7", for: .normal)
        btn7.setTitleColor(othText,for: .normal)
        btn7.backgroundColor = othBg
        btn7.layer.borderWidth = 1
        btn7.layer.borderColor = borColor
        btn7.addTarget(self,action: #selector(btnCalView(_:)),for: .touchUpInside)
        view.addSubview(btn7)
        
        let btn8 = UIButton.init(frame: CGRect(x: width, y: height, width: width, height: height))
        btn8.setTitle("8", for: .normal)
        btn8.setTitleColor(othText,for: .normal)
        btn8.backgroundColor = othBg
        btn8.layer.borderWidth = 1
        btn8.layer.borderColor = borColor
        btn8.addTarget(self,action: #selector(btnCalView(_:)),for: .touchUpInside)
        view.addSubview(btn8)
        
        let btn9 = UIButton.init(frame: CGRect(x: width*2, y: height, width: width, height: height))
        btn9.setTitle("9", for: .normal)
        btn9.setTitleColor(othText,for: .normal)
        btn9.backgroundColor = othBg
        btn9.layer.borderWidth = 1
        btn9.layer.borderColor = borColor
        btn9.addTarget(self,action: #selector(btnCalView(_:)),for: .touchUpInside)
        view.addSubview(btn9)
        
        let btnAdd = UIButton.init(frame: CGRect(x: width*3, y: height, width: rightWidth, height: height))
        btnAdd.setImage(UIImage(systemName: "plus"), for: .normal)
        btnAdd.tintColor = rightText
        btnAdd.backgroundColor = rightBG
        btnAdd.layer.borderWidth = 1
        btnAdd.layer.borderColor = borColor
        btnAdd.tag = 5
        btnAdd.addTarget(self,action: #selector(btnCalView(_:)),for: .touchUpInside)
        view.addSubview(btnAdd)
        
        let btn4 = UIButton.init(frame: CGRect(x: 0, y: height*2, width: width, height: height))
        btn4.setTitle("4", for: .normal)
        btn4.setTitleColor(othText,for: .normal)
        btn4.backgroundColor = othBg
        btn4.layer.borderWidth = 1
        btn4.layer.borderColor = borColor
        btn4.addTarget(self,action: #selector(btnCalView(_:)),for: .touchUpInside)
        view.addSubview(btn4)
        
        let btn5 = UIButton.init(frame: CGRect(x: width, y: height*2, width: width, height: height))
        btn5.setTitle("5", for: .normal)
        btn5.setTitleColor(othText,for: .normal)
        btn5.backgroundColor = othBg
        btn5.layer.borderWidth = 1
        btn5.layer.borderColor = borColor
        btn5.addTarget(self,action: #selector(btnCalView(_:)),for: .touchUpInside)
        view.addSubview(btn5)
        
        let btn6 = UIButton.init(frame: CGRect(x: width*2, y: height*2, width: width, height: height))
        btn6.setTitle("6", for: .normal)
        btn6.setTitleColor(othText,for: .normal)
        btn6.backgroundColor = othBg
        btn6.layer.borderWidth = 1
        btn6.layer.borderColor = borColor
        btn6.addTarget(self,action: #selector(btnCalView(_:)),for: .touchUpInside)
        view.addSubview(btn6)
        
        let btnLess = UIButton.init(frame: CGRect(x: width*3, y: height*2, width: rightWidth, height: height))
        btnLess.setImage(UIImage(systemName: "minus"), for: .normal)
        btnLess.tintColor = rightText
        btnLess.backgroundColor = rightBG
        btnLess.layer.borderWidth = 1
        btnLess.layer.borderColor = borColor
        btnLess.tag = 6
        btnLess.addTarget(self,action: #selector(btnCalView(_:)),for: .touchUpInside)
        view.addSubview(btnLess)
        
        let btn1 = UIButton.init(frame: CGRect(x: 0, y: height*3, width: width, height: height))
        btn1.setTitle("1", for: .normal)
        btn1.setTitleColor(othText,for: .normal)
        btn1.backgroundColor = othBg
        btn1.layer.borderWidth = 1
        btn1.layer.borderColor = borColor
        btn1.addTarget(self,action: #selector(btnCalView(_:)),for: .touchUpInside)
        view.addSubview(btn1)
        
        let btn2 = UIButton.init(frame: CGRect(x: width, y: height*3, width: width, height: height))
        btn2.setTitle("2", for: .normal)
        btn2.setTitleColor(othText,for: .normal)
        btn2.backgroundColor = othBg
        btn2.layer.borderWidth = 1
        btn2.layer.borderColor = borColor
        btn2.addTarget(self,action: #selector(btnCalView(_:)),for: .touchUpInside)
        view.addSubview(btn2)
        
        let btn3 = UIButton.init(frame: CGRect(x: width*2, y: height*3, width: width, height: height))
        btn3.setTitle("3", for: .normal)
        btn3.setTitleColor(othText,for: .normal)
        btn3.backgroundColor = othBg
        btn3.layer.borderWidth = 1
        btn3.layer.borderColor = borColor
        btn3.addTarget(self,action: #selector(btnCalView(_:)),for: .touchUpInside)
        view.addSubview(btn3)
        
        let btnEqu = UIButton.init(frame: CGRect(x: width*3, y: height*3, width: rightWidth, height: height*2))
        btnEqu.setImage(UIImage(systemName: "equal"), for: .normal)
        btnEqu.tintColor = rightText
        btnEqu.backgroundColor = rightBG
        btnEqu.layer.borderWidth = 1
        btnEqu.layer.borderColor = borColor
        btnEqu.tag = 7
        btnEqu.addTarget(self,action: #selector(btnCalView(_:)),for: .touchUpInside)
        view.addSubview(btnEqu)
        
        let btn0 = UIButton.init(frame: CGRect(x: 0, y: height*4, width: width, height: height))
        btn0.setTitle("0", for: .normal)
        btn0.setTitleColor(othText,for: .normal)
        btn0.backgroundColor = othBg
        btn0.layer.borderWidth = 1
        btn0.layer.borderColor = borColor
        btn0.addTarget(self,action: #selector(btnCalView(_:)),for: .touchUpInside)
        view.addSubview(btn0)
        
        let btn00 = UIButton.init(frame: CGRect(x: width, y: height*4, width: width, height: height))
        btn00.setTitle("00", for: .normal)
        btn00.setTitleColor(othText,for: .normal)
        btn00.backgroundColor = othBg
        btn00.layer.borderWidth = 1
        btn00.layer.borderColor = borColor
        btn00.addTarget(self,action: #selector(btnCalView(_:)),for: .touchUpInside)
        view.addSubview(btn00)
        
        let btnpoint = UIButton.init(frame: CGRect(x: width*2, y: height*4, width: width, height: height))
        btnpoint.setTitle("000", for: .normal)
        btnpoint.setTitleColor(othText,for: .normal)
        btnpoint.backgroundColor = othBg
        btnpoint.layer.borderWidth = 1
        btnpoint.layer.borderColor = borColor
        btnpoint.addTarget(self,action: #selector(btnCalView(_:)),for: .touchUpInside)
        view.addSubview(btnpoint)
        return view
    }
    
    var typeView:UIView{
        let width = Int(self.view.bounds.size.width)
        let height = 210
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width:width , height: height ))
        view.backgroundColor = UIColor.white
        
        let segment = UISegmentedControl(items: ["支出","收入"])
        segment.selectedSegmentIndex = 0
        // 設置外觀顏色 預設為藍色
        segment.tintColor = UIColor.init(hexFromString: "#8091BF")
        // 設置底色 沒有預設的顏色
        segment.backgroundColor = UIColor.init(hexFromString: "#82B38A")
        
        // 設置切換選項時執行的動作
        segment.addTarget(
            self,
            action:#selector(AddRecordViewController.onChange),
            for: .valueChanged)

        // 設置尺寸及位置並放入畫面中
        segment.frame.size = CGSize(width: width, height: 30)
        
        picker.frame = CGRect(x: 0, y: 0, width: width, height: 210)
        
        picker.delegate = self
        picker.dataSource = self
        
        view.addSubview(picker)
        
        view.addSubview(segment)
        
        return view
    }
}
//MARK:PickView Segment Function
extension AddRecordViewController :UIPickerViewDelegate,UIPickerViewDataSource{
    //有幾個區塊
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
   
    //裡面有幾列
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return typeDate.count
    }
    
    //選擇到的那列要做的事
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       
        textType.text = typeDate[row].name + "(\(typeDate[row].type))"
    }
    
    //設定每列PickerView要顯示的內容
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return typeDate[row].name
    }
    
    @objc func onChange(sender: UISegmentedControl) {
        // 印出選到哪個選項 從 0 開始算起
        //print(sender.selectedSegmentIndex)

        let search = sender.titleForSegment(at: sender.selectedSegmentIndex)
        
        typeDate = typeInfo().searchTypeDB(str: search!)
        
        if search == "支出" { textMoney.textColor = UIColor.red }
        if search == "收入" { textMoney.textColor = UIColor.init(hexFromString: "#82B38A") }
        
        picker.reloadAllComponents()
    }
}