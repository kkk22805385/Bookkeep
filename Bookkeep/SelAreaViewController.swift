//
//  SelAreaViewController.swift
//  Coffee
//
//  Created by aa on 2021/1/11.
//

import UIKit

protocol SelAreaViewControllerDelegate {
    func retCountry(strCountry:String)
}

class SelAreaViewController: UIViewController {

    @IBOutlet var areaTable: UITableView!
    var areaStas = [areaSta]()
    var country = ""
    var delegata : SelAreaViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
        
        areaTable.register(UINib.init(nibName: "AreaTableViewCell", bundle: nil),forCellReuseIdentifier:"AreaTableViewCell")
        
        areaStas.removeAll()
        for area in GlobalValues().arrayCountry {
            let areasta = areaSta()
            areasta.area = area
            areasta.sta = "0"
            if area == country {
                areasta.sta = "1"
            }
            areaStas.append(areasta)
        }
        // Do any additional setup after loading the view.
    }
}

extension SelAreaViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return areaStas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AreaTableViewCell", for: indexPath as IndexPath) as! AreaTableViewCell
        cell.labelArea.text = areaStas[indexPath.row].area
        if areaStas[indexPath.row].sta == "0" {
            cell.imageDet.isHidden = true
        }else{
            cell.imageDet.isHidden = false
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegata?.retCountry(strCountry: areaStas[indexPath.row].area)
        self.dismiss(animated: true, completion: nil)
    }
    
}

class areaSta :NSObject{
    var area = ""
    var sta = ""
}

