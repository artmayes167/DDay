//
//  ProductTableViewController.swift
//  DDay
//
//  Created by Terry Wang on 11/19/15.
//  Copyright © 2015 Accenture. All rights reserved.
//

import UIKit

class ProductTableViewController: UITableViewController {

    
    var financialsDictionary:NSDictionary!
    var sortedFiancials = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        
        
        // set gradient background
        let colors = GradientColors()
        view.backgroundColor = UIColor.clearColor()
        let backgroundLayer = colors.gl
        backgroundLayer.frame = view.frame
        view.layer.insertSublayer(backgroundLayer, atIndex: 0)
        
        self.tableView.backgroundColor = UIColor.clearColor()
        
        
        
        if let path = NSBundle.mainBundle().pathForResource("Financials", ofType: "plist") {
            self.financialsDictionary = NSDictionary(contentsOfFile: path)
        }
        
        let financialsArray = financialsDictionary?.allKeys as! [String]
        self.sortedFiancials = financialsArray.sort { $0.localizedCaseInsensitiveCompare($1) == NSComparisonResult.OrderedAscending }
        
        print("sorted:\(self.sortedFiancials)")
        
        self.tableView.reloadData()
        
        
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
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.sortedFiancials.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ProductCell", forIndexPath: indexPath)
        
        cell.textLabel?.text = self.sortedFiancials[indexPath.row]
        cell.backgroundColor = UIColor.clearColor()

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "ShowProductDetails" {
            
            let indexPath = self.tableView.indexPathForSelectedRow
           
            let keyString = self.sortedFiancials[(indexPath?.row)!] as String
            
            //print(keyString)
            
            let detailsString = self.financialsDictionary.objectForKey(keyString) as! String
            
           print(detailsString)
            
            
        
            let vc = segue.destinationViewController as! ProductDetails
            
            vc.detailsString = detailsString
            
            
            
            
        }
        
        
    }
    

}
