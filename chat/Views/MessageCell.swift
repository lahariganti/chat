//
//  MessageCell.swift
//  chat
//
//  Created by Lahari Ganti on 2/16/19.
//  Copyright © 2019 Lahari Ganti. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var senderNameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var messageBackgroundView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
