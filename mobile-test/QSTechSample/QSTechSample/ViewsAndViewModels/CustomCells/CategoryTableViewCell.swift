//
//  CategoryTableViewCell.swift
//  QSTechSample
//
//  Created by Gangadharan, Deepa  on 31/05/2019.
//  Copyright © 2019 Gangadharan, Deepa. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var cellBgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.cellBgView.layer.cornerRadius = 5.0
        self.categoryLabel.textColor = UIColor.white
    }
    
}
