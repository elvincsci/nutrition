//
//  Video.swift
//  youtube
//
//  Created by Brian Voong on 6/9/16.
//  Copyright © 2016 letsbuildthatapp. All rights reserved.
//

import Foundation
import UIKit
import Firebase


class Video {

    let content: Any
    let timestamp: Int
    let thumbNailimage: UIImage
    var videoLink: URL!

    
    class func downloadAllMessages(completion: @escaping (Video) -> Swift.Void) {

        Database.database().reference().child("newsFeedContent").observe(.childAdded,
          with: { (snap) in
            
            let receivedMessage = snap.value as! [String: Any]

            let content = receivedMessage["content"] as! String
            let timestamp = receivedMessage["timestamp"] as! Int
            let videoLinksString = receivedMessage["videoLink"] as! String
            let thumbNailimageURLString = receivedMessage["thumbNailimage"] as! String

            
            let videoLinks = NSURL(string: videoLinksString)

           /// let videoLinks = URL.init(string: "http://sample-videos.com/video/mp4/360/big_buck_bunny_360p_10mb.mp4")!
            
            //let thumbNailimageURL = NSURL(string: thumbNailimageURLString)
            
            //print("here")
            //print(thumbNailimageURL!)
            
//            if let data = try? Data(contentsOf: thumbNailimageURL! as URL)
//            {
//                let thumbNailimage = UIImage(data: data)!
//                //print(thumbNailimage)
//
//                //let video = Video.init(content: content, thumbNailimage: thumbNailimage , timestamp: timestamp, videoLink: videoLink)
//                completion(video)
//
//            }
            
            let url = URL(string: thumbNailimageURLString)
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            let thumbNailimage = UIImage(data: data!)
            
            
            let video = Video.init(content: content, thumbNailimage: thumbNailimage! , timestamp: timestamp, videoLink: videoLinks! as URL)
            
            completion(video)
           // print(videoLink)
            
        })
        
    }
    
    
    
    init(content: Any, thumbNailimage: UIImage, timestamp: Int, videoLink: URL) {
        self.content = content
        self.thumbNailimage = thumbNailimage
        self.timestamp = timestamp
        self.videoLink = videoLink
    }
    
}
