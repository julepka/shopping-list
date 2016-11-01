//
//  TableViewCells.swift
//  Shopping List
//
//  Created by Julia Potapenko on 10/31/16.
//  Copyright © 2016 Julia Potapenko. All rights reserved.
//

import Foundation
import UIKit

class ItemTableViewCell: UITableViewCell {
    @IBOutlet var label: UILabel!
    
    var checked = false {
        didSet {
            self.accessoryType = checked ? .Checkmark : .None
        }
    }
}

protocol AddItemTableViewCellDelegate: class {
    func didFinishTextEditing(sender: AddItemTableViewCell)
}

class AddItemTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet var textField: UITextField!
    
    var delegate: AddItemTableViewCellDelegate?
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        delegate?.didFinishTextEditing(self)
        return true
    }
    
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem  = UIBarButtonItem(title: "Close", style: .Plain, target: self, action: #selector(doneButtonAction))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        textField.inputAccessoryView = doneToolbar
    }
    
    func doneButtonAction() {
        self.textField.text = ""
        self.textField.resignFirstResponder()
    }
}