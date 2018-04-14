//
//  DailyActivitiesViewController.swift
//  nutrition
//
//  Created by elvin on 4/4/18.
//  Copyright © 2018 elvin. All rights reserved.
//

import UIKit

class waterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Add Water"

        //self.title = "add water"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
//
//    class Message {
//
//        //MARK: Properties
//        var owner: MessageOwner
//        var type: MessageType
//        var content: Any
//        var timestamp: Int
//        var image: UIImage?
//
//
//        class func downloadAllMessages(forUserID: String, completion: @escaping (Message) -> Swift.Void) {
//
//
//
//            if (Auth.auth().currentUser?.uid) != nil {
//
//                Database.database().reference().child("conversations").child(forUserID).observe(.childAdded, with: { (snap) in
//                    if snap.exists() {
//                        let receivedMessage = snap.value as! [String: Any]
//                        let messageType = receivedMessage["type"] as! String
//                        var type = MessageType.text
//                        switch messageType {
//                        case "photo":
//                            type = .photo
//                        default: break
//                        }
//                        let content = receivedMessage["content"] as! String
//
//                        let timestamp = receivedMessage["timestamp"] as! Int
//
//                        let message = Message.init(type: type, content: content, owner: .receiver, timestamp: timestamp, isRead: true)
//                        completion(message)
//
//
//                    }
//                })
//            }
//        }
//
//
//        func downloadImage(indexpathRow: Int, completion: @escaping (Bool, Int) -> Swift.Void)  {
//            if self.type == .photo {
//                let imageLink = self.content as! String
//                let imageURL = URL.init(string: imageLink)
//                URLSession.shared.dataTask(with: imageURL!, completionHandler: { (data, response, error) in
//                    if error == nil {
//                        self.image = UIImage.init(data: data!)
//                        completion(true, indexpathRow)
//                    }
//                }).resume()
//            }
//        }
//
//        init(type: MessageType, content: Any, owner: MessageOwner, timestamp: Int, isRead: Bool) {
//            self.type = type
//            self.content = content
//            self.owner = owner
//            self.timestamp = timestamp
//        }
//
//
//    }


}
