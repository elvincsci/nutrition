//
//  dashboardVC.swift
//  nutrition
//
//  Created by elvin on 12/1/17.
//  Copyright © 2017 elvin. All rights reserved.
//

import UIKit

class dashboardVC: UINavigationController {
    
    @IBOutlet weak var waterLabel: UILabel!

    @IBOutlet weak var waterPic: RoundedImageView!
    @IBOutlet var contactsView: UIView!
    let darkView = UIView.init()
    @IBOutlet weak var weightLabel: UILabel!
    var topAnchorContraint: NSLayoutConstraint!
    @IBOutlet weak var foodLabel: UILabel!
    
    @IBOutlet weak var weightPic: RoundedImageView!
    @IBOutlet weak var exercisePic: RoundedImageView!
    @IBOutlet weak var exerciseLabel: UILabel!
    @IBOutlet weak var foodPic: RoundedImageView!
    

    
    
    func customization() {
        
        //Water image
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(addWaterTapped(tapGestureRecognizer:)))
        self.waterPic.isUserInteractionEnabled = true
        self.waterPic.addGestureRecognizer(tapGestureRecognizer)
        
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(addWeightTapped(tapGestureRecognizer:)))
        self.weightPic.isUserInteractionEnabled = true
        self.weightPic.addGestureRecognizer(tapGestureRecognizer2)
        
        let tapGestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(addExerciseTapped(tapGestureRecognizer:)))
        self.exercisePic.isUserInteractionEnabled = true
        self.exercisePic.addGestureRecognizer(tapGestureRecognizer3)
        
        let tapGestureRecognizer4 = UITapGestureRecognizer(target: self, action: #selector(addFoodTapped(tapGestureRecognizer:)))
        self.foodPic.isUserInteractionEnabled = true
        self.foodPic.addGestureRecognizer(tapGestureRecognizer4)
        
        //DarkView customization
        self.view.addSubview(self.darkView)
        self.darkView.backgroundColor = UIColor.black
        self.darkView.alpha = 0
        self.darkView.translatesAutoresizingMaskIntoConstraints = false
        self.darkView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.darkView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.darkView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.darkView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.darkView.isHidden = true
        
        //ContainerView customization
        let extraViewsContainer = UIView.init()
        extraViewsContainer.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(extraViewsContainer)
        self.topAnchorContraint = NSLayoutConstraint.init(item: extraViewsContainer, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 1000)
        self.topAnchorContraint.isActive = true
        extraViewsContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        extraViewsContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        extraViewsContainer.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1).isActive = true
        extraViewsContainer.backgroundColor = UIColor.clear
        //ContactsView customization
        
        extraViewsContainer.addSubview(self.contactsView)
        self.contactsView.translatesAutoresizingMaskIntoConstraints = false
        self.contactsView.topAnchor.constraint(equalTo: extraViewsContainer.topAnchor).isActive = true
        self.contactsView.leadingAnchor.constraint(equalTo: extraViewsContainer.leadingAnchor).isActive = true
        self.contactsView.trailingAnchor.constraint(equalTo: extraViewsContainer.trailingAnchor).isActive = true
        self.contactsView.bottomAnchor.constraint(equalTo: extraViewsContainer.bottomAnchor).isActive = true
        self.contactsView.isHidden = true
        //self.collectionView?.contentInset = UIEdgeInsetsMake(10, 0, 0, 0)
        self.contactsView.backgroundColor = UIColor.clear
        
        
        //self.profilePicView.layer.borderColor = GlobalVariables.purple.cgColor
        //self.profilePicView.layer.borderWidth = 3
   
        //NotificationCenter for showing extra views
        NotificationCenter.default.addObserver(self, selector: #selector(self.showExtraViews(notification:)), name: NSNotification.Name(rawValue: "showExtraView"), object: nil)
    
    }
    
    func dismissExtraViews() {
        self.topAnchorContraint.constant = 1000
        self.tabBarController?.tabBar.isHidden = false
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
            self.darkView.alpha = 0
            self.view.transform = CGAffineTransform.identity
        }, completion:  { (true) in
            self.darkView.isHidden = true
            self.contactsView.isHidden = true
            let vc = self.viewControllers.last
            vc?.inputAccessoryView?.isHidden = false
        })

    }
    
    
    
    @objc func showExtraViews(notification: NSNotification)  {
        
        let transform = CGAffineTransform.init(scaleX: 1.00, y: 1.00)
        self.topAnchorContraint.constant = 0
        self.darkView.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
        if let type = notification.userInfo?["viewType"] as? ShowExtraView {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
                self.darkView.alpha = 0.8
                if (type == .contacts || type == .profile) {
                    self.view.transform = transform
                }
            })
            switch type {
            case .contacts:
                self.contactsView.isHidden = false
            case .profile: break
                //self.profileView.isHidden = false
            case .preview: break
            case .map: break
            }
        }
        
    }

    @IBAction func closeView(_ sender: Any) {
        self.dismissExtraViews()
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
    

    
    @objc func addWaterTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        self.dismissExtraViews()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "dailyActivities") as! waterViewController
        self.show(vc, sender: self)

    }
    

    @objc func addFoodTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        // let tappedImage = tapGestureRecognizer.view as! UIImageView
        // Your action
        
        self.dismissExtraViews()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "addFood") as! FoodViewController
        vc.view.backgroundColor = UIColor.white
        //vc.title = "Devices"
        self.show(vc, sender: nil)
    }
    
    @objc func addExerciseTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        // let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        self.dismissExtraViews()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "addExercise") as! ExerciseViewController
        vc.view.backgroundColor = UIColor.white
        //vc.title = "Devices"
        self.show(vc, sender: nil)
        
        // Your action
    }
    
    
    @objc func addWeightTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        self.dismissExtraViews()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "device") as! deviceViewController
        vc.view.backgroundColor = UIColor.white
        vc.title = "Devices"
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
