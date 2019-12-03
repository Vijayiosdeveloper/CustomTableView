//
//  ViewController.swift
//  CustomTableView
//
//  Created by Vijay Kumar Thota on 11/27/19.
//  Copyright © 2019 Vijay Kumar Thota. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CustomTableViewCellProtocol {
    
    var settings : [Setting] = [Setting]()
    var tableView : UITableView = UITableView(frame: .zero, style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let navigationController = self.navigationController {
            navigationController.navigationBar.isTranslucent = false
            navigationController.navigationBar.barTintColor = .blue
        }
        
        let leftButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel))
        let rightButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(done))
        self.navigationItem.leftBarButtonItem = leftButton
        self.navigationItem.rightBarButtonItem = rightButton
        
        self.title = "Settings"
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.view.addSubview(tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
        
        settings.append(Setting(name: "City", value: "Lewis Center", identifier: "city", detailText : "Mid town"))
        settings.append(Setting(name: "State", value: "Ohio", identifier: "state", detailText : "Dry state"))
        settings.append(Setting(name: "Country", value: "United States", identifier: "country", detailText : "North America"))
        
        self.tableView.reloadData()
        
        let views = ["tableView" : self.tableView]
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[tableView]-0-|", options:.alignAllCenterX , metrics: nil, views: views)
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[tableView]-0-|", options:.alignAllCenterY , metrics: nil, views: views)
        self.view.addConstraints(horizontalConstraints)
        self.view.addConstraints(verticalConstraints)
    }

    @objc func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func done() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        let item = settings[indexPath.row]
        cell.setting = item
        cell.tag = indexPath.row
        cell.setupSegmentControl()
        cell.delegate = self
        cell.configureConstraints()
        return cell
    }
    
    func textFieldEditing(value: String?, forKey: String) {
        switch forKey {
        case "city":
            UserDefaults.standard.set("text", forKey: forKey)
        default:
            break
        }
    }

}

