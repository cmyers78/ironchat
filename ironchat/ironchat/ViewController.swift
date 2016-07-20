//
//  ViewController.swift
//  ironchat
//
//  Created by Christopher Myers on 7/19/16.
//  Copyright © 2016 Dragoman Developers, LLC. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var loginEmailTextBox: UITextField!
    
    @IBOutlet weak var loginPWTextBox: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = FIRAuth.auth()?.currentUser {
            // User is signed in.
            self.performSegueWithIdentifier("welcomeSegue", sender: nil)
            print("I am signed in as user\(user.email)")
            
        } else {
            print("I am not signed in")
            
        }
        
        self.loginEmailTextBox.delegate = self
        self.loginPWTextBox.delegate = self
    }
    
    @IBAction func signOutTapped(sender: UIBarButtonItem) {
        
        self.signoutUser()
    }
    
    @IBAction func loginTapped(sender: UIButton) {
        if let signin = self.loginEmailTextBox.text {
            if let pw = self.loginPWTextBox.text {
                self.signinUser(signin, password: pw)
                
            }
            
        }
    }
    
    @IBAction func registerTapped(sender: UIButton) {
        
        performSegueWithIdentifier("registerSegue", sender: nil)
        
    }
    
    @IBAction func unwindSegue (segue : UIStoryboardSegue)  {
    
    }

//    func createUser(email : String, password: String) {
//        
//        FIRAuth.auth()?.createUserWithEmail(email, password: password) {
//            
//            (user, error) in
//            
//            if error != nil {
//                print(error?.localizedDescription)
//                self.alerts("Alert!", message: "Please enter a valid email address and password")
//                
//            }
//            
//            if let user = user {
//                print(user.uid)
//                print("Successfuly created user \(email)")
//            }
//            // ...
//        }
//    }

    func signoutUser() {
        try! FIRAuth.auth()!.signOut()
        print("You have signed out")
    }
    
    func signinUser(email: String, password: String) {
        FIRAuth.auth()?.signInWithEmail(email, password: password) {
            
            (user, error) in
            
            // do catch needed??
            
            if error != nil {
                self.alerts("Alert", message: "User not found. Please register")
                print(error?.localizedDescription)
                return
            }
            
            if let user = user {
                print("\(user.email) is signed in!")
                self.performSegueWithIdentifier("welcomeSegue", sender: self)
            }
        }
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == self.loginEmailTextBox {
            self.loginPWTextBox.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func alerts(title : String, message : String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        
        let cancelAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {
            (action : UIAlertAction!) -> Void in
        })
        
        alertController.addAction(cancelAction)
        
        dispatch_async(dispatch_get_main_queue(), {
            self.presentViewController(alertController, animated: true, completion:  nil)
                    
                    })
        

    }

}

