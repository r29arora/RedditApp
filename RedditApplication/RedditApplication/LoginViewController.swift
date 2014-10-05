//
//  LoginViewController.swift
//  RedditApplication
//
//  Created by Rajul Arora on 2014-09-24.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

import UIKit

let hud:JGProgressHUD = JGProgressHUD(style: JGProgressHUDStyle.Dark)

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: IB Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var lurkerButton: UIButton!
    
    //MARK: Class Variables
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    //MARK: Load View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapAction:Selector = "didTapView"
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: tapAction))
        
        self.registerForKeyboardNotifications()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        hud.dismissAfterDelay(0.5)
    }
    
    //MARK: Keyboard Notification Methods
    func registerForKeyboardNotifications(){
        var keyboardWillShowSelector:Selector = "keyboardWillShow:"
        var keyboardWillHideSelector:Selector = "keyboardWillHide:"
        NSNotificationCenter.defaultCenter().addObserver(self, selector: keyboardWillShowSelector, name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: keyboardWillHideSelector, name: UIKeyboardDidHideNotification, object: nil)
    }
    
    func keyboardWillShow(aNotification:NSNotification) -> Void {
        var info:NSDictionary = aNotification.userInfo!
        let kbSize:CGSize = info.objectForKey(UIKeyboardFrameBeginUserInfoKey)!.CGRectValue().size
        self.scrollView.contentInset = UIEdgeInsetsMake(0.0, 0.0, kbSize.height/2.0, 0.0)
    }
    
    func keyboardWillHide(aNotification:NSNotification) -> Void {
        self.scrollView.contentInset = UIEdgeInsetsZero
    }
    
    //MARK: Actions
    func didTapView(){
        self.view.endEditing(true)
    }
    
    @IBAction func loginButtonTapped(sender: AnyObject) {
        self.validateInputs()
    }
    
    @IBAction func lurkerButtonTapped(sender: AnyObject) {
        self.pushToContentViewController()
    }
    
    //MARK: Input Validation Methods
    func validateInputs(){
        if (self.usernameTextField.text.isEmpty){
            println("Enter a username")
        }
        else if (self.passwordTextField.text.isEmpty){
            println("Enter a Password")
        }
        else {
            RedditUser.sharedInstance.username = self.usernameTextField.text
            RedditUser.sharedInstance.password = self.passwordTextField.text
            
            let params = ["user": self.usernameTextField.text, "passwd":self.passwordTextField.text]
            var nsparams:NSDictionary = NSDictionary(dictionary: params)
            
            hud.showInView(self.view)
            RedditUser.login(nsparams, completion:{(error:NSError?) -> Void in
                if (error != nil){
                    println("Login Worked!")
                    RedditUser.sharedInstance.isLoggedIn = true
                    self.pushToContentViewController()
                }
                else{
                    println("Error: \(error?.localizedDescription)")
                }
                hud.dismissAfterDelay(0.5)
            })

        }
    }
    
    func isValidUsername(username:NSString) -> Bool {
        return (username.length > 6 || username.length < 20)
    }
    
    //MARK: Push to View Controller Methods
    func pushToContentViewController(){
        var contentView:ContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("contentView") as ContentViewController
        self.showViewController(contentView, sender: nil)
    }
    
}
