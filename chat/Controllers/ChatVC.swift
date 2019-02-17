//
//  ChatVC.swift
//  chat
//
//  Created by Lahari Ganti on 2/15/19.
//  Copyright © 2019 Lahari Ganti. All rights reserved.
//

import UIKit
import Firebase
import ChameleonFramework

class ChatVC: UIViewController {
    var messages: [Message] = [Message]()

    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var chatTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var chatTextFieldBackgroundHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutButtonPressed))
        chatTextField.delegate = self
        chatTableView.delegate = self
        chatTableView.dataSource = self

        chatTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "messageCell")
        chatTableView.isUserInteractionEnabled = true
        chatTableView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(chatTableViewTapped)))
        sendButton.addTarget(self, action: #selector(sendButtonPressed), for: .touchUpInside)

        fetchMessages()
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

    @objc func chatTableViewTapped() {
        chatTextField.endEditing(true)
    }

    @objc func sendButtonPressed() {
        chatTextField.endEditing(true)
        chatTextField.isEnabled = false
        sendButton.isEnabled = false

        let messagesDB = Database.database().reference().child("messages")
        if let text = chatTextField.text {
            let messageDictionary = ["Sender": Auth.auth().currentUser?.email, "MessageBody": text]
            messagesDB.childByAutoId().setValue(messageDictionary) {
                (error, reference) in

                if error != nil {
                    print(error!)
                } else {
                    print("message saved successfully")
                    self.sendButton.isEnabled = true
                    self.chatTextField.isEnabled = true
                    self.chatTextField.text = ""
                }
            }
        }
    }

    func fetchMessages() {
        let messagesDB = Database.database().reference().child("messages")
        messagesDB.observe(.childAdded) { (snapshot) in
            let newMessage = Message()
            if let snapshotValue = snapshot.value as? [String: Any] {
                if let sender = snapshotValue["Sender"] as? String {
                    newMessage.sender = sender
                }
                if let messageBody = snapshotValue["MessageBody"] as? String {
                    newMessage.messageBody = messageBody
                }
            }
            self.messages.append(newMessage)
            self.chatTableView.reloadData()
        }
    }
}

extension ChatVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
}

extension ChatVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = chatTableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as! MessageCell
        cell.senderNameLabel.text = messages[indexPath.row].sender
        cell.messageLabel.text = messages[indexPath.row].messageBody
        cell.userImageView.image = UIImage(named: "egg")

        if cell.senderNameLabel.text == Auth.auth().currentUser?.email {
            cell.messageBackgroundView?.backgroundColor = UIColor.flatYellow()
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
}

extension ChatVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
         UIView.animate(withDuration: 0.5) {
            self.chatTextFieldBackgroundHeightConstraint.constant += 258
            self.view.layoutIfNeeded()
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5) {
            self.chatTextFieldBackgroundHeightConstraint.constant -= 258
            self.view.layoutIfNeeded()
        }
    }
}
