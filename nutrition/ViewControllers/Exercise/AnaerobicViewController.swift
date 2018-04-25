//
//  AnaerobicViewController.swift
//  nutrition
//
//  Created by elvin on 4/16/18.
//  Copyright © 2018 elvin. All rights reserved.
//

import UIKit
import Firebase


class AnaerobicViewController: UIViewController {

    @IBOutlet weak var weightTextField: UITextField!
    
    @IBOutlet weak var setsTextfield: UITextField!
    
    @IBOutlet weak var RepsTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SubmitTextField(_ sender: Any) {
        
        
        let ref = Database.database().reference()
        
        let uid = Auth.auth().currentUser?.uid
        
        let Anaerobicdata = ref.child("users").child(uid!).child("Aerobic").childByAutoId()
        
        let AnaerobicWeight = Anaerobicdata.child("Weight")
        AnaerobicWeight.setValue(Int(weightTextField.text!))
        
        let AnaerobicSets = Anaerobicdata.child("Sets")
        AnaerobicSets.setValue(Int(setsTextfield.text!))

        let AnaerobicReps = Anaerobicdata.child("Reps")
        AnaerobicReps.setValue(Int(setsTextfield.text!))
        
        
        let timestamp = NSDate().timeIntervalSince1970
        let StressTimestamp = Anaerobicdata.child("TimeStamp")
        StressTimestamp.setValue(timestamp)
        
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
