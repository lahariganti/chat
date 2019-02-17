//
//  LoginVC.swift
//  chat
//
//  Created by Lahari Ganti on 2/15/19.
//  Copyright © 2019 Lahari Ganti. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class LoginVC: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.isSecureTextEntry = true
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
    }

    @objc func loginButtonPressed() {
        SVProgressHUD.show()
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                if error == nil {
                    SVProgressHUD.dismiss()
                    self.present(ChatVC(), animated: true, completion: nil)
                } else { 
                    print(error!)
                }
            }
        }
    }
}
