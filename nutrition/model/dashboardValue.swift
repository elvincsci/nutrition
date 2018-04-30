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
    
    let activity: Any
    let activitytype: Any
    let measurementtype: Any
    let timestamp: Double
    let datapoint: Int

    class func downloadAllMessages(completion: @escaping (dashboardValue) -> Swift.Void) {
        
    let userID = Auth.auth().currentUser?.uid
        
    var counter = 2
        
        Database.database().reference().child("users").child(userID!).child("Aerobic").observeSingleEvent(of: .childAdded, with: { (snapshot) in
            
             if snapshot.exists(){
                
                
                let receivedMessage = snapshot.value as! [String: Any]

                let type = receivedMessage["AerobicType"] as! String
                let Caloriesburned = receivedMessage["Caloriesburned"] as! Int
                let TimeStamp = receivedMessage["TimeStamp"] as! Double
                let activity = "Aerobic"
                let measurementtype = "Calories burned"
                
                let dash = dashboardValue.init(type: type, datapoint: Caloriesburned , timestamp: TimeStamp, activity:activity, measurementtype:measurementtype)
                
                completion(dash)
                
             }
        
        })
        
        
        Database.database().reference().child("users").child(userID!).child("Sleep").observe(.childAdded,
                                                                                             with: { (snapshot) in
                                                                                                
                                                                                                
            if snapshot.exists()  {
                
            

                let receivedMessage = snapshot.value as! [String: Any]

                let type = " "
                let sleepValue = receivedMessage["sleepValue"] as! Int
                
                let TimeStamp = receivedMessage["TimeStamp"] as! Double
                
//                let value = snapshot.value as? NSDictionary
//                let type = " "
//                let sleepValue = value!["sleepValue"] as! Int
//                let TimeStamp = value!["TimeStamp"] as! Double

                
                
                let activity = "Quality sleep"
                let measurementtype = "Hours of sleep"
                
                
                
                let dash = dashboardValue.init(type: type, datapoint: sleepValue , timestamp: TimeStamp, activity:activity, measurementtype:measurementtype)
                
                completion(dash)
                
            }
                                                                                                
        })
        
        
        
        Database.database().reference().child("users").child(userID!).child("Stretch").observe(.childAdded,
                                                                                               with: { (snapshot) in
            if snapshot.exists() {
            
                
                let receivedMessage = snapshot.value as! [String: Any]
                
                let type = " "
                let Duration = receivedMessage["Duration"] as! Int
                let TimeStamp = receivedMessage["TimeStamp"] as! Double
                let activity = "Stretch"
                let measurementtype = "duration"
                
                let dash = dashboardValue.init(type: type, datapoint: Duration , timestamp: TimeStamp, activity:activity, measurementtype:measurementtype)
                
                completion(dash)
                
            }
            
        })
        
        Database.database().reference().child("users").child(userID!).child("WaterIntake").observe(.childAdded,
                                                                                                   with: { (snapshot) in
            if snapshot.exists(){
                
                
              //  let receivedMessage = snapshot.value as! [String: Any]
                
                let type = " "
                
                let value = snapshot.value as! [String: Any]
                
                let Duration = value["water"] as! Int
                let TimeStamp = value["TimeStamp"] as! Double
                                
            //    let Duration = receivedMessage["water"] as! Int
             //   let TimeStamp = receivedMessage["TimeStamp"] as! Double
            
                let activity = "Water"
                let measurementtype = "amount"
                
                let dash = dashboardValue.init(type: type, datapoint: Duration , timestamp: TimeStamp, activity:activity, measurementtype:measurementtype)
                
                completion(dash)
                
            }
                                                                                                
        })
        
        Database.database().reference().child("users").child(userID!).child("foodIntake").observe(.childAdded,
                                                                                                   with: { (snapshot) in
            if snapshot.exists(){
                
                let receivedMessage = snapshot.value as! [String: Any]
                
                let type = receivedMessage["name"] as! String
                let calories = receivedMessage["calories"] as! Int
                let TimeStamp = receivedMessage["TimeStamp"] as! Double
                let activity = "Food intake"
                let measurementtype = "Calories counter"
                
                let dash = dashboardValue.init(type: type, datapoint: calories , timestamp: TimeStamp, activity:activity, measurementtype:measurementtype)
                
                completion(dash)
                
            }
                                                                                                    
        })
        
        Database.database().reference().child("users").child(userID!).child("Stress").observe(.childAdded,
          with: { (snapshot) in
            
            
            if snapshot.exists(){
            
                
                let receivedMessage = snapshot.value as! [String: Any]
                
                let type = " "
                let calories = receivedMessage["Stress"] as! Int

                let TimeStamp = receivedMessage["TimeStamp"] as! Double
                let activity = "Stress"
                let measurementtype = "scale"
                
                let dash = dashboardValue.init(type: type, datapoint: calories , timestamp: TimeStamp, activity:activity, measurementtype:measurementtype)
                
                completion(dash)
                
            }
                                                                                                    
        })
        
    }

    
    init(type: Any, datapoint: Int, timestamp: Double, activity:String, measurementtype: String) {
        
        self.activitytype = type
        self.activity = activity
        self.datapoint = datapoint
        self.timestamp = timestamp
        self.measurementtype = measurementtype
    }
    
}
