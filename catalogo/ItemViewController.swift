//
//  ItemViewController.swift
//  catalogo
//
//  Created by Francisco on 28/12/14.
//  Copyright (c) 2014 Cuatroo. All rights reserved.
//

import UIKit
import CoreData

class ItemViewController: UIViewController {



    @IBOutlet var tfItem: UITextField!
    @IBOutlet var tfQty: UITextField!
    @IBOutlet var tfDetails: UITextField!
    
    
    var item: String = " "
    var quantity: String = " "
    var info: String=" "
    
    var existingItem: NSManagedObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (existingItem != nil){
            
            tfItem.text = item
            tfDetails.text=info
            tfQty.text=quantity
            
        }

        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func CancelAction(sender: AnyObject) {
        
        self.navigationController?.popToRootViewControllerAnimated(true)
        
    }
    
    
    @IBAction func SaveAction(sender: AnyObject) {
       
        //reference to app delegate
        
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        // reference moc
        
        let cntxt: NSManagedObjectContext = appDel.managedObjectContext!
        let en = NSEntityDescription.entityForName("List", inManagedObjectContext: cntxt)
        
        //check if item exists
        
        if (existingItem != nil){
            
            existingItem.setValue(tfItem.text as String, forKey: "item")
            existingItem.setValue(tfDetails.text as String, forKey: "details")
            existingItem.setValue(tfQty.text as String, forKey: "quantity")
            
            println(existingItem.description)
            
        }else{
            // instance of pur data model and intialize
            
            var newItem = Model(entity: en!, insertIntoManagedObjectContext: cntxt)
            
            //map properties
            
            newItem.item = tfItem.text
            newItem.details = tfDetails.text
            newItem.quantity = tfQty.text
            
            println(newItem.description)
            
        }
        
        
        //save context
        
        cntxt.save(nil)
               
        
        //navigate to root vc
        
        self.navigationController?.popToRootViewControllerAnimated(true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
