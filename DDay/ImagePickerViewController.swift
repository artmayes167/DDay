//
//  ImagePickerViewController.swift
//  DDay
//
//  Created by Mayes, Arthur E. on 11/17/15.
//  Copyright © 2015 Accenture. All rights reserved.
//

import UIKit

class ImagePickerViewController: UIImagePickerController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.sourceType = UIImagePickerControllerSourceType.Camera
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
