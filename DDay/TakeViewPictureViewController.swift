//
//  TakeViewPictureViewController.swift
//  DDay
//
//  Created by Mayes, Arthur E. on 11/17/15.
//  Copyright © 2015 Accenture. All rights reserved.
//

import UIKit

class TakeViewPictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var chosenImage: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        let alert = UIAlertController.init(title:"What would you like to do?", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        let action1 = UIAlertAction.init(title: "Take Photo", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
            let picker = UIImagePickerController.init()
            picker.sourceType = UIImagePickerControllerSourceType.Camera
            picker.delegate = self
            picker.allowsEditing = true
            self.presentViewController(picker, animated: true, completion: nil)
        }
        let action2 = UIAlertAction.init(title: "See All Photos", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
            let picker = UIImagePickerController.init()
            picker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
            picker.delegate = self
            picker.allowsEditing = true
            self.presentViewController(picker, animated: true, completion: nil)
        }
        let action3 = UIAlertAction.init(title: "Cancel", style: UIAlertActionStyle.Cancel) { (UIAlertAction) -> Void in
            
        }
        alert.addAction(action1)
        alert.addAction(action2)
        alert.addAction(action3)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        chosenImage.image = image
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        
        let imageData = UIImagePNGRepresentation(image)
        let directory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first! as NSString
        let pathComponent = directory.stringByAppendingPathComponent("newImage")
        imageData?.writeToFile(pathComponent, atomically: false)
        
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
