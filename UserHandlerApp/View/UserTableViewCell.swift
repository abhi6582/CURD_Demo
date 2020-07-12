//
//  UserTableViewCell.swift
//  UserHandlerApp
//
//  Created by Abhishek Dudhrejia on 11/07/20.
//  Copyright © 2020 Abhishek Dudhrejia. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var lblProfileColor:UILabel?
    @IBOutlet weak var lblName:UILabel?
    @IBOutlet weak var lblEmail:UILabel?
    @IBOutlet weak var lblDate:UILabel?
    @IBOutlet weak var lblDescription:UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
