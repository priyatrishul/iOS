//
//  TableViewCell.swift
//  weather
//
//  Created by Padmapriya Trishul on 12/9/15.
//  Copyright © 2015 Padmapriya Trishul. All rights reserved.
//

import UIKit
//each cell in TableViewController
class TableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var temperature: UILabel!
    
    @IBOutlet weak var name1: UILabel!
    
    @IBOutlet weak var name2: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
