//
//  User.swift
//  nutrition
//
//  Created by elvin on 11/25/17.
//  Copyright © 2017 elvin. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class User: NSObject {
    
    var id: String?
    var name: String?
    var email: String?
    var profilePic: UIImage?
    

    class func registerUser(withName: String, email: String, password: String, profilePic: UIImage, completion: @escaping (Bool) -> Swift.Void) {
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                user?.sendEmailVerification(completion: nil)
                let storageRef = Storage.storage().reference().child("usersProfilePics").child(user!.uid)
                let imageData = UIImageJPEGRepresentation(profilePic, 0.1)
                storageRef.putData(imageData!, metadata: nil, completion: { (metadata, err) in
                    if err == nil {
                        let path = metadata?.downloadURL()?.absoluteString
                        let values = ["name": withName, "email": email, "profilePicLink": path!]
                        Database.database().reference().child("users").child((user?.uid)!).child("credentials").updateChildValues(values, withCompletionBlock: { (errr, _) in
                            if errr == nil {
                                let userInfo = ["email" : email, "password" : password]
                                UserDefaults.standard.set(userInfo, forKey: "userInformation")
                                completion(true)
                            }
                        })
                    }
                })
            }
            else {
                completion(false)
            }
        })
    }
    
    
    class func loginUser(withEmail: String, password: String, completion: @escaping (Bool) -> Swift.Void) {
        Auth.auth().signIn(withEmail: withEmail, password: password, completion: { (user, error) in
            if error == nil {
                let userInfo = ["email": withEmail, "password": password]
                UserDefaults.standard.set(userInfo, forKey: "userInformation")
                completion(true)
            } else {
                completion(false)
            }
        })
    }
    
    
    class func logOutUser(completion: @escaping (Bool) -> Swift.Void) {
        do {
            try Auth.auth().signOut()
            UserDefaults.standard.removeObject(forKey: "userInformation")
            completion(true)
        } catch _ {
            completion(false)
        }
    }
    
    
}
