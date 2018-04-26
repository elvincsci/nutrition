//
//  dashboardValue.swift
//  nutrition
//
//  Created by elvin on 4/25/18.
//  Copyright © 2018 elvin. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class dashboardValue {
    
    let type: Any
    let timestamp: Int
    let datapoint: Any

    class func downloadAllMessages(completion: @escaping (dashboardValue) -> Swift.Void) {
        
        var ref: DatabaseReference!
        let userID = Auth.auth().currentUser?.uid
        
        ref.child("users").child(userID!).child("Aerobic").observeSingleEvent(of: .value, with: { (snapshot) in
            
            
         if snapshot.exists() {

                                                                            
            let receivedMessage = snapshot.value as! [String: Any]

            let type = receivedMessage["AerobicType"] as! String
            let Caloriesburned = receivedMessage["Caloriesburned"] as! String
            let TimeStamp = receivedMessage["TimeStamp"] as! Int

            
            
            let dash = dashboardValue.init(type: type, datapoint: Caloriesburned , timestamp: TimeStamp)
            
            completion(dash)
            
         }
        
        })
                                                                            
        
        
    }

    
    init(type: Any, datapoint: Any, timestamp: Int) {
        self.type = type
        self.datapoint = datapoint
        self.timestamp = timestamp
    }
    
}
