//
//  UserTableViewCell.swift
//  GitHub Users
//
//  Created by Maks Kokos on 21.11.2022.
//

import UIKit

final class UserTableViewCell: UITableViewCell {
    
    static let cellId = "UserTableViewCell"
    
    var loginLabel: UILabel = {
       let label = UILabel()
        label.text = "User Name"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    var idLabel: UILabel = {
        let label = UILabel()
        label.text = "Subtitle Label"
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    private let stackView: UIStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let infoImage: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "info.circle")
        image.tintColor = .accentGreen
        return image
    }()
    
    var avatarImage: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 35
        return image
    }()
    
    private let cellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .backgroundCustomBlack
        view.layer.cornerRadius = 20
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .backgroundDarkGray
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(cellView)
        cellView.addSubview(avatarImage)
        cellView.addSubview(infoImage)
        cellView.addSubview(loginLabel)
        stackView.addArrangedSubview(loginLabel)
        stackView.addArrangedSubview(idLabel)
        cellView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            cellView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            cellView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        
        avatarImage.widthAnchor.constraint(equalToConstant: 70).isActive = true
        avatarImage.heightAnchor.constraint(equalToConstant: 70).isActive = true
        avatarImage.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        avatarImage.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 18).isActive = true
        
        infoImage.widthAnchor.constraint(equalToConstant: 24).isActive = true
        infoImage.heightAnchor.constraint(equalToConstant: 24).isActive = true
        infoImage.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        infoImage.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -24).isActive = true
        
        stackView.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 18).isActive = true
        stackView.trailingAnchor.constraint(equalTo: infoImage.leadingAnchor, constant: -18).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        

    }
    
        
    
}
