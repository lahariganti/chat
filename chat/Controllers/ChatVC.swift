//
//  ChatVC.swift
//  chat
//
//  Created by Lahari Ganti on 2/15/19.
//  Copyright © 2019 Lahari Ganti. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {

    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var chatTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutButtonPressed))
    }

    @objc func logoutButtonPressed() {
        print("user has logged out")
        dismiss(animated: true, completion: nil)
    }

    @objc func registerButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
}
