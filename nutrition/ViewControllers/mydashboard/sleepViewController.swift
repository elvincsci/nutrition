//  sleepViewController.swift
//  nutrition
//
//  Created by elvin on 4/4/18.
//  Copyright © 2018 elvin. All rights reserved.
//

import UIKit
import Firebase

class sleepViewController: UIViewController {

    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var SleepTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Sleep"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func slideraction(_ sender: Any) {

        SleepTextField.text = Int(slider.value).description
    }
    
    @IBAction func SubmitButton(_ sender: Any) {
        
        if SleepTextField.text != ""
        {
        //print(Int(slider.value).description)

            let ref = Database.database().reference()
            
            let uid = Auth.auth().currentUser?.uid
            
            let Stress = ref.child("users").child(uid!).child("Sleep").childByAutoId()
            
            let sleepInd = Stress.child("sleepValue")
            sleepInd.setValue(Int(Int(slider.value).description))

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
