//
//  LogInViewController.swift
//  SmartCooler
//
//  Created by Mayes, Arthur E. on 11/4/15.
//  Copyright © 2015 Mayes, Arthur E. All rights reserved.
//

import UIKit
import LocalAuthentication

class LogInViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //self.testFingerprint()
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
        
//        if emailTextField.text == "" || passwordTextField.text == "" {
//            let alert = UIAlertController.init(title: "Oops", message: "Please complete all fields to continue", preferredStyle: UIAlertControllerStyle.Alert)
//            let action = UIAlertAction.init(title: "Okay", style: UIAlertActionStyle.Cancel, handler: nil)
//            alert.addAction(action)
//            self.presentViewController(alert, animated: true, completion: nil)
//            return
//        }
        
        var valid = true
//        valid = emailTextField.text?.containsString("@")
        
        if valid {
            self.dismissViewControllerAnimated(true, completion: nil)
        } else {
//            let alert = UIAlertController.init(title: "Oops", message: "Please input a valid email address", preferredStyle: UIAlertControllerStyle.Alert)
//            let action = UIAlertAction.init(title: "Okay", style: UIAlertActionStyle.Cancel, handler: nil)
//            alert.addAction(action)
//            self.presentViewController(alert, animated: true, completion: nil)
//            return
        }
//        }
    }
    
    func testFingerprint() {
        let context = LAContext()
        var error : NSError?
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            if context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &error) {
                context.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason:"Authenticate for user log in", reply: { (success, err) -> Void in
                    if (err != nil) {
                        
                        var failureReason = ""
                        switch err!.code {
                        case LAError.AuthenticationFailed.rawValue:
                            failureReason = "Authentication failed"
                        case LAError.UserCancel.rawValue:
                            failureReason = ""
                        case LAError.SystemCancel.rawValue:
                            failureReason = "system canceled authentication"
                        case LAError.PasscodeNotSet.rawValue:
                            failureReason = "passcode not set"
                        case LAError.UserFallback.rawValue:
                            failureReason = ""
                        default:
                            failureReason = "Unable to authenticate user"
                        }
                        
                        if failureReason != "" {
                            let alert = UIAlertController.init(title: "Oops", message: "validation failed: \(failureReason).", preferredStyle: UIAlertControllerStyle.Alert)
                            let action = UIAlertAction.init(title: "Try Again", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) -> Void in
                                self.testFingerprint()
                            })
                            let action2 = UIAlertAction.init(title: "Okay", style: UIAlertActionStyle.Cancel, handler: nil)
                            alert.addAction(action)
                            alert.addAction(action2)
                            //self.presentViewController(alert, animated: true, completion: nil)
                            self.performSegueWithIdentifier("backToMainUnwind", sender: self)
                        }
                        
                    } else if success {
                        self.dismissViewControllerAnimated(true, completion: nil)
                    }
                })
            }  else {
                //get more information
                var reason = "Local Authentication not available"
                switch error!.code {
                case LAError.TouchIDNotAvailable.rawValue:
                    reason = "Touch ID not available on device"
                case LAError.TouchIDNotEnrolled.rawValue:
                    reason = "Touch ID is not enrolled yet"
                case LAError.PasscodeNotSet.rawValue:
                    reason = "Passcode not set"
                default: reason = "Authentication not available"
                }
                
                let alert = UIAlertController.init(title: "Error", message: "Touch ID fingerprint authentication is not available: \(reason).", preferredStyle: UIAlertControllerStyle.Alert)
                let action2 = UIAlertAction.init(title: "Okay", style: UIAlertActionStyle.Cancel, handler: nil)
                alert.addAction(action2)
                self.presentViewController(alert, animated: true, completion: nil)
            }
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
    
    override func segueForUnwindingToViewController(toViewController: UIViewController, fromViewController: UIViewController, identifier: String?) -> UIStoryboardSegue {
        if let id = identifier{
            if id == "backToMainUnwind" {
                let unwindSegue = FirstCustomSegueUnwind(identifier: id, source: fromViewController, destination: toViewController, performHandler: { () -> Void in
                    
                })
                return unwindSegue
            }
        }
        
        return super.segueForUnwindingToViewController(toViewController, fromViewController: fromViewController, identifier: identifier)!
    }

}
