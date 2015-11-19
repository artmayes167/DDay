//
//  FinancialPlansViewController.swift
//  DDay
//
//  Created by Mayes, Arthur E. on 11/10/15.
//  Copyright © 2015 Mayes, Arthur E. All rights reserved.
//

import UIKit

class FinancialPlansViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewWidth: NSLayoutConstraint!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tableTitleLabel: UILabel!
    
    var sortedFiancials = [String]()
    
    @IBOutlet weak var financialTitleLabel: UILabel!
    let items = ["Operating Leases", "Capital Leases", "Cost-Per-Test", "Step Payments", "Deferred Payments", "Progress Payments", "Software Financing", "Customized Solutions"]
    
    var shouldSeeDetail = false
    let isIphone = UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var myDict: NSDictionary?
        if let path = NSBundle.mainBundle().pathForResource("Financials", ofType: "plist") {
            myDict = NSDictionary(contentsOfFile: path)
        }
        
        let financialsArray = myDict?.allKeys as! [String]
        self.sortedFiancials = financialsArray.sort { $0.localizedCaseInsensitiveCompare($1) == NSComparisonResult.OrderedAscending }
        
        
        
        print("sorted:\(self.sortedFiancials)")

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.prepareInterface()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        if UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone {
            if shouldSeeDetail {
                tableViewWidth.constant = 0
                tableTitleLabel.hidden = true
            } else {
                if ((tableViewWidth) != nil) {
                    tableViewWidth.constant = size.width
                    tableTitleLabel.hidden = false
                }
            }
        } else {
            if ((tableViewWidth) != nil) {
                tableViewWidth.constant = size.width/3
                tableTitleLabel.hidden = false
            }
        }
        
        coordinator.animateAlongsideTransition({ (UIViewControllerTransitionCoordinatorContext) -> Void in
            self.view.layoutIfNeeded()
            }, completion: nil)
    }
    
    func prepareInterface() {
        if isIphone {
            tableViewWidth.constant = self.view.frame.size.width
        } else {
            tableViewWidth.constant = self.view.frame.size.width
        }
        self.view.layoutIfNeeded()
    }
    
    
    @IBAction func back(sender: AnyObject) {
        tableViewWidth.constant = self.view.frame.size.width
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.view.layoutIfNeeded()
            }) { (Bool) -> Void in
                self.backButton.hidden = true
                self.financialTitleLabel.hidden = true
                self.tableTitleLabel.hidden = false
        }
    }
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sortedFiancials.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell")!
        cell.textLabel?.text = self.sortedFiancials[indexPath.row];
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if isIphone {
            tableViewWidth.constant = 0
            tableView.deselectRowAtIndexPath(indexPath, animated: false)
//            UIView.animateWithDuration(0.3, animations: { () -> Void in
//                self.view.layoutIfNeeded()
//                }) { (Bool) -> Void in
//                    self.backButton.hidden = false
//                    self.financialTitleLabel.hidden = false
//            }
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                self.view.layoutIfNeeded()
                }, completion: { (Bool) -> Void in
                    self.backButton.hidden = false
                    self.financialTitleLabel.hidden = false
                    self.tableTitleLabel.hidden = true
            })
        }
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
