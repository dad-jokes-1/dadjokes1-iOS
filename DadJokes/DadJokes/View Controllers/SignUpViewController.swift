//
//  SignUpViewController.swift
//  DadJokes
//
//  Created by John Kouris on 12/18/19.
//  Copyright © 2019 John Kouris. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    
    @IBOutlet private weak var firstNameTextField: UITextField!
    @IBOutlet private weak var lastNameTextField: UITextField!
    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var signUpButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    func setupViews() {
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(usernameTextField)
        Utilities.styleFilledButton(signUpButton)
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
            let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
            !email.isEmpty,
            !password.isEmpty else {
                self.presentDJAlertOnMainThread(title: "Error Signing Up", message: DJError.emptyEmailAndPasswordSignUp.rawValue, buttonTitle: "Ok")
                return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { _, error in
            if error != nil {
                if let errCode = AuthErrorCode(rawValue: error!._code) {
                    switch errCode {
                    case .invalidEmail:
                        self.presentDJAlertOnMainThread(title: "Error Signing Up", message: DJError.invalidEmail.rawValue, buttonTitle: "Ok")
                    case .emailAlreadyInUse:
                        self.presentDJAlertOnMainThread(title: "Error Signing Up", message: DJError.emailAlreadyInUse.rawValue, buttonTitle: "Ok")
                        self.emailTextField.text = ""
                    default:
                        self.presentDJAlertOnMainThread(title: "Error Signing Up", message: DJError.generalSignUpError.rawValue, buttonTitle: "Ok")
                    }
                }
            } else {
                Auth.auth().signIn(withEmail: email, password: password) { _, error in
                    if error == nil {
                        guard let privateJokesController = self.storyboard?.instantiateViewController(withIdentifier: "PrivateJokesVC") as? PrivateJokesTableViewController else { return }
                        self.navigationController?.pushViewController(privateJokesController, animated: true)
                        self.view.window?.makeKeyAndVisible()
                    }
                }
            }
        }
    }

}
