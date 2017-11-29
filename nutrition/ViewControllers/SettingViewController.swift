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


class SettingViewController: QuickTableViewController {

    private final class CustomCell: UITableViewCell {}
    
    // MARK: - Properties
    
    
    private let debugging = Section(title: nil, rows: [])
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let time = #imageLiteral(resourceName: "iconmonstr-time")
        
        tableContents = [
        
            
            Section(title: "SECURITY", rows: [

                
                SwitchRow<SwitchCell>(title: "Use Touch ID", switchValue: false, icon: Icon(image: #imageLiteral(resourceName: "finger2")), action: weakify(self, type(of: self).didToggleSwitch))

                
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
        showDebuggingText(state)
    }
    
    private func didToggleSwitch(_ sender: Row) {
        
        // Turn touch id on.
        
        if let row = sender as? SwitchRow {
            let state = "\(row.title) = \(row.switchValue)"
            print(state)
            showDebuggingText(state)
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
        showDebuggingText(detail + " is selected")
    }
    
    private func showDebuggingText(_ text: String) {
        debugging.footer = text
        let indexSet: IndexSet? = tableContents.index(where: { $0 === debugging }).map { [$0] }
        tableView.reloadSections(indexSet ?? [], with: .fade)
    }
    
}

