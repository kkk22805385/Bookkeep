//
//  DataCell.swift
//  Bookkeep
//
//  Created by aa on 2021/7/30.
//  Copyright © 2021 Bookkeep. All rights reserved.
//

import UIKit

class DataCell: UITableViewCell {

    @IBOutlet var labelLeft: UILabel!
    @IBOutlet var labelRight: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
