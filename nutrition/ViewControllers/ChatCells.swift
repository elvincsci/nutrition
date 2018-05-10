//
//  ChatCells.swift
//  nutrition
//
//  Created by elvin on 3/4/18.
//  Copyright © 2018 elvin. All rights reserved.
//

import Foundation
import UIKit

class SenderCell: UITableViewCell {

    
    @IBOutlet var profilePic: RoundedImageView!
    @IBOutlet var message: UITextView!
    @IBOutlet var messageBackground: UIImageView!
    
    func clearCellData()  {
        self.message.text = nil
        self.message.isHidden = false
        self.messageBackground.image = nil
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.message.textContainerInset = UIEdgeInsetsMake(5, 5, 5, 5)
        self.messageBackground.layer.cornerRadius = 15
        self.messageBackground.clipsToBounds = true
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
class ReceiverCell: UITableViewCell {

    @IBOutlet var messageBackground: UIImageView!
    @IBOutlet var message: UITextView!
    
    func clearCellData()  {
        //self.messageDate.text = nil
        self.message.text = nil
        self.message.isHidden = false
        self.messageBackground.image = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.message.textContainerInset = UIEdgeInsetsMake(5, 5, 5, 5)
        // self.messageBackground.layer.cornerRadius = 5
        self.messageBackground.clipsToBounds = true
    }
    
}

