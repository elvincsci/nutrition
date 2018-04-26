//
//  MainViewController.swift
//  nutrition
//
//  Created by elvin on 11/26/17.
//  Copyright © 2017 elvin. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myDashboard") as! myDashboardTableViewCell
        
       // cell.set(video: self.videos[indexPath.row])
        return cell
    }
    

    @IBOutlet var container: UIView!
    var topAnchorContraint: NSLayoutConstraint!
    
    func customization() {
        //right bar button
        
        let icon = UIImage.init(named: "add1")?.withRenderingMode(.alwaysOriginal)
        let rightButton = UIBarButtonItem.init(image: icon!, style: .plain, target: self, action: #selector(MainViewController.showContacts))
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    //Shows profile extra view
    @objc func showProfile() {
        let info = ["viewType" : ShowExtraView.profile]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showExtraView"), object: nil, userInfo: info)
        self.inputView?.isHidden = true
    }
    
    
   // Shows contacts extra view
    @objc func showContacts() {
        let info = ["viewType" : ShowExtraView.contacts]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showExtraView"), object: nil, userInfo: info)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.customization()

        self.tableView.delegate = self
        self.tableView.dataSource = self
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


class myDashboardTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateLB: UILabel!
    @IBOutlet weak var valueLB: UILabel!
    @IBOutlet weak var typeLB: UILabel!
    
    
    
    //    override func setSelected(_ selected: Bool, animated: Bool) {
    //
    //        super.setSelected(selected, animated: animated)
    //        // Configure the view for the selected state
    //        print("selected")
    //
    //    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        //        self.durationLabel.text = nil
        //        self.channelPic.image = nil
        //        self.videoTitle.text = nil
        //        self.videoDescription.text = nil
    }
    
    func set(dash: dashboardValue)  {
        self.valueLB.text = dash.datapoint as? String
        self.typeLB.text = dash.type as? String
       // self.dateLB.text = dash.timestamp as? String

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
}

