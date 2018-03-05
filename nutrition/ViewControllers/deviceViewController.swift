//
//  deviceViewController.swift
//  nutrition
//
//  Created by elvin on 3/1/18.
//  Copyright © 2018 elvin. All rights reserved.
//

import UIKit
import SafariServices

//struct  UrlResults: Decodable {
//    let Status_Message : String?
//    let Url_Link : String?
//}

var urlLink : String?

struct Course: Decodable {
//    let id: Int?
    let Status_Message: String?
    let Url_Link: String?
    
}



class deviceViewController: UIViewController {

    @IBOutlet var labelNokia: UILabel!
    
    var authSession: SFAuthenticationSession?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = true
        tabBarController?.tabBar.isHidden = true

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addButton(_ sender: Any) {
        
        let button = (sender as AnyObject)
       
        let current_Text = (sender as AnyObject).title(for: .normal)!
        
        if current_Text == "Add" {
            
            
            let jsonUrlString = "http://localhost:8080/geturl"
            guard let url = URL(string: jsonUrlString) else { return }
            
            URLSession.shared.dataTask(with: url) { (data, response, err) in
                
                guard let data = data else { return }
                
                
                if(err != nil){
                    print("error")
                }else{
                    
                    do {
                        
                        let courses = try JSONDecoder().decode(Course.self, from: data)
                        
                        
                        DispatchQueue.main.async {
                            self.labelNokia.text = courses.Url_Link
                            urlLink = courses.Url_Link
                            button.setTitle("Add now", for: .normal)
                            
                        }
                        
                    } catch let jsonErr {
                        print("Error serializing json:", jsonErr)
                    }
                    
                }
                
                }.resume()
            
            
        }else{
            
         //   print(urlLink!)
        
          //  let svc = SFSafariViewController(url: NSURL(string: urlLink!)! as URL )
          //  present(svc, animated: true, completion: nil)
            
            let callbackUrl  = "nutrition://"

            let authURL = urlLink!
            
            //let authURL = "http://0.0.0.0:5000/get-cookie/user?callbackUrl=" + callbackUrl
            //Initialize auth session
            self.authSession = SFAuthenticationSession(url: URL(string: authURL)!, callbackURLScheme: callbackUrl, completionHandler: { (callBack:URL?, error:Error? ) in
            
                guard error == nil, let successURL = callBack else {
                    print(error!)
                    //self.cookieLabel.text = "Error retrieving cookie"
                    return
                }
                print(successURL.absoluteURL)
             
               // let user = getQueryStringParameter(url: (successURL.absoluteString), param: "user")
               // self.cookieLabel.text = (user == "None") ? "user cookie not set" : "User: " + user!
            })
            
            self.authSession?.start()
            
        }
        
       // print((sender as AnyObject).title(for: .normal)!)
        
      //  button.title
        
        //button.setTitle("Your text", for: .normal)
        

        //print ((sender as AnyObject).text)



        
        
       // let te = Course.self
       // let aMirror = Mirror(reflecting: Course)

      //  var x = Course()

        
       // print(Status_Message)

       // labelNokia.text = urlLink as Any as? String
    
    }

    
    
//    func greetAgain(person: String) {
//
//    }
//
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
