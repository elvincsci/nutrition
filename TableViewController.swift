//
//  TableViewController.swift
//  nutrition
//
//  Created by elvin on 4/17/18.
//  Copyright © 2018 elvin. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController{

    
    var videos = [Video]()
    @IBOutlet var tableView2: UITableView!
    
    var lastContentOffset: CGFloat = 0.0
    
    
    func customization() {
        self.tableView2.contentInset = UIEdgeInsetsMake(50, 0, 30, 0)
        self.tableView2.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 30, 0)
        self.tableView2.rowHeight = UITableViewAutomaticDimension
        self.tableView2.estimatedRowHeight = 300
    }
    
    
    
    func fetchData() {
        
        Video.downloadAllMessages(completion: {[weak weakSelf = self] (video) in
            
            //            print("hererer")
            //            print(video.content)
            //            print(video.videoLink)
            
            weakSelf?.videos.append(video)
            weakSelf?.tableView.reloadData()
            
            
            //weakSelf?.videos.sort{ $0.timestamp < $1.timestamp }
            
            //            DispatchQueue.main.async {
            //
            //                if let state = weakSelf?.videos.isEmpty, state == false {
            //
            //                    weakSelf?.tableView.reloadData()
            //
            //
            //                }
            //            }
            //
            
        })
    }
    
    
    //MARK: Delegates
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return 5
        return self.videos.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell") as! NewsListTableViewCell
        cell.set(video: self.videos[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("clicked on")
        //NotificationCenter.default.post(name: NSNotification.Name("open"), object: nil)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (self.lastContentOffset > scrollView.contentOffset.y) {
            NotificationCenter.default.post(name: NSNotification.Name("hide"), object: false)
        } else {
            NotificationCenter.default.post(name: NSNotification.Name("hide"), object: true)
        }
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.lastContentOffset = scrollView.contentOffset.y;
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source


    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
