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
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    override func prepareForReuse() {
        super.prepareForReuse()
//        self.videoThumbnail.image = UIImage.init(named: "emptyTumbnail")
//        self.durationLabel.text = nil
//        self.channelPic.image = nil
//        self.videoTitle.text = nil
//        self.videoDescription.text = nil
    }
    
    func set(video: Video)  {
        self.imageThumbnail.image = video.thumbNailimage
        self.titleLB.text = video.content as! String
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
}
