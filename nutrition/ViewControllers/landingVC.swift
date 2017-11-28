//
//  ViewController.swift
//  nutrition
//
//  Created by elvin on 11/25/17.
//  Copyright © 2017 elvin. All rights reserved.
//

import UIKit

class landingVC: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        super.viewDidAppear(animated)
        if let userInformation = UserDefaults.standard.dictionary(forKey: "userInformation") {
            let email = userInformation["email"] as! String
            let password = userInformation["password"] as! String
            User.loginUser(withEmail: email, password: password, completion: { (status) in
                DispatchQueue.main.async {
                    if status == true {
                        //weakSelf?.pushTo(viewController: .conversations)
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Tab") as! TabController
                        self.present(vc, animated: false, completion: nil)
                    } else {
                        //weakSelf?.pushTo(viewController: .welcome)
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "login") as! loginVC
                        self.present(vc, animated: false, completion: nil)
                        
                    }
                    //weakSelf = nil
                }
            })
        } else {
           // self.pushTo(viewController: .welcome)
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "login") as! loginVC
            self.present(vc, animated: false, completion: nil)
        }

    }
    
//    func pushTo(viewController: ViewControllerType)  {
//        switch viewController {
//        case .conversations:
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Tab") as! TabController
//            self.present(vc, animated: false, completion: nil)
//        case .welcome:
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "login") as! loginVC
//            self.present(vc, animated: false, completion: nil)
//        }
//    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }


}

