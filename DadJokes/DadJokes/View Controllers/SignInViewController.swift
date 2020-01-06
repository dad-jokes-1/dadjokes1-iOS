//
//  SignInViewController.swift
//  DadJokes
//
//  Created by John Kouris on 12/18/19.
//  Copyright © 2019 John Kouris. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    func setupViews() {
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(signInButton)
    }
    
    @IBAction func signInButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
            let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
            !email.isEmpty,
            !password.isEmpty else {
                self.presentDJAlertOnMainThread(title: "Error Signing In", message: "Please provide your email and password before trying to sign in.", buttonTitle: "Ok")
                return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                if let errCode = AuthErrorCode(rawValue: error!._code) {
                    switch errCode {
                    case .invalidEmail:
                        self.presentDJAlertOnMainThread(title: "Error Signing In", message: "The email you entered was not correct. Please try again.", buttonTitle: "Ok")
                    case .wrongPassword:
                        self.presentDJAlertOnMainThread(title: "Error Signing In", message: "The password you entered was not correct. Please try again.", buttonTitle: "Ok")
                    default:
                        self.presentDJAlertOnMainThread(title: "Error Signing In", message: "The information you entered was not correct. Please enter your email and password.", buttonTitle: "Ok")
                    }
                }
                
                self.emailTextField.text = ""
                self.passwordTextField.text = ""
                self.emailTextField.becomeFirstResponder()
            } else {
                guard let privateJokesController = self.storyboard?.instantiateViewController(withIdentifier: "PrivateJokesVC") as? PrivateJokesTableViewController else { return }
                self.navigationController?.pushViewController(privateJokesController, animated: true)
                self.view.window?.makeKeyAndVisible()
            }
        }
        
    }

}
