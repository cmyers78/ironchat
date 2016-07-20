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
            print("I am signed in as user\(user.email)")
            //self.signoutUser()
        } else {
            print("I am not signed in")
            
        }
        
        //self.createUser("libby.myers@gmail.com", password: "hannahlily2@")
        
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

    func createUser(email : String, password: String) {
        
        FIRAuth.auth()?.createUserWithEmail(email, password: password) {
            
            (user, error) in
            
            if error != nil {
                print(error?.localizedDescription)
                
            }
            
            if let user = user {
                print(user.uid)
                print("Successfuly created user \(email)")
            }
            // ...
        }
    }

    func signoutUser() {
        try! FIRAuth.auth()!.signOut()
        print("You have signed out")
    }
    
    func signinUser(email: String, password: String) {
        FIRAuth.auth()?.signInWithEmail(email, password: password) {
            
            (user, error) in
            
            if error != nil {
                print(error?.localizedDescription)
            }
            
            if let user = user {
                print("\(user.email) is signed in!")
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

}
