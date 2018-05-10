//
//  MainViewController.swift
//  nutrition
//
//  Created by elvin on 11/26/17.
//  Copyright © 2017 elvin. All rights reserved.
//

import UIKit

class MainViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var dashboards = [dashboardValue]()

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dashboards.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myDashboard") as! myDashboardTableViewCell
        cell.set(dash: self.dashboards[indexPath.row])
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
    
    func fetchData() {
        
        dashboardValue.downloadAllMessages(completion: {[weak weakSelf = self] (video) in
            weakSelf?.dashboards.append(video)
            weakSelf?.tableView.reloadData()
            
            weakSelf?.dashboards.sort{ $0.timestamp > $1.timestamp }
            
            DispatchQueue.main.async {
                
                if let state = weakSelf?.dashboards.isEmpty, state == false {
                    
                    weakSelf?.tableView.reloadData()
                    
                    
                }
            }

        })

    }
    
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.customization()


        self.tableView.delegate = self
        self.tableView.dataSource = self
        // Do any additional setup after loading the view.
        self.fetchData()
        
        if self.dashboards.count == 0
        {
            
            
        }

    }

    override func viewDidDisappear(_ animated: Bool) {
        counter = 2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if counter == 2
        {
            dashboards.removeAll()
            self.fetchData()
        }
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

    @IBOutlet weak var activityTypeLB: UILabel!
    @IBOutlet weak var measurementTypeLB: UILabel!
    @IBOutlet weak var activityLB: UILabel!
    
    
    
    //    override func setSelected(_ selected: Bool, animated: Bool) {
    //
    //        super.setSelected(selected, animated: animated)
    //        // Configure the view for the selected state
    //        print("selected")
    //
    //    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.activityLB.text = "No results found"
    }
    
    func set(dash: dashboardValue)  {
        
        self.activityLB.text = dash.activity as? String
        self.activityTypeLB.text = dash.activitytype as? String
        self.valueLB.text = dash.datapoint.description
        self.measurementTypeLB.text = dash.measurementtype as? String
        
        
        let unixTimestamp = dash.timestamp
        let date = Date(timeIntervalSince1970: unixTimestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM-dd-yyyy"
        let strDate = dateFormatter.string(from: date)

        self.dateLB.text = strDate.description


    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
}

