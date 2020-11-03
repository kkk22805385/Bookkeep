//
//  BOMTaViewCell.swift
//  Bookkeep
//
//  Created by aa on 2020/9/30.
//  Copyright © 2020 Bookkeep. All rights reserved.
//

import UIKit

class BOMTaViewCell: UITableViewCell {
    @IBOutlet var labelBal: UILabel!
    @IBOutlet var labelMonth: UILabel!
    @IBOutlet var labelIncome: UILabel!
    @IBOutlet var labelExpenses: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
