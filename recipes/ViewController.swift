//
//  ViewController.swift
//  recipes
//
//  Created by mobileapps on 5/21/16.
//  Copyright © 2016 mobileapps. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var listTable: UITableView!
    @IBOutlet weak var add: UIBarButtonItem!
    
    var lists : [Entity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Entity")
        var results: [AnyObject]?
//        let delete = NSBatchDeleteRequest(fetchRequest: fetchRequest)
//        
//        do {
//            try managedContext.executeRequest(delete)
//        } catch {
//            print(error)
//        }
        do {
            results = try managedContext.executeFetchRequest(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        if results != nil {
            self.lists = results as! [Entity]
            self.listTable.reloadData()
            print(lists)
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let currentCell = tableView.dequeueReusableCellWithIdentifier("myCell")!
        let currentList = lists[indexPath.row]
        currentCell.textLabel?.text = currentList.valueForKey("name") as? String
        currentCell.detailTextLabel?.text = currentList.valueForKey("address") as? String
        return currentCell
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete){
            if let table = listTable {
                let appDelegate: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
                let context:NSManagedObjectContext = appDelegate.managedObjectContext
                context.deleteObject(lists[indexPath.row])
                lists.removeAtIndex(indexPath.row)
                do {
                    try context.save()
                } catch {
                    print("delete failed")
                }
                table.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }
    @IBAction func addButton(sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "New Website", message: "Enter New Website", preferredStyle: .Alert)
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.placeholder = "enter web name"
        })
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.placeholder = "enter web address"
        })
        let textField = alert.textFields![0] as UITextField
        let textField1 = alert.textFields![1] as UITextField
        let finishAction = UIAlertAction(title: "OK", style: .Default) { (finish) -> Void in
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let managedContext = appDelegate.managedObjectContext
            let entities =  NSEntityDescription.insertNewObjectForEntityForName("Entity", inManagedObjectContext: managedContext) as! Entity
            entities.name = textField.text
            entities.address = textField1.text
            do {
                try managedContext.save()
                print("Item Saved")
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
            
            let entity = Entity()
            entity.name = textField.text!
            entity.address = textField1.text!
            self.lists.append(entity)
            self.listTable.reloadData()
        }
        
        alert.addAction(finishAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let NVC = segue.destinationViewController as! PresentViewController
        let currentRow = listTable.indexPathForSelectedRow?.row
        NVC.receive = lists[currentRow!]
    }
}

