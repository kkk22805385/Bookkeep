//
//  StatisticsViewController.swift
//  Bookkeep
//
//  Created by aa on 2020/9/11.
//  Copyright © 2020 Bookkeep. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var tf: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let height = view.bounds.height - 230 - 200
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
    
        tf.inputView = picker
        
        tf.tintColor = UIColor.clear
        // Do any additional setup after loading the view.
    }
    @objc func dueDateChanged(sender:UIDatePicker){
         let dateFormatter = DateFormatter()
         dateFormatter.dateStyle = .none
         dateFormatter.timeStyle = .none
         
         print(sender.date)
         let date = sender.date
         
     }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
