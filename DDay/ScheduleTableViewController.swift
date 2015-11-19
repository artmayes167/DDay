//
//  ScheduleTableViewController.swift
//  DDay
//
//  Created by Terry Wang on 11/18/15.
//  Copyright © 2015 Accenture. All rights reserved.
//

import UIKit
import EventKit


class ScheduleTableViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var startTimeDatePicker: UIDatePicker!
    
    @IBOutlet weak var endTimeDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        
        // set gradient background
        let colors = GradientColors()
        view.backgroundColor = UIColor.clearColor()
        let backgroundLayer = colors.gl
        backgroundLayer.frame = view.frame
        view.layer.insertSublayer(backgroundLayer, atIndex: 0)
        
        self.tableView.backgroundColor = UIColor.clearColor()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
    
    // Configure the cell...
    
    return cell
    }
    */
    
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
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    
    // MARK: - Tableview Delegates
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        self.titleTextField.resignFirstResponder()
    }
    
    /**
     * Called when the user click on the view (outside the UITextField).
     */
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.titleTextField.resignFirstResponder()
        return true
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.titleTextField.resignFirstResponder()
        self.view.endEditing(true)
    }
    
    
    @IBAction func doneButtonPressed(sender: UIBarButtonItem) {
        
        
        
        
        
        
        self.createEvent(self.titleTextField.text!, startDate: self.startTimeDatePicker.date, endDate: self.endTimeDatePicker.date, allDay: false, alertTime: 1000.0, task: "Appointment")
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    func createEvent(title: String, startDate : NSDate, endDate: NSDate, allDay: Bool, alertTime: NSTimeInterval, task: String) {
        let eventStore = EKEventStore()
        let event = EKEvent(eventStore: eventStore)
        
        event.title = title;
        event.startDate = startDate;
        event.endDate = endDate;
        event.allDay = allDay;
        
        if alertTime != 0 {
            let alarm = EKAlarm.init(relativeOffset: alertTime)
            event.alarms = [alarm]
        }
        
        eventStore.requestAccessToEntityType(EKEntityType.Event) {granted, error in
            if (error != nil) {
                
                
            } else if !granted {
                
            } else {
                
                
                
                
                
                event.calendar = eventStore.defaultCalendarForNewEvents
                do {
                    try eventStore.saveEvent(event, span: .ThisEvent)
                    
                    
                    
                    let alertController = UIAlertController(title: "Success", message: "Event Created!", preferredStyle: .Alert)
                    let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                        // ...
                    }
                    alertController.addAction(OKAction)
                    
                    
                    dispatch_async(dispatch_get_main_queue()) { [unowned self] in
                        self.presentViewController(alertController, animated: true, completion: nil)
                        //self.titleTextField.resignFirstResponder()
                    }
                    
                } catch {
                    print("Event Save Failed")
                }
            }
        }
        
    }
    
    
}
