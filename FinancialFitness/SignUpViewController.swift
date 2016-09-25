//
//  SignUpViewController.swift
//  FinancialFitness
//
//  Created by Ashish Mishra on 9/24/16.
//  Copyright © 2016 Ashish Mishra. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var firstname : UITextField!
    @IBOutlet var lastName : UITextField!
    @IBOutlet var emailId : UITextField!
    @IBOutlet var phoneNumber : UITextField!
    @IBOutlet var password : UITextField!
    
    var currentTextField : UITextField = UITextField()
    let forceClient : ForceClient = ForceClient()
    
    let currentUser = User()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        self.currentTextField = textField
        
        if self.currentTextField.isFirstResponder() {
            self.currentTextField.resignFirstResponder()
        }
        
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if textField.tag == 10 {
            currentUser.firstName = textField.text;
        } else if textField.tag == 20 {
            currentUser.lastName = textField.text;

        } else if textField.tag == 30 {
            currentUser.emailId = textField.text;

        } else if textField.tag == 40 {
            currentUser.phoneNumber = textField.text;

        } else if textField.tag == 50 {
        }
    }
    
    @IBAction func signUp() {
        var parameters = ["FirstName" : currentUser.firstName!, "LastName"  : currentUser.lastName!, "Email" : currentUser.emailId!, "Phone" : currentUser.phoneNumber!]
        
        forceClient.signUpUserWithparameters(parameters) { (response, error) in
            print(response as! String)
            let responseString = response as! String;
            if  responseString  == "Success" {
                self.showAlert("Congratulations", message: "You signed up suceessfully.")
            }
        }
    }
    
    func showAlert(title : NSString, message : NSString) {
        let alertController = UIAlertController(title: title as String, message:message as String, preferredStyle: .Alert)
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}
