//
//  TableViewCells.swift
//  Shopping List
//
//  Created by Julia Potapenko on 10/31/16.
//  Copyright © 2016 Julia Potapenko. All rights reserved.
//

import Foundation
import UIKit

protocol ItemTableViewCellDelegate: class {
    func didFinishTextEditing(sender: ItemTableViewCell)
}

class ItemTableViewCell: UITableViewCell, UITextFieldDelegate {
    @IBOutlet var label: UILabel!
    var editTextField: UITextField!
    
    var delegate: ItemTableViewCellDelegate?
    
    var checked = false {
        didSet {
            self.accessoryType = checked ? .Checkmark : .None
            self.label.textColor = checked ? UIColor.lightGrayColor() : UIColor.darkTextColor()
        }
    }
    
    func switchToEditMode() {
        label.hidden = true
        editTextField = UITextField(frame: label.frame)
        editTextField.delegate = self
        editTextField.text = label.text!
        self.addSubview(editTextField)
        editTextField.becomeFirstResponder()
        delegate?.didFinishTextEditing(self)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if let text = editTextField.text {
            if text != "" {
                label.text = text
            }
        }
        editTextField.removeFromSuperview()
        label.hidden = false
        editTextField.resignFirstResponder()
        return true
    }
}

protocol AddItemTableViewCellDelegate: class {
    func didFinishTextEntering(sender: AddItemTableViewCell)
}

class AddItemTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet var textField: UITextField!
    
    var delegate: AddItemTableViewCellDelegate?
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        delegate?.didFinishTextEntering(self)
        return true
    }
}

