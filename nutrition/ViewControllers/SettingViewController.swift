//
//  SettingViewController.swift
//  nutrition
//
//  Created by elvin on 11/26/17.
//  Copyright © 2017 elvin. All rights reserved.
//

import UIKit
import QuickTableViewController
import Weakify
import SafariServices


class SettingViewController: QuickTableViewController {

    private final class CustomCell: UITableViewCell {}
    
    // MARK: - Properties
    
    
    private let debugging = Section(title: nil, rows: [])
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let time = #imageLiteral(resourceName: "iconmonstr-time")
        
        tableContents = [
        
            Section(title: "Navigation", rows: [
                
                NavigationRow(title: "Shop Collections", subtitle: .none, icon: Icon(image: #imageLiteral(resourceName: "device")), action: weakify(self, type(of: self).showShop)),
                
                NavigationRow(title: "Messages", subtitle: .none, icon: Icon(image: #imageLiteral(resourceName: "device")), action: weakify(self, type(of: self).showMessages)),
                
                NavigationRow(title: "Devices", subtitle: .none, icon: Icon(image: #imageLiteral(resourceName: "device")), action: weakify(self, type(of: self).showAddDevice)),
                
                NavigationRow(title: "Edit Profile", subtitle: .none, icon: Icon(image: #imageLiteral(resourceName: "profile")), action: weakify(self, type(of: self).showDetail)),
                
                ]),

            
            
            Section(title: "SECURITY", rows: [
                
                SwitchRow<SwitchCell>(title: "Use Touch ID", switchValue: false, icon: Icon(image: #imageLiteral(resourceName: "finger2")), action: weakify(self, type(of: self).didToggleSwitch)),

                NavigationRow(title: "Notification", subtitle: .none, icon: Icon(image: #imageLiteral(resourceName: "profile")), action: weakify(self, type(of: self).showDetail)),
                
                ]),

            Section(title: "Reminder", rows: [
                SwitchRow<SwitchCell>(title: "Checkup Reminder", switchValue: false, icon: Icon(image: time), action: weakify(self, type(of: self).didToggleSwitch))
                ]),
            
            Section(title: "", rows: [
                
                TapActionRow<TapActionCell>(title: "Logout", action: weakify(self, type(of: self).showAlert))
               
                ]),
        ]
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        // Alter the cells created by QuickTableViewController
        return cell
    }
    
    // MARK: - Private Methods
    
    private func didToggleSelection(_ sender: Row) {
        guard let option = sender as? OptionRow else {
            return
        }
        
        let state = "\(option.title) is " + (option.isSelected ? "selected" : "deselected")
        print(state)
    }
    
    private func didToggleSwitch(_ sender: Row) {
        
        // Turn touch id on.

        if let row = sender as? SwitchRow {
            let state = "\(row.title) = \(row.switchValue)"
            print(state)
        }
    }
    
    private func showAlert(_ sender: Row) {
        
        User.logOutUser { (status) in
            if status == true {
                self.dismiss(animated: true, completion: nil)
            }
        }
     // let vc = self.storyboard?.instantiateViewController(withIdentifier: "login") as! loginVC
    //    self.present(vc, animated: false, completion: nil)
    }
    
    private func showDetail(_ sender: Row) {
        let detail = "\(sender.title)\(sender.subtitle?.text ?? "")"
        let controller = UIViewController()
        controller.view.backgroundColor = UIColor.white
        controller.title = detail
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
    private func showAddDevice(_ sender: Row) {
        
        let detail = "\(sender.title)\(sender.subtitle?.text ?? "")"
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "device") as! deviceViewController
        controller.view.backgroundColor = UIColor.white
        controller.title = detail
        navigationController?.pushViewController(controller, animated: true)
        
    }
    
    // messages page
    private func showMessages(_ sender: Row) {
        
        let detail = "\(sender.title)\(sender.subtitle?.text ?? "")"
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "message") as! MessagesVC
        controller.view.backgroundColor = UIColor.gray
        controller.title = detail
        controller.tabBarController?.tabBar.isHidden = true
        
        navigationController?.pushViewController(controller, animated: true)
    
    
    }
    
    //shop
    private func showShop(_ sender: Row) {
        
        let svc = SFSafariViewController(url: NSURL(string: "https://heatmarketplace.com/products/")! as URL )
        present(svc, animated: true, completion: nil)

    }

    
    
    
    
}

