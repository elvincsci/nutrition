//
//  StretchViewController.swift
//  nutrition
//
//  Created by elvin on 4/16/18.
//  Copyright © 2018 elvin. All rights reserved.
//

import UIKit
import Firebase


class StretchViewController: UIViewController {

    @IBOutlet weak var Duration: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitButton(_ sender: Any) {
        
        
        let ref = Database.database().reference()
        
        let uid = Auth.auth().currentUser?.uid
        
        let Stretchdata = ref.child("users").child(uid!).child("Stretch").childByAutoId()
        
        let Distance = Stretchdata.child("Duration")
        Distance.setValue(Int(Duration.text!))
        
        
        let timestamp = NSDate().timeIntervalSince1970
        let StressTimestamp = Stretchdata.child("TimeStamp")
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
