//
//  ViewController.swift
//  Shopping List
//
//  Created by Julia Potapenko on 10/31/16.
//  Copyright © 2016 Julia Potapenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AddItemTableViewCellDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    var data = ["first item", "second item", "third item"]

    override func viewDidLoad() {
        super.viewDidLoad()
        let center: NSNotificationCenter = NSNotificationCenter.defaultCenter()
        center.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        center.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row < data.count {
            let cell = tableView.dequeueReusableCellWithIdentifier("ItemTableViewCell") as! ItemTableViewCell
            cell.label.text = data[indexPath.row]
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("AddItemTableViewCell") as! AddItemTableViewCell
            cell.delegate = self
            cell.addDoneButtonOnKeyboard()
            return cell
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count + 1
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.row < data.count {
            let cell = tableView.cellForRowAtIndexPath(indexPath) as! ItemTableViewCell
            cell.checked = !cell.checked
        }
    }
    
    func didFinishTextEditing(sender: AddItemTableViewCell) {
        data.append(sender.textField.text!)
        tableView.beginUpdates()
        tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: data.count-1, inSection: 0)], withRowAnimation: .Automatic)
        tableView.endUpdates()
        sender.textField.text = ""
        self.tableView.scrollRectToVisible(sender.frame, animated: true)
        //sender.textField.resignFirstResponder()
    }
    
    func keyboardWillShow(notification: NSNotification) {
        let keyboardSize = (notification.userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue()
        let firstResponder = UIResponder.getCurrentFirstResponder() as! UIView
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        self.tableView.contentInset = contentInsets
        self.tableView.scrollIndicatorInsets = contentInsets
        var aRect = self.view.frame
        aRect.size.height -= keyboardSize.height
        if !CGRectContainsPoint(aRect, firstResponder.frame.origin) {
            self.tableView.scrollRectToVisible(firstResponder.frame, animated: true)
        }
        
    }
    
    func keyboardWillHide(aNotification: NSNotification) {
        let contentInsets = UIEdgeInsetsZero
        self.tableView.contentInset = contentInsets
        self.tableView.scrollIndicatorInsets = contentInsets
    }
}
