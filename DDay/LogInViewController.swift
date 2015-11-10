//
//  LogInViewController.swift
//  SmartCooler
//
//  Created by Mayes, Arthur E. on 11/4/15.
//  Copyright © 2015 Mayes, Arthur E. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    var shouldLogIn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        switch textField {
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            logIn(self)
        default:
            break
        }
        return true
    }
    
    @IBAction func logIn(sender : AnyObject) {
        
        if emailTextField.text == "" || passwordTextField.text == "" {
            let alert = UIAlertController.init(title: "Oops", message: "Please complete all fields to continue", preferredStyle: UIAlertControllerStyle.Alert)
            let action = UIAlertAction.init(title: "Okay", style: UIAlertActionStyle.Cancel, handler: nil)
            alert.addAction(action)
            self.presentViewController(alert, animated: true, completion: nil)
            return
        }
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        var pass = emailTextField.text == defaults.valueForKey("email") as? String
        if pass {
            pass = passwordTextField.text == defaults.valueForKey("password") as? String
        }
        if pass {
            shouldLogIn = true
//            self.performSegueWithIdentifier("unwindToRegistration", sender: self)
            self.dismissViewControllerAnimated(true, completion: nil)
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
