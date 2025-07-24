//
//  UserTableViewCell.swift
//  UserDataTask
//
//  Created by Nanda Pradeesh on 23/07/25.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var customView: UIView!
   
    static let identifier = "UserTableViewCell"
    
    override func awakeFromNib() {
           super.awakeFromNib()
           
       }
    
    func configure(with user: User) {
        idLabel.text = "\(user.id)"
        nameLabel.text = user.name
        emailLabel.text = user.email
        genderLabel.text = "\(user.gender.capitalized)"
    }
}
