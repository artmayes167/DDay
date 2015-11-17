//
//  SecondCustomSegue.swift
//  DDay
//
//  Created by Terry Wang on 11/17/15.
//  Copyright © 2015 Accenture. All rights reserved.
//

import UIKit

class SecondCustomSegue: UIStoryboardSegue {
    override func perform() {
        let firstVCView = sourceViewController.view as UIView!
        let thirdVCView = destinationViewController.view as UIView!
        
        let window = UIApplication.sharedApplication().keyWindow
        window?.insertSubview(thirdVCView, belowSubview: firstVCView)
        
        thirdVCView.transform = CGAffineTransformScale(thirdVCView.transform, 0.001, 0.001)
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            
            firstVCView.transform = CGAffineTransformScale(thirdVCView.transform, 0.001, 0.001)
            
            }) { (Finished) -> Void in
                
                UIView.animateWithDuration(1.5, animations: { () -> Void in
                    thirdVCView.transform = CGAffineTransformIdentity
                    
                    }, completion: { (Finished) -> Void in
                        
                        firstVCView.transform = CGAffineTransformIdentity
                        self.sourceViewController.presentViewController(self.destinationViewController as UIViewController, animated: false, completion: nil)
                })
        }
    }
}
