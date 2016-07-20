//
//  RegisterViewController.swift
//  ironchat
//
//  Created by Christopher Myers on 7/19/16.
//  Copyright © 2016 Dragoman Developers, LLC. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var continueButton: UIButton!

    @IBOutlet weak var emailTextField: UITextField!

    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    
    
    
    
    @IBAction func registerTapped(sender: UIButton) {
        
        if let email = self.emailTextField.text {
            if let password = self.passwordTextField.text {
                self.createUser(email, password: password)
            }
            self.continueButton.hidden = false
        }
    }
    
    
    func createUser(email : String, password: String) {
        
        FIRAuth.auth()?.createUserWithEmail(email, password: password) {
            
            (user, error) in
            
            if error != nil {
                print(error?.localizedDescription)
                self.alerts("Alert!", message: "Please enter a valid email address and password")
                
            }
            
            if let user = user {
                print(user.uid)
                print("Successfuly created user \(email)")
            }
        }
    }
    
    func alerts(title : String, message : String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        
        let cancelAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {
            (action : UIAlertAction!) -> Void in
        })
        
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true, completion:  nil)
        
    }

}
