//
//  DetailTableViewCell.swift
//  weather
//
//  Created by Padmapriya Trishul on 12/11/15.
//  Copyright © 2015 Padmapriya Trishul. All rights reserved.
//

import UIKit
//each cell in DetailTableViewController
class DetailTableViewCell: UITableViewCell {

    @IBOutlet weak var day: UILabel!
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var maxtemp: UILabel!
    
    @IBOutlet weak var mintemp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
