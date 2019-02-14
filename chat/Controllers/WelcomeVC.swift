//
//  WelcomeVC.swift
//  chat
//
//  Created by Lahari Ganti on 2/13/19.
//  Copyright © 2019 Lahari Ganti. All rights reserved.
//

import UIKit

class WelcomeVC: UIViewController {
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        registerButton.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)
    }

    @objc func registerButtonPressed() {
        present(RegisterVC(), animated: true, completion: nil)
    }
}
