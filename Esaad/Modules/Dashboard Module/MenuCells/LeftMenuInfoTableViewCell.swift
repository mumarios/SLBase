//
//  LeftMenuInfoTableViewCell.swift
//  Esaad
//
//  Created by Faran Rasheed on 12/04/2019.
//  Copyright © 2019 Systems Ltd. All rights reserved.
//

import UIKit

class LeftMenuInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var companiesLabel: UILabel!
    @IBOutlet weak var dealsLabel: UILabel!
    @IBOutlet weak var copyrightsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        companiesLabel.text = ""
        dealsLabel.text = ""
        
    }
}
