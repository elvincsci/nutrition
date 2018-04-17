//
//  FoodViewController.swift
//  nutrition
//
//  Created by elvin on 4/4/18.
//  Copyright © 2018 elvin. All rights reserved.
//

import UIKit

class FoodViewController: UIViewController {

    
    
    @IBOutlet weak var viewContainer: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Food"
        
        
        let controller = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "water")
        controller.view.frame = self.view.bounds;
        controller.willMove(toParentViewController: self)
        viewContainer.addSubview(controller.view)
        self.addChildViewController(controller)
        controller.didMove(toParentViewController: self)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    @IBAction func SwitchControl(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            
            let controller = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "water")
            controller.view.frame = self.view.bounds;
            controller.willMove(toParentViewController: self)
            viewContainer.addSubview(controller.view)
            self.addChildViewController(controller)
            controller.didMove(toParentViewController: self)
        
            
            break
        case 1:
            
            let controller = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "meal")
            controller.view.frame = self.view.bounds;
            controller.willMove(toParentViewController: self)
            viewContainer.addSubview(controller.view)
            self.addChildViewController(controller)
            controller.didMove(toParentViewController: self)
            
            break
        default:
            
            break
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
