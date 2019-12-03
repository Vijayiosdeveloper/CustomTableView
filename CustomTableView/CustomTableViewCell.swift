//
//  CustomTableViewCell.swift
//  CustomTableView
//
//  Created by Vijay Kumar Thota on 11/27/19.
//  Copyright © 2019 Vijay Kumar Thota. All rights reserved.
//

import Foundation
import UIKit

protocol CustomTableViewCellProtocol {
    func textFieldEditing(value: String?, forKey: String)
}

class CustomTableViewCell : UITableViewCell, UITextFieldDelegate {
    var setting: Setting? {
        didSet {
            
        }
    }
    
    var delegate : CustomTableViewCellProtocol?
    
    let nameLabel : UILabel = {
        let lbl = UILabel(frame: CGRect(x: 20, y: 15, width: 200, height: 20))
        lbl.textColor = .gray
        lbl.font = UIFont.boldSystemFont(ofSize: 11)
        lbl.textAlignment = .center
        return lbl
    }()
    
    let detailLabel : UILabel = {
        let lbl = UILabel(frame: CGRect(x: 20, y: 35, width: 200, height: 15))
        lbl.textColor = .gray
        lbl.font = UIFont.boldSystemFont(ofSize: 11)
        lbl.textAlignment = .center
        return lbl
    }()

    let inputText : UITextField = {
        let textField = UITextField(frame: CGRect(x: 200, y: 10, width: 60, height: 30))
        textField.textColor = .blue
        textField.textAlignment = .center
       return textField
    }()
    
    let segmentControl : UISegmentedControl = {
        let ctrl = UISegmentedControl(items: ["-", "", "+"])
        ctrl.frame = CGRect(x: 200, y: 10, width: 160, height: 30)
        return ctrl
    }()
    
    let stepper : UIStepper = {
       let stp = UIStepper(frame: CGRect(x: 270, y: 9, width: 40, height: 30))
        stp.autorepeat = true
        return stp
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        inputText.isHidden = true
        inputText.delegate = self
        self.contentView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(detailLabel)
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(inputText)
        inputText.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(segmentControl)
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureConstraints() {
        let metrics = ["height" : self.frame.size.height, "width": self.frame.size.width]
        let views = ["nameLabel" : nameLabel, "detailLabel": detailLabel, "segmentControl": segmentControl]
        self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[nameLabel]-8@750-[segmentControl]-10@1000-|", options: [], metrics: metrics, views: views))
        self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[detailLabel]-|", options: [], metrics: metrics, views: views))
        self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[nameLabel]-4-[detailLabel]-2-|", options: [], metrics: metrics, views: views))
        self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[segmentControl]-|", options: [], metrics: metrics, views: views))
        self.updateConstraintsIfNeeded()
    }
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        inputText.text = textField.text
        if let del = delegate, let identifier = self.setting?.identifier {
            del.textFieldEditing(value: inputText.text, forKey: identifier)
        }
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    @objc func stepperChanged(sender: UIStepper) {
        self.inputText.text = String(self.stepper.value)
        if let del = delegate, let identifier = self.setting?.identifier {
            del.textFieldEditing(value: self.inputText.text, forKey: identifier)
        }
    }
    
    @objc func segmentSelected(sender: UISegmentedControl) {
        if self.segmentControl.selectedSegmentIndex == 0 {
            switch self.tag {
            case 0:
                if let text = self.inputText.text, var value = Int(text) {
                    value = value - 1
                    self.inputText.text = String(value)
                }
            default:
                break
            }
        } else if self.segmentControl.selectedSegmentIndex == 2 {
            switch self.tag {
            case 0:
                if let text = self.inputText.text, var value = Int(text) {
                    value = value + 1
                    self.inputText.text = String(value)
                }
            default:
                break
            }
        } else {
            
        }
        
        if let del = delegate, let identifier = self.setting?.identifier {
            del.textFieldEditing(value: self.inputText.text, forKey: identifier)
        }
        
        self.segmentControl.selectedSegmentIndex = UISegmentedControl.noSegment
        self.segmentControl.setTitle(self.inputText.text, forSegmentAt: 1)
    }
    
    public func setupSegmentControl() {
        self.segmentControl.setTitle(self.inputText.text, forSegmentAt: 1)
    }
    
    
}
