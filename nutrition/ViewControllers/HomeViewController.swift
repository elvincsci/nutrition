//
//  MoreViewController.swift
//  nutrition
//
//  Created by elvin on 11/26/17.
//  Copyright © 2017 elvin. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    var videos = [Video]()
    
    var lastContentOffset: CGFloat = 0.0
    

    func customization() {
        self.tableView.contentInset = UIEdgeInsetsMake(50, 0, 30, 0)
        self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 30, 0)
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 300
    }
    
    
    
    func fetchData() {
        
        Video.downloadAllMessages(completion: {[weak weakSelf = self] (video) in
            
            
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return 5
        return self.videos.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell") as! NewsListTableViewCell
        cell.set(video: self.videos[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("clicked on")
        
        print(self.videos[indexPath.row].content)
        
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "player") as! PlayerViewController
        
        controller.someString = self.videos[indexPath.row].videoLink.absoluteString
        
        navigationController?.pushViewController(controller, animated: true)

      //  controller.
        //NotificationCenter.default.post(name: NSNotification.Name("open"), object: nil)
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
        self.fetchData()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // Do any additional setup after loading the view.
        // Do any additional setup after loading the view.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


class NewsListTableViewCell: UITableViewCell {
    
    @IBOutlet var imageThumbnail: UIImageView!
    @IBOutlet var titleLB: UILabel!
    @IBOutlet var descriptionLB: UILabel!
    
    
    
    //    override func setSelected(_ selected: Bool, animated: Bool) {
    //
    //        super.setSelected(selected, animated: animated)
    //        // Configure the view for the selected state
    //        print("selected")
    //
    //    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageThumbnail.image = UIImage.init(named: "emptyTumbnail")
        //        self.durationLabel.text = nil
        //        self.channelPic.image = nil
        //        self.videoTitle.text = nil
        //        self.videoDescription.text = nil
    }
    
    func set(video: Video)  {
        self.imageThumbnail.image = video.thumbNailimage
        self.titleLB.text = video.content as? String
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
}


