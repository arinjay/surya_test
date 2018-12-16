//
//  CustomTableViewCell.swift
//  Surya_test
//
//  Created by Arinjay on 10/12/18.
//  Copyright © 2018 Arinjay. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var userImage: UIImageView!{
        didSet{
            userImage.layer.cornerRadius = 1.0
            userImage.layer.borderWidth = 1.0
        }
    }
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var cellBackgroundView: UIView!{
        didSet{
            cellBackgroundView.layer.cornerRadius = 5.0
            cellBackgroundView.layer.borderWidth = 1.0
            cellBackgroundView.layer.borderColor = UIColor.black.cgColor
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
