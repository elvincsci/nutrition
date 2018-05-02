//
//  WeightViewController.swift
//  nutrition
//
//  Created by elvin on 4/4/18.
//  Copyright © 2018 elvin. All rights reserved.
//

import UIKit
import SafariServices
import Firebase


class WeightViewController: UIViewController {

    @IBOutlet weak var connetDeviceOutlet: UIButton!
    @IBOutlet weak var BMI: UITextField!
    @IBOutlet weak var BFI: UITextField!
    @IBOutlet weak var Weight: UITextField!
    
    var ref: DatabaseReference!

    func fetchData() {
        
        let userID = Auth.auth().currentUser?.uid
        let ref = Database.database().reference()

        
        ref.child("users").child(userID!).child("Nokia credentials").observeSingleEvent(of: .value, with: { (snapshot) in
            
            if snapshot.exists() {
                
                //connetDeviceOutlet.setTitle("Sync Using Nokia Scale", for: )
                self.connetDeviceOutlet.setTitle("Sync Using Nokia Scale", for: .normal)

        
            }else
            {
                self.connetDeviceOutlet.setTitle("Add Smart Scale", for: .normal)

            }
        
             })

    }
    
    
        
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Measurement"
        fetchData()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func ConnectScale(_ sender: Any) {
        
        if connetDeviceOutlet.titleLabel?.text == "Sync Using Nokia Scale"
        {
           
            let userID = Auth.auth().currentUser?.uid
            
            Database.database().reference().child("users").child(userID!).child("Nokia credentials").observeSingleEvent(of: .value
                , with: { (snapshot) in
                    
                let receivedMessage = snapshot.value as! [String: Any]

                //let type = receivedMessage["AerobicType"] as! String

                // Get user value
                //let value = snapshot.value as? NSDictionary
                let NokiaSecretStr = receivedMessage["NokiaSecretStr"] as! String
                let NokiaTokenStr = receivedMessage["NokiaTokenStr"] as! String
                let NokiaUserID = receivedMessage["NokiaUserID"] as! String
                
                //  let user = User(username: username)
                
                
             let jsonUrlString = "http://localhost:8080/getlast" + "?SecretStr=" + NokiaSecretStr + "&TokenStr=" + NokiaTokenStr + "&UserID=" + NokiaUserID
                
                
                guard let url = URL(string: jsonUrlString) else { return }
                
                URLSession.shared.dataTask(with: url) { (data, response, err) in
                    
                    guard let data = data else { return }
                    
                    
                    if(err != nil){
                        print("error")
                    }else{
                        
                        do {
                            
                            let animeJsonStuff =  try JSONDecoder().decode(Weight_Json.self, from: data)
                            
                            DispatchQueue.main.async {
                                
                                for jsonMedia in animeJsonStuff.Weight_Data {
                                    
                                    
                                    self.ref = Database.database().reference()
                                    
                                    let uid = Auth.auth().currentUser?.uid
                                    
                                    let Nokiacredentials = self.ref.child("users").child(uid!).child("Userweight").childByAutoId()
                                    
                                    let NokiaSecretStr = Nokiacredentials.child("UserDate")
                                    NokiaSecretStr.setValue(jsonMedia.Weight_date!)
                                    
                                    
                                    let NokiaTokenStr = Nokiacredentials.child("UserWeight")
                                    NokiaTokenStr.setValue(jsonMedia.Weight_kg)
                                    
                                    
                                }
                            }
                            
                        } catch let jsonErr {
                            print("Error serializing json:", jsonErr)
                        }
                        
                    }
                    
                    }.resume()

                
                // ...
            }) { (error) in
                print(error.localizedDescription)
            }

            _ = navigationController?.popViewController(animated: true)

        }else{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "device") as! deviceViewController
            self.show(vc, sender: self)
        }
    
    }
    
    @IBAction func Submit(_ sender: Any) {
        
        
        if Weight.text != ""
        {
            
            let ref = Database.database().reference()
            
            let uid = Auth.auth().currentUser?.uid
            
            let Nokiacredentials = ref.child("users").child(uid!).child("Userweight").childByAutoId()
            
            //let Nokiacredentials = self.ref.child("Userweight")
            
            let timestamp = NSDate().timeIntervalSince1970
            
            let NokiaSecretStr = Nokiacredentials.child("UserDate")
            NokiaSecretStr.setValue(timestamp)
            
            let NokiaTokenStr = Nokiacredentials.child("UserWeight")
            NokiaTokenStr.setValue(Int(Weight.text!))
            
            let BodyFat = Nokiacredentials.child("BodyFat")
            BodyFat.setValue(Int(BFI.text!))
            
            let BodyMass = Nokiacredentials.child("BodyMass")
            BodyMass.setValue(Int(BMI.text!))
            _ = navigationController?.popViewController(animated: true)

        }
        
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
