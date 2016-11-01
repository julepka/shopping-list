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
}