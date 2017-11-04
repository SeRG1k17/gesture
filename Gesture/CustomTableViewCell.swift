//
//  CustomTableViewCell.swift
//  Gesture
//
//  Created by Sergey Pugach on 11/3/17.
//  Copyright © 2017 Sergey Pugach. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var errorTextFieldView: ExpandErrorImageTextFieldView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
