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

        let vc = self.storyboard?.instantiateViewController(withIdentifier: "login") as! loginVC
        self.present(vc, animated: false, completion: nil)

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }


}

