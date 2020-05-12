//
//  ViewController.swift
//  onTheMap
//
//  Created by Mohamed Abdelkhalek Salah on 5/3/20.
//  Copyright © 2020 Mohamed Abdelkhalek Salah. All rights reserved.
//

import UIKit
import MapKit

class LoginViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: LoginButton!
    @IBOutlet var activityIndecator: UIActivityIndicatorView!
    @IBOutlet var signUpButton: UIButton!
    
    let signUpLink = "https://auth.udacity.com/sign-up?next=https://classroom.udacity.com/authenticated"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
     
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    func setLoggingIn(_ loggingIn: Bool) {
        loggingIn ? activityIndecator.startAnimating() : activityIndecator.stopAnimating()
        
        emailTextField.isEnabled = !loggingIn
        passwordTextField.isEnabled = !loggingIn
        loginButton.isEnabled = !loggingIn
        signUpButton.isEnabled = !loggingIn
    }


    @IBAction func signUpPressed(_ sender: Any) {
        UIApplication.shared.open(URL(string:signUpLink)!, options: [:], completionHandler: nil)
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        setLoggingIn(true)
        OTMClient.login(username: emailTextField.text ?? "", password: passwordTextField.text ?? "") { (success, error) in
            if success {
                self.setLoggingIn(false)
                self.performSegue(withIdentifier: "loginComplete", sender: nil)
            } else {
                self.setLoggingIn(false)
                self.showAlertError(title: "Something Wrong!", message: error?.localizedDescription ?? "try again")
            }
        }
    }
}
