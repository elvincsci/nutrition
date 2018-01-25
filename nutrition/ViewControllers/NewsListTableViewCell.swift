//
//  NewsListTableViewCell.swift
//  nutrition
//
//  Created by elvin on 1/24/18.
//  Copyright © 2018 elvin. All rights reserved.
//

import UIKit

class NewsListTableViewCell: UITableViewCell {

    @IBOutlet var imageThumbnail: UIImageView!
    @IBOutlet var titleLB: UILabel!
    @IBOutlet var descriptionLB: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
