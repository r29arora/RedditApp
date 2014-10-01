//
//  LoginViewController.swift
//  RedditApplication
//
//  Created by Rajul Arora on 2014-09-24.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

import UIKit



class LoginViewController: UIViewController {
    
    //MARK: Class Variables
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    //MARK: Load View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
        
        let tapAction:Selector = "didTapView"
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: tapAction))
    }
    
    func didTapView(){
        if (usernameTextField.isFirstResponder()){
            usernameTextField.resignFirstResponder()
        }
        else if (passwordTextField.isFirstResponder()){
            passwordTextField.resignFirstResponder()
        }
    }
    @IBAction func loginButtonTapped(sender: AnyObject) {
        self.validateInputs()
    }
    
    func validateInputs(){
        if (usernameTextField.text.isEmpty){
            println("Enter a username")
        }
        else if (passwordTextField.text.isEmpty){
            println("Enter a Password")
        }
    }
    
}
