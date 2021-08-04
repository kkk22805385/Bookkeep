//
//  MoreViewController.swift
//  Bookkeep
//
//  Created by aa on 2020/9/11.
//  Copyright © 2020 Bookkeep. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController {

    @IBOutlet var btnCoffee: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        btnCoffee.layer.cornerRadius = 10.0
        btnCoffee.layer.borderWidth = 1.0
        btnCoffee.layer.borderColor = UIColor.gray.cgColor
        btnCoffee.layer.backgroundColor = UIColor.black.cgColor
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        statusBar(color: UIColor.white)
    }
    @IBAction func btnCoffee(_ sender: Any) {
        let coffeeView = CoffeeListViewController(nibName: "CoffeeListViewController", bundle: nil)
        coffeeView.modalPresentationStyle = .fullScreen
        present(coffeeView, animated: true, completion: nil)
    }
}
