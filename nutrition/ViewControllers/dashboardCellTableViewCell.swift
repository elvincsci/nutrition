//
//  dashboardCellTableViewCell.swift
//  nutrition
//
//  Created by elvin on 1/24/18.
//  Copyright © 2018 elvin. All rights reserved.
//

import UIKit

class dashboardCellTableViewCell: UITableViewCell {

    @IBOutlet var loaoding: UILabel!
    @IBOutlet var imagethumb: UIImageView!
    
    @IBOutlet var dates: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
