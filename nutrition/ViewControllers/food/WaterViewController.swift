//
//  WaterViewController.swift
//  nutrition
//
//  Created by elvin on 4/16/18.
//  Copyright © 2018 elvin. All rights reserved.
//

import UIKit
import Firebase


class WaterViewController: UIViewController {

    @IBOutlet weak var waterInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func plusFiveButton(_ sender: Any) {
        
        let number = Int(waterInput.text!)! + 5
        
        waterInput.text = number.description
    }
    
    @IBAction func plusTwoButton(_ sender: Any) {
        
        let number = Int(waterInput.text!)! + 2
        
        waterInput.text = number.description


    }
    
    @IBAction func minusButton(_ sender: Any) {
        
        let number = Int(waterInput.text!)! - 1
        waterInput.text = number.description
        
    }
    @IBAction func plusOneButton(_ sender: Any) {
        
        if waterInput.text! != ""
        {
            let number = Int(waterInput.text!)! + 1
            waterInput.text = number.description
        }
    }
    
    
    
    @IBAction func submitButton(_ sender: Any) {
        
        if waterInput.text != ""
        {
            
            let ref = Database.database().reference()
            
            let uid = Auth.auth().currentUser?.uid
            
            let Stress = ref.child("users").child(uid!).child("WaterIntake").childByAutoId()
            
            let WaterIntake = Stress.child("water")
            WaterIntake.setValue(Int(waterInput.text!))
            
            let timestamp = NSDate().timeIntervalSince1970
            let StressTimestamp = Stress.child("TimeStamp")
            StressTimestamp.setValue(timestamp)
            
        }
        else
        {
            print("empty")
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
