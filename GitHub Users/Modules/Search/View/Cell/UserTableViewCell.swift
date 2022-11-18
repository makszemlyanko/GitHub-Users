//
//  UserTableViewCell.swift
//  GitHub Users
//
//  Created by Maks Kokos on 18.11.2022.
//

import UIKit

final class UserTableViewCell: UITableViewCell {
    
    static var cellId = "UserTableViewCell"
    
    @IBOutlet weak var userAvatar: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var userSubtitle: UILabel!
    
    @IBOutlet weak var infoImage: UIImageView!
    
    
    
    
}
