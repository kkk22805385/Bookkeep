//
//  CoffeeCell.swift
//  Coffee
//
//  Created by aa on 2021/1/5.
//

import UIKit

class CoffeeCell: UITableViewCell {
    @IBOutlet var labelName: UILabel!
    @IBOutlet var labelAddress: UILabel!
    @IBOutlet var imgFirst: UIImageView!
    @IBOutlet var imgSecond: UIImageView!
    @IBOutlet var imgThrid: UIImageView!
    @IBOutlet var imgFour: UIImageView!
    @IBOutlet var imgFive: UIImageView!
    @IBOutlet var imgBackground: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
