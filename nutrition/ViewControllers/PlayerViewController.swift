//
//  PlayerViewController.swift
//  nutrition
//
//  Created by elvin on 4/23/18.
//  Copyright © 2018 elvin. All rights reserved.
//

import UIKit

class PlayerViewController: UIViewController {

    @IBOutlet weak var myWebView: UIWebView!
    
    var someString: String?

    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        if let range = someString!.range(of: "v=") {
            let videoID = someString![range.upperBound...]
            getVideo(videoCode: String(videoID)) // prints "123.456.7891"
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func getVideo(videoCode:String)
    {
        let url = URL(string: "https://www.youtube.com/embed/\(videoCode)")
        myWebView.loadRequest(URLRequest(url: url!))
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
