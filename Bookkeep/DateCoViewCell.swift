//
//  DateCoViewCell.swift
//  Bookkeep
//
//  Created by aa on 2020/9/14.
//  Copyright © 2020 Bookkeep. All rights reserved.
//

import UIKit

class DateCoViewCell: UICollectionViewCell {
    @IBOutlet var labelDate: UILabel!
    @IBOutlet var bgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.layer.cornerRadius = 17
    }

}
