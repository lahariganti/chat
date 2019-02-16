//
//  RegisterVC.swift
//  chat
//
//  Created by Lahari Ganti on 2/14/19.
//  Copyright © 2019 Lahari Ganti. All rights reserved.
//

import UIKit
import Firebase

class RegisterVC: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordtextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        passwordtextField.isSecureTextEntry = true
        registerButton.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)
    }

    @objc func registerButtonPressed() {
        if let email = emailTextField.text, let password = passwordtextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                if error != nil {
                    print(error!)
                } else {
                    print("registeration successful")
                    self.navigationController?.pushViewController(ChatVC(), animated: true)
                }
            }
        }   
    }
}
