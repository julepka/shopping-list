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
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row < data.count {
            let cell = tableView.dequeueReusableCellWithIdentifier("ItemTableViewCell") as! ItemTableViewCell
            cell.label.text = data[indexPath.row]
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("AddItemTableViewCell") as! AddItemTableViewCell
            cell.delegate = self
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
        sender.textField.resignFirstResponder()
    }
}

