//
//  MoreViewController.swift
//  nutrition
//
//  Created by elvin on 11/26/17.
//  Copyright © 2017 elvin. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    
    //@IBOutlet var tableView: UITableView!
    var videos = [Video]()
    var lastContentOffset: CGFloat = 0.0
    
    
    //MARK: Methods
//    func customization() {
//        self.tableView.contentInset = UIEdgeInsetsMake(50, 0, 30, 0)
//        self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 30, 0)
//        self.tableView.rowHeight = UITableViewAutomaticDimension
//        self.tableView.estimatedRowHeight = 300
//    }
//
    
    //    func fetchData() {
    //        Video.fetchVideos { [weak self] response in
    //            guard let weakSelf = self else {
    //                return
    //            }
    //            weakSelf.videos = response
    //            //weakSelf.videos.shuffle()
    //            weakSelf.tableView.reloadData()
    //        }
    //    }
    
    
    //MARK: Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell") as! NewsListTableViewCell
        //cell.set(video: self.videos[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NotificationCenter.default.post(name: NSNotification.Name("open"), object: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (self.lastContentOffset > scrollView.contentOffset.y) {
            NotificationCenter.default.post(name: NSNotification.Name("hide"), object: false)
        } else {
            NotificationCenter.default.post(name: NSNotification.Name("hide"), object: true)
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.lastContentOffset = scrollView.contentOffset.y;
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.customization()
        //self.fetchData()
        
        // Do any additional setup after loading the view.
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


//class NewsFeedCell: UITableViewCell {
//
//    @IBOutlet var videoThumbnail: UIImageView!
//    @IBOutlet var titleLB: UILabel!
//    @IBOutlet var descriptionLB: UILabel!
//
//    func set(video: Video)  {
//        //self.videoThumbnail.image = video.thumbnail
//        self.titleLB.text = video.title
//        self.descriptionLB.text = "Hallo"
//    }
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//       // postTitle.sizeToFit()
//    }
//
//    override func prepareForReuse() {
//        super.prepareForReuse()
//
//        self.videoThumbnail.image = UIImage.init(named: "emptyTumbnail")
//        self.titleLB.text = nil
//        self.descriptionLB.text = nil
//
//    }
//
////    override func awakeFromNib() {
////        super.awakeFromNib()
////    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }
//
//    
//
//}
//
//
//

