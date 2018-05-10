//
//  ProfileViewController.swift
//  nutrition
//
//  Created by elvin on 4/23/18.
//  Copyright © 2018 elvin. All rights reserved.
//

import UIKit
import Firebase


class ProfileViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    func fetchData() {
        
        let userID = Auth.auth().currentUser?.uid
        let ref = Database.database().reference()
        
        
        ref.child("users").child(userID!).child("credentials").observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            
            self.nameTextField.text = value?["name"] as? String ?? ""
            self.emailTextField.text = value?["email"] as? String ?? ""


        })
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
