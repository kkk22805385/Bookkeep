//
//  StatistTaViewCell.swift
//  Bookkeep
//
//  Created by aa on 2020/12/10.
//  Copyright © 2020 Bookkeep. All rights reserved.
//

import UIKit

class StatistTaViewCell: UITableViewCell {
    @IBOutlet var labelMon: UILabel!
    @IBOutlet var labelIcom: UILabel!
    @IBOutlet var labelExp: UILabel!
    @IBOutlet var labelBalance: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
