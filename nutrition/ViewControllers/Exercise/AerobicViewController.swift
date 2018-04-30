//
//  AerobicViewController.swift
//  nutrition
//
//  Created by elvin on 4/16/18.
//  Copyright © 2018 elvin. All rights reserved.
//

import UIKit
import Firebase


class AerobicViewController:  UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var distanceTextfield: UITextField!
    
    @IBOutlet weak var durationTextfield: UITextField!
    
    @IBOutlet weak var caloriesBurned: UITextField!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    
    let Aerobictype = ["Walking", "Cycling", "Swimming", "Other"]
    
    var Aerobicselection = -1

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return Aerobictype[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return Aerobictype.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {

        Aerobicselection = row
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func submitButton(_ sender: Any) {
        
        //print("Submit button")
        
        if Aerobicselection == -1 || Aerobicselection == 0
        {
            Aerobicselection = 0
        }
        
        
        let ref = Database.database().reference()
        
        let uid = Auth.auth().currentUser?.uid
        
        let Aerobicdata = ref.child("users").child(uid!).child("Aerobic").childByAutoId()
        
        let Distance = Aerobicdata.child("Distance")
        Distance.setValue(Int(distanceTextfield.text!))
        
        let AerobicType = Aerobicdata.child("AerobicType")
        AerobicType.setValue(Aerobictype[Aerobicselection])
        
        let Duration = Aerobicdata.child("Duration")
        Duration.setValue(Int(durationTextfield.text!))
        
        let Caloriesburned = Aerobicdata.child("Caloriesburned")
        Caloriesburned.setValue(Int(caloriesBurned.text!))
    
        
        let timestamp = NSDate().timeIntervalSince1970
        let StressTimestamp = Aerobicdata.child("TimeStamp")
        StressTimestamp.setValue(timestamp)

        
        _ = navigationController?.popViewController(animated: true)

        
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
