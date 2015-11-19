//
//  DealerLinkedInViewController.swift
//  DDay
//
//  Created by Terry Wang on 11/19/15.
//  Copyright © 2015 Accenture. All rights reserved.
//

import UIKit

class DealerLinkedInViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    
    var urlString:String! 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = NSURL(string: self.urlString)
        //let url = NSURL(string: "http://www.google.com")
     
        self.webView.loadRequest(NSURLRequest(URL: url!))
        // Do any additional setup after loading the view.
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
