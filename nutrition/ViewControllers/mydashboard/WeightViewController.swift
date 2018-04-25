//
//  WeightViewController.swift
//  nutrition
//
//  Created by elvin on 4/4/18.
//  Copyright © 2018 elvin. All rights reserved.
//

import UIKit
import Firebase


class WeightViewController: UIViewController {

    @IBOutlet weak var connetDeviceOutlet: UIButton!
    @IBOutlet weak var BMI: UITextField!
    @IBOutlet weak var BFI: UITextField!
    @IBOutlet weak var Weight: UITextField!
    
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
