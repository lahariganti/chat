//
//  ChatVC.swift
//  chat
//
//  Created by Lahari Ganti on 2/15/19.
//  Copyright © 2019 Lahari Ganti. All rights reserved.
//

import UIKit
import Firebase

class ChatVC: UIViewController {

    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var chatTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutButtonPressed))
    }

    @objc func logoutButtonPressed() {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch {
            print(error)
        }
    }

    @objc func registerButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
}
