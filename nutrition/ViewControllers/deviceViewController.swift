//
//  deviceViewController.swift
//  nutrition
//
//  Created by elvin on 3/1/18.
//  Copyright © 2018 elvin. All rights reserved.
//

import UIKit
import SafariServices
import Firebase



var urlLink : String?
var TokenStr : String?
var SecretStr : String?
var NokiaSecretStr : String?


struct userdata: Decodable {
    let TokenStr: String?
    let SecretStr: String?
}

struct Course: Decodable {
    let Status_Message: String?
    let Url_Link: String?
}



struct Weight_Json: Decodable {
    let Status_message: String?
    let Weight_Data: [Weight_Data]
}

struct Weight_Data: Decodable {
    let Weight_date: String?
    let Weight_kg: Float64?
}


func getQueryStringParameter(url: String, param: String) -> String? {
    guard let url = URLComponents(string: url) else { return nil }
    return url.queryItems?.first(where: { $0.name == param })?.value
}



class deviceViewController: UIViewController {

    var ref: DatabaseReference!

    
    @IBOutlet var labelNokia: UILabel!
    
    var authSession: SFAuthenticationSession?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet var synchda: UIButton!
    
    @IBAction func syncData(_ sender: Any) {
        
        
        let userID = Auth.auth().currentUser?.uid
        ref.child("users").child(userID!).child("Nokia credentials").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let NokiaSecretStr = value?["NokiaSecretStr"] as? String ?? ""
            let NokiaTokenStr = value?["NokiaTokenStr"] as? String ?? ""
            let NokiaUserID = value?["NokiaUserID"] as? String ?? ""

          //  let user = User(username: username)
            
            //print("",NokiaSecretStr)
            ///print("",NokiaTokenStr)
            //print("",NokiaUserID)
    
            let jsonUrlString = "http://localhost:8080/getweight" + "?SecretStr=" + NokiaSecretStr + "&TokenStr=" + NokiaTokenStr + "&UserID=" + NokiaUserID
            
            
            print(jsonUrlString)
            
            guard let url = URL(string: jsonUrlString) else { return }

            URLSession.shared.dataTask(with: url) { (data, response, err) in

                guard let data = data else { return }


                if(err != nil){
                    print("error")
                }else{

                    do {

                        //let courses = try JSONDecoder().decode(Course.self, from: data)
                        let animeJsonStuff =  try JSONDecoder().decode(Weight_Json.self, from: data)

                        print("-------- ---- ", animeJsonStuff.Status_message!)
                        
                        //print("-------- ---- ",animeJsonStuff.Weight_Data[1].Weight_date!)

    
                        DispatchQueue.main.async {
                            
                            for jsonMedia in animeJsonStuff.Weight_Data {
                                
                               // print("-------- ---- ",jsonMedia.Weight_date!)
                                
                                self.ref = Database.database().reference()

                                let uid = Auth.auth().currentUser?.uid
                                
                                let Nokiacredentials = self.ref.child("users").child(uid!).child("Userweight").childByAutoId()

                                //let Nokiacredentials = self.ref.child("Userweight")

                                let NokiaSecretStr = Nokiacredentials.child("UserDate")
                                NokiaSecretStr.setValue(jsonMedia.Weight_date!)

                                let NokiaTokenStr = Nokiacredentials.child("UserWeight")
                                NokiaTokenStr.setValue(jsonMedia.Weight_kg)
                                
                                
                            }
                        }

                    } catch let jsonErr {
                        print("Error serializing json:", jsonErr)
                    }

                }

                }.resume()


            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        
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
            
        
            let callbackUrl  = "nutritions://"
            let authURL = urlLink!

            //Initialize auth session
            self.authSession = SFAuthenticationSession(url: URL(string: authURL)!, callbackURLScheme: callbackUrl, completionHandler: { (callBack:URL?, error:Error? ) in

                guard error == nil, let successURL = callBack else {
                    print(error!)
                    //self.cookieLabel.text = "Error retrieving cookie"
                    return
                }
        
                let userids = getQueryStringParameter(url: (successURL.absoluteString), param: "userid")
                let oauth_verifier = getQueryStringParameter(url: (successURL.absoluteString), param: "oauth_verifier")
                
                // get method to get the token secret and
                      let jsonUrlStrings = "http://localhost:8080/example" + "?userid=" + userids! + "&oauth_verifier=" + oauth_verifier!
                
                            guard let url = URL(string: jsonUrlStrings) else { return }
                
                            URLSession.shared.dataTask(with: url) { (data, response, err) in
                
                                guard let data = data else { return }
                
                                if(err != nil){
                                    print("error")
                                }else{
                
                                    do {
                
                                        let user_data = try JSONDecoder().decode(userdata.self, from: data)
                
                                        DispatchQueue.main.async {
                                        
                                            SecretStr = user_data.SecretStr
                                            TokenStr = user_data.TokenStr
                                            
                                            self.ref = Database.database().reference()
                                            
                                            let uid = Auth.auth().currentUser?.uid
                                            let Nokiacredentials = self.ref.child("users").child(uid!).child("Nokia credentials")
                                            
                                            let NokiaUserID = Nokiacredentials.child("NokiaUserID")
                                            NokiaUserID.setValue(userids)
                                            
                                            let NokiaSecretStr = Nokiacredentials.child("NokiaSecretStr")
                                            NokiaSecretStr.setValue(SecretStr)

                                            let NokiaTokenStr = Nokiacredentials.child("NokiaTokenStr")
                                            NokiaTokenStr.setValue(TokenStr)
                                            
                                            self.labelNokia.text = "Access granted"
                                            
                                            self.synchda.isEnabled = true

                                        }
                
                                    } catch let jsonErr {
                                        print("Error serializing json:", jsonErr)
                                    }
                
                                }
                
                                }.resume()

            })

            self.authSession?.start()
            
            
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

