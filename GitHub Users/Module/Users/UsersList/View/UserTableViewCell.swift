//
//  UserTableViewCell.swift
//  GitHub Users
//
//  Created by Maks Kokos on 21.11.2022.
//

import UIKit

final class UserTableViewCell: UITableViewCell {
    
    static let cellId = "UserTableViewCell"
    
    let userAvatar: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 35
        return image
    }()
    
    let userLogin: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    let userId: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    private let userNameStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let infoImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "info.circle")
        image.tintColor = .accentGreen
        return image
    }()
    
    private let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = .backgroundCustomBlack
        view.layer.cornerRadius = 20
        return view
    }()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .backgroundDarkGray
        configureUserCellLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    private func configureUserCellLayout() {
        setupUserCellConstraints()
        setupUserAvatarConstraints()
        setupInfoImageConstraints()
        setupUserNameStackViewConstraints()
    }
    
    private func setupUserCellConstraints() {
        addSubview(cellView)
        cellView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            cellView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            cellView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func setupUserAvatarConstraints() {
        cellView.addSubview(userAvatar)
        userAvatar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userAvatar.widthAnchor.constraint(equalToConstant: 70),
            userAvatar.heightAnchor.constraint(equalToConstant: 70),
            userAvatar.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
            userAvatar.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 18)
        ])
    }
    
    private func setupUserNameStackViewConstraints() {
        cellView.addSubview(userNameStackView)
        userNameStackView.addArrangedSubview(userLogin)
        userNameStackView.addArrangedSubview(userId)
        userNameStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userNameStackView.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
            userNameStackView.leadingAnchor.constraint(equalTo: userAvatar.trailingAnchor, constant: 18),
            userNameStackView.trailingAnchor.constraint(equalTo: infoImage.leadingAnchor, constant: -18),
            userNameStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupInfoImageConstraints() {
        cellView.addSubview(infoImage)
        infoImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoImage.widthAnchor.constraint(equalToConstant: 24),
            infoImage.heightAnchor.constraint(equalToConstant: 24),
            infoImage.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
            infoImage.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -24)
        ])
    }
}
