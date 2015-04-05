//
//  ListTableViewController.swift
//  catalogo
//
//  Created by Francisco on 28/12/14.
//  Copyright (c) 2014 Cuatroo. All rights reserved.
//

import UIKit
import CoreData

class ListTableViewController: UITableViewController {

    var myList : Array<AnyObject> = []
    
    override func viewDidAppear(animated: Bool) {
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let cntxt: NSManagedObjectContext = appDel.managedObjectContext!
        let freq = NSFetchRequest(entityName: "List")
        
        myList = cntxt.executeFetchRequest(freq, error: nil)!
       
        tableView.reloadData()
    }
    
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    if segue.identifier == "update"{
    
        var selectedItem: NSManagedObject = myList[self.tableView.indexPathForSelectedRow()!.row] as NSManagedObject
        
        let IVC: ItemViewController = segue.destinationViewController as ItemViewController
        
        IVC.item = selectedItem.valueForKey("item") as String
        IVC.quantity = selectedItem.valueForKey("quantity") as String
        IVC.info = selectedItem.valueForKey("details") as String
        IVC.existingItem = selectedItem
        
        }
    
            
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return myList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var data : NSManagedObject = myList[indexPath.row] as NSManagedObject
        
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
        cell.textLabel?.text = (data.valueForKey("item") as String)
        
        var details = data.valueForKey("details") as String
        var qty = data.valueForKey("quantity") as String
        cell.detailTextLabel?.text = "\(details) - \(qty)"

        return cell
    }


    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let cntxt: NSManagedObjectContext = appDel.managedObjectContext!

        
        
        
        if editingStyle == .Delete {
            // Delete the row from the data source
            
            cntxt.deleteObject(myList[indexPath.row] as NSManagedObject)
            myList.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
        
        var error: NSError? = nil
        if !cntxt.save(&error){
            abort()
        }
        
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
