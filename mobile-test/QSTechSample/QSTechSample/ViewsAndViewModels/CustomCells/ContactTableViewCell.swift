//
//  ContactTableViewCell.swift
//  QSTechSample
//
//  Created by Gangadharan, Deepa  on 02/06/2019.
//  Copyright © 2019 Gangadharan, Deepa. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var contactButton1: UIButton!
    @IBOutlet weak var contactButton2: UIButton!
    @IBOutlet weak var cellBgView: UIView!
    
    // Declare callback function variable
    var button1Callback: (()->())?
    var button2Callback: (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.cellBgView.layer.cornerRadius = 5.0
        self.headerLabel.textColor = UIColor.red
        self.valueLabel.textColor = UIColor.darkGray
    }

    @IBAction func onButton1Click(_ sender: Any) {
        button1Callback?() // Use callback to return data
    }
    
    @IBAction func onButton2Click(_ sender: Any) {
        button2Callback?() // Use callback to return data
    }
    
}
