//
//  AreaTableViewCell.swift
//  Coffee
//
//  Created by aa on 2021/1/11.
//

import UIKit

class AreaTableViewCell: UITableViewCell {
    @IBOutlet var labelArea: UILabel!
    @IBOutlet var imageDet: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
