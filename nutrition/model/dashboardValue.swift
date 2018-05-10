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
        

        Database.database().reference().child("users").child(userID!).child("Userweight").observeSingleEvent(of: .value
            , with: { (snapshot) in

                if snapshot.exists(){

                    let receivedMessage = snapshot.value as! [String: Any]

                    for current in receivedMessage
                    {
                        let receivedMessage = current.value as! [String: Any]

                        let type = " "
                        let UserWeight = Int(receivedMessage["UserWeight"] as! Double)

                        let UserDates = receivedMessage["UserDate"] as! String

                        let UserDate = String(UserDates.characters.dropLast(3))   // "01234567"
                
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss -zzzz"
                        //dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale!
                        let date = dateFormatter.date(from: UserDate)!

                        let TimeStamp = date.timeIntervalSince1970

                        let activity = "User Weight"
                        let measurementtype = "Weight"

                        let dash = dashboardValue.init(type: type, datapoint: UserWeight , timestamp: TimeStamp, activity:activity, measurementtype:measurementtype)

                        completion(dash)

                    }
                }
        })

        
        
        
        Database.database().reference().child("users").child(userID!).child("Aerobic").observeSingleEvent(of: .value
            , with: { (snapshot) in
                
            if snapshot.exists(){
                
                let receivedMessage = snapshot.value as! [String: Any]
                
                for current in receivedMessage
                {
                    let receivedMessage = current.value as! [String: Any]
                
                    let type = receivedMessage["AerobicType"] as! String
                    let Caloriesburned = receivedMessage["Caloriesburned"] as! Int

                    let TimeStamp = receivedMessage["TimeStamp"] as! Double
                    let activity = "Aerobic"
                    let measurementtype = "Calories burned"
                    
                    let dash = dashboardValue.init(type: type, datapoint: Caloriesburned , timestamp: TimeStamp, activity:activity, measurementtype:measurementtype)
                    
                    completion(dash)
                    
                }
             }
        })
        
 
        Database.database().reference().child("users").child(userID!).child("Sleep").observeSingleEvent(of: .value
            , with: { (snapshot) in
                                                                                                
        if snapshot.exists(){
            
            let receivedMessage = snapshot.value as! [String: Any]
            
            for current in receivedMessage
            {
                let receivedMessage = current.value as! [String: Any]
                
                let type = " "
                let sleepValue = receivedMessage["sleepValue"] as! Int
                
                let TimeStamp = receivedMessage["TimeStamp"] as! Double
                let activity = "Quality sleep"
                let measurementtype = "Hours of sleep"
                
                let dash = dashboardValue.init(type: type, datapoint: sleepValue , timestamp: TimeStamp, activity:activity, measurementtype:measurementtype)
                
                completion(dash)
            }
                
                
                
//                if receivedMessage["TimeStamp"] == nil
//                {
//                    let TimeStamp = NSDate().timeIntervalSince1970
//                    let activity = "Quality sleep"
//                    let measurementtype = "Hours of sleep"
//
//                    let dash = dashboardValue.init(type: type, datapoint: sleepValue , timestamp: TimeStamp, activity:activity, measurementtype:measurementtype)
//
//                    completion(dash)
//
//                }else{
//                    let TimeStamp = receivedMessage["TimeStamp"] as! Double
//                    let activity = "Quality sleep"
//                    let measurementtype = "Hours of sleep"
//
//                    let dash = dashboardValue.init(type: type, datapoint: sleepValue , timestamp: TimeStamp, activity:activity, measurementtype:measurementtype)
//
//                    completion(dash)
//                }
            
                
                
            }
                                                                                                
        })
        
        
        Database.database().reference().child("users").child(userID!).child("Stretch").observe(.value,
                                                                                               with: { (snapshot) in
        if snapshot.exists(){
            
            let receivedMessage = snapshot.value as! [String: Any]
            
            for current in receivedMessage
            {
                let receivedMessage = current.value as! [String: Any]
                
                let type = " "
                let Duration = receivedMessage["Duration"] as! Int
                let TimeStamp = receivedMessage["TimeStamp"] as! Double
                let activity = "Stretch"
                let measurementtype = "duration"

                let dash = dashboardValue.init(type: type, datapoint: Duration , timestamp: TimeStamp, activity:activity, measurementtype:measurementtype)

                completion(dash)

                
            }
                
//                if receivedMessage["TimeStamp"] == nil
//                {
//                    let TimeStamp = NSDate().timeIntervalSince1970
//                    let activity = "Stretch"
//                    let measurementtype = "duration"
//
//                    let dash = dashboardValue.init(type: type, datapoint: Duration , timestamp: TimeStamp, activity:activity, measurementtype:measurementtype)
//
//                    completion(dash)
//
//                }else{
//                    let TimeStamp = receivedMessage["TimeStamp"] as! Double
//                    let activity = "Stretch"
//                    let measurementtype = "duration"
//
//                    let dash = dashboardValue.init(type: type, datapoint: Duration , timestamp: TimeStamp, activity:activity, measurementtype:measurementtype)
//
//                    completion(dash)
//                }

            }
            
        })
        
        Database.database().reference().child("users").child(userID!).child("WaterIntake").observeSingleEvent(of: .value,
                                                                                                   with: { (snapshot) in
                                                                            
        if snapshot.exists(){
            
            let receivedMessage = snapshot.value as! [String: Any]
            
            for current in receivedMessage
            {
                let receivedMessage = current.value as! [String: Any]
                
                let type = " "
                let Duration = receivedMessage["water"] as! Int
                let TimeStamp = receivedMessage["TimeStamp"] as! Double
            
                let activity = "Water"
                let measurementtype = "amount"

                let dash = dashboardValue.init(type: type, datapoint: Duration , timestamp: TimeStamp, activity:activity, measurementtype:measurementtype)

                completion(dash)
                
            }
            
            }
                                                                                                
        })
        


            Database.database().reference().child("users").child(userID!).child("foodIntake").observeSingleEvent(of: .value,
                                                                                                                 with: { (snapshot) in
                 
            if snapshot.exists(){
                
                let value = snapshot.value as! [String: Any]
                
                for current in value
                {
                    let receivedMessage = current.value as! [String: Any]

                    let type = receivedMessage["name"] as! String
                    let calories = receivedMessage["calories"]
                
                    let TimeStamp = receivedMessage["TimeStamp"] as! Double
                    let activity = "Food intake"
                    let measurementtype = "Calories counter"

                    let dash = dashboardValue.init(type: type, datapoint: calories as! Int , timestamp: TimeStamp, activity:activity, measurementtype:measurementtype)
                
                    completion(dash)

               }
                
            }
                                                                                                                    
            })
    
        
//        Database.database().reference().child("users").child(userID!).child("foodIntake").observe(.childAdded,
//                                                                                                   with: { (snapshot) in
//            if snapshot.exists(){
//
//                let receivedMessage = snapshot.value as! [String: Any]
//
//                let type = receivedMessage["name"] as! String
//                let calories = receivedMessage["calories"]
//
////                let TimeStamp = receivedMessage["TimeStamp"] as! Double
////                let activity = "Food intake"
////                let measurementtype = "Calories counter"
////
////                let dash = dashboardValue.init(type: type, datapoint: calories , timestamp: TimeStamp, activity:activity, measurementtype:measurementtype)
////
////                completion(dash)
//
//
//                if receivedMessage["TimeStamp"] == nil
//                {
//                    let TimeStamp = NSDate().timeIntervalSince1970
//                    let activity = "Food intake"
//                    let measurementtype = "Calories counter"
//
//                    let dash = dashboardValue.init(type: type, datapoint: calories as! Int , timestamp: TimeStamp, activity:activity, measurementtype:measurementtype)
//
//                    completion(dash)
//
//                }else{
//                    let TimeStamp = receivedMessage["TimeStamp"] as! Double
//                    let activity = "Food intake"
//                    let measurementtype = "Calories counter"
//
//                    let dash = dashboardValue.init(type: type, datapoint: calories as! Int , timestamp: TimeStamp, activity:activity, measurementtype:measurementtype)
//
//                    completion(dash)
//                }
//
//
//            }
//
//        })
        
        
        
        Database.database().reference().child("users").child(userID!).child("Stress").observeSingleEvent(of: .value,
                                                                                                         with: { (snapshot) in
                                                                                                            
            
            
        if snapshot.exists(){
            
            let value = snapshot.value as! [String: Any]
            
            for current in value
            {
                let receivedMessage = current.value as! [String: Any]
                
                let type = " "
                let calories = receivedMessage["Stress"] as! Int
                let TimeStamp = receivedMessage["TimeStamp"] as! Double
                let activity = "Stress"
                let measurementtype = "scale"
                let dash = dashboardValue.init(type: type, datapoint: calories , timestamp: TimeStamp, activity:activity, measurementtype:measurementtype)
                
                completion(dash)
                
            }
                
        
        
                
//                let TimeStamp = receivedMessage["TimeStamp"] as! Double
//                let activity = "Stress"
//                let measurementtype = "scale"
//
//                let dash = dashboardValue.init(type: type, datapoint: calories , timestamp: TimeStamp, activity:activity, measurementtype:measurementtype)
//
//                completion(dash)
                
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
