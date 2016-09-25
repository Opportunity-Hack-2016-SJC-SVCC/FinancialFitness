//
//  LoginViewController.swift
//  FinancialFitness
//
//  Created by Ashish Mishra on 9/24/16.
//  Copyright © 2016 Ashish Mishra. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var topLayoutConstraint : NSLayoutConstraint!
    @IBOutlet var loginField : GSTextField!
    @IBOutlet var passwordField : GSTextField!
    var isKeyboardPresent : Bool?
    var currentTextField : UITextField = UITextField()
    
    var forceClient = ForceClient()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginViewController.keyboardWillShow(_:)), name:UIKeyboardWillShowNotification, object: nil)
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginViewController.keyboardWillHide(_:)), name:UIKeyboardWillHideNotification, object: nil)
        
        self.loginField.attributedPlaceholder = NSAttributedString(string:"Username",
                                                                   attributes:[NSForegroundColorAttributeName: UIColor.lightGrayColor()])
        
        self.passwordField.attributedPlaceholder = NSAttributedString(string:"Password",
                                                                      attributes:[NSForegroundColorAttributeName: UIColor.lightGrayColor()])
        
        self.loginField.leftTextMargin = 30;
        self.passwordField.leftTextMargin = 30;
        self.loginField.layoutIfNeeded()
        self.passwordField.layoutIfNeeded()


        // Do any additional setup after loading the view.
    }
    
//    func keyboardWillShow(notification:NSNotification){
//        
//        if self.isKeyboardPresent == true {
//            return
//        }
//        
//        var userInfo = notification.userInfo!
//        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue()
//        keyboardFrame = self.view.convertRect(keyboardFrame, fromView: nil)
//        self.topLayoutConstraint.constant -= keyboardFrame.height
//        self.isKeyboardPresent = true
//    }
//    
//    func keyboardWillHide(notification:NSNotification){
//        var userInfo = notification.userInfo!
//        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue()
//        keyboardFrame = self.view.convertRect(keyboardFrame, fromView: nil)
//        self.topLayoutConstraint.constant += keyboardFrame.height
//        self.isKeyboardPresent = false
//    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        self.currentTextField = textField
        
        if self.currentTextField.isFirstResponder() {
            self.currentTextField.resignFirstResponder()
        }
        return true
    }
    
    @IBAction func login() {
        
        var userEmail = self.loginField.text;
        
        forceClient.validateLogin(userEmail!) { (response, error) in
            let result = response as! String
            print(response)
            self.performSegueWithIdentifier(Constants.LOGIN_TO_QUESTION_SEGUE, sender: nil)
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let segueIdentifier = segue.identifier
        if (segueIdentifier == Constants.LOGIN_TO_QUESTION_SEGUE) {
            let questionViewController = segue.destinationViewController as! QuestionViewController
        }
    }
}
