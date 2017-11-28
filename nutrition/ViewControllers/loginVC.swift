//
//  loginVC.swift
//  nutrition
//
//  Created by elvin on 11/25/17.
//  Copyright © 2017 elvin. All rights reserved.
//

import UIKit

class loginVC: UIViewController {

    
    @IBOutlet var loginView: UIView!
    @IBOutlet var registerView: UIView!
    
    @IBOutlet weak var loginEmail: UITextField!
    @IBOutlet weak var loginPassword: UITextField!
    
    @IBOutlet weak var loginEmailPasswordView: UIView!
    
    @IBOutlet var warningLB: [UILabel]!
    
    var isLoginViewVisible = true
    
    @IBOutlet var label: UIView!
    
    var loginViewTopConstraint: NSLayoutConstraint!
    var registerTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var registerName: UITextField!
    
    @IBOutlet weak var registerEmail: UITextField!
    @IBOutlet var inputFields: [UITextField]!
    
    @IBOutlet weak var registerPassword: UITextField!
    func customization()  {
        
        self.view.insertSubview(self.loginView, belowSubview: self.label)
        
        self.loginView.translatesAutoresizingMaskIntoConstraints = false
        self.loginView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.loginViewTopConstraint = NSLayoutConstraint.init(item: self.loginView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 60)
        self.loginViewTopConstraint.isActive = true
        self.loginView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.45).isActive = true
        self.loginView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        
        self.loginView.layer.cornerRadius = 8
        
        self.loginEmailPasswordView.layer.cornerRadius  = 8
        //RegisterView Customization
        self.view.insertSubview(self.registerView, belowSubview: self.label)
        self.registerView.translatesAutoresizingMaskIntoConstraints = false
        self.registerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.registerTopConstraint = NSLayoutConstraint.init(item: self.registerView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 1000)
        self.registerTopConstraint.isActive = true
        self.registerView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.6).isActive = true
        self.registerView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        self.registerView.layer.cornerRadius = 8
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.customization()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func switchView(_ sender: Any) {
        
        if self.isLoginViewVisible {
            self.isLoginViewVisible = false
            (sender as AnyObject).setTitle("Login", for: .normal)
            self.loginViewTopConstraint.constant = 1000
            self.registerTopConstraint.constant = 60
        } else {
            self.isLoginViewVisible = true
            (sender as AnyObject).setTitle("Create New Account", for: .normal)
            self.loginViewTopConstraint.constant = 60
            self.registerTopConstraint.constant = 1000
        }
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        })
        for item in self.warningLB {
            item.isHidden = true
        }
    }
    
    @IBAction func signin(_ sender: Any) {
        


        
        for item in self.inputFields {
            item.resignFirstResponder()
        }
        //self.showLoading(state: true)
        User.loginUser(withEmail: self.loginEmail.text!, password: self.loginPassword.text!) { [weak weakSelf = self](status) in
            DispatchQueue.main.async {
                //weakSelf?.showLoading(state: false)
                for item in self.inputFields {
                    item.text = ""
                }
                if status == true {
                    weakSelf?.pushTomainView()
                } else {
                    for item in (weakSelf?.warningLB)! {
                        item.isHidden = false
                    }
                }
                weakSelf = nil
            }
        }
        
    }
    
    @IBAction func register(_ sender: Any) {
        
        
        for item in self.inputFields {
            item.resignFirstResponder()
        }
        
        User.registerUser(withName: self.registerName.text!, email: self.registerEmail.text!, password: self.registerPassword.text!, profilePic: #imageLiteral(resourceName: "email")) { [weak weakSelf = self] (status) in
            DispatchQueue.main.async {
               // weakSelf?.showLoading(state: false)
                for item in self.inputFields {
                    item.text = ""
                }
                if status == true {
                    weakSelf?.pushTomainView()
                   // weakSelf?.profilePicView.image = UIImage.init(named: "profile pic")
                } else {
                    for item in (weakSelf?.warningLB)! {
                        item.isHidden = false
                    }
                }
            }
        }
        
    }
    
    func pushTomainView() {
        self.loginPassword.text = ""
        self.loginEmail.text = ""
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Tab") as! TabController
        self.show(vc, sender: nil)
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
