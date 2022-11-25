//
//  UserDetailViewController.swift
//  GitHub Users
//
//  Created by Maks Kokos on 21.11.2022.
//

import UIKit
import Kingfisher
import SafariServices

final class UserDetailViewController: UIViewController {
    
    var userSearchName: String?

    private var userDetail: UserDetail! {
        didSet {
            guard let imageURL = URL(string: self.userDetail.avatarURL) else { return }
            DispatchQueue.main.async {
                self.userAvatar.kf.setImage(with: imageURL)
                self.userNameLabel.text = self.userDetail.name
                self.userLoginLabel.text = self.userDetail.login
                self.locationLabel.text = self.userDetail.location
                self.organizationLabel.text = self.userDetail.company
                self.emailLabel.text = self.userDetail.email
                self.followersLabel.text = "\(String(self.userDetail.followers)) followers"
                self.followingLabel.text = "\(String(self.userDetail.following)) following"
                self.registrationDate.text = "On GitHub since \(self.userDetail.createdAt.convertToDisplayFormat())"
                self.profileURL = self.userDetail.htmlUrl
            }
        }
    }
    
    private let followersLabel: UILabel = {
       let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private let followingLabel: UILabel = {
       let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    
    private let profileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Go to profile", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.titleLabel?.tintColor = .white
        button.layer.cornerRadius = 8
        button.backgroundColor = .accentGreen
        button.addTarget(self, action: #selector(didTapProfileButton), for: .touchUpInside)
        return button
    }()

    private var profileURL: String = {
        let url = String()
        return url
    }()
    
    @objc func didTapProfileButton() {
        let profileUrl = profileURL
        let vc = SFSafariViewController(url: URL(string: profileUrl)!)
        present(vc, animated: true)
    }

    private let locationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        return label
    }()


    
    private let organizationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let contactsStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    
    private let followersStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()
    

    
    
    private let userNameLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 22)
        return label
    }()
    
    private let userLoginLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    

    
    private let userAvatar: UIImageView = {
       let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "blankAva")
        image.clipsToBounds = true
        image.layer.cornerRadius = 60
        return image
    }()
    
    private let userCardView: UIView = {
       let view = UIView()
        view.backgroundColor = .backgroundCustomBlack
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let registrationDate: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.text = "on GitHub since November 25, 2009"
        label.textAlignment = .center
        label.textColor = .accentGreen
        return label
    }()
    
    private let gitHubBottomImage: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: "title")
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundDarkGray
        configureLayout()
        getDetailUserInfo()
    }
    
    func getDetailUserInfo() {
        APICaller.shared.getUserDetail(userName: userSearchName ?? "") { [weak self] result in
            switch result {
            case .success(let user):
                self?.userDetail = user
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func setupUserCardViewConstraints() {
        view.addSubview(userCardView)
        userCardView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userCardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            userCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            userCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            userCardView.heightAnchor.constraint(equalToConstant: 440)
        ])
    }
    
    private func setupUserImageConstraints() {
        userCardView.addSubview(userAvatar)
        userAvatar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userAvatar.widthAnchor.constraint(equalToConstant: 120),
            userAvatar.heightAnchor.constraint(equalToConstant: 120),
            userAvatar.centerXAnchor.constraint(equalTo: userCardView.centerXAnchor),
            userAvatar.topAnchor.constraint(equalTo: userCardView.topAnchor, constant: 24)
        ])
    }
    
    private func setupUserNameConstraints() {
        userCardView.addSubview(userNameLabel)
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userNameLabel.topAnchor.constraint(equalTo: userAvatar.bottomAnchor, constant: 24),
            userNameLabel.leadingAnchor.constraint(equalTo: userCardView.leadingAnchor, constant: 20),
            userNameLabel.trailingAnchor.constraint(equalTo: userCardView.trailingAnchor, constant: -20),
            userNameLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    private func setupLoginLabelConstraints() {
        userCardView.addSubview(userLoginLabel)
        userLoginLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userLoginLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 6),
            userLoginLabel.leadingAnchor.constraint(equalTo: userCardView.leadingAnchor, constant: 20),
            userLoginLabel.trailingAnchor.constraint(equalTo: userCardView.trailingAnchor, constant: -20),
            userLoginLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func setupContactsStackViewConstraints() {
        contactsStackView.translatesAutoresizingMaskIntoConstraints = false
        contactsStackView.addArrangedSubview(locationLabel)
        contactsStackView.addArrangedSubview(organizationLabel)
        contactsStackView.addArrangedSubview(emailLabel)
        view.addSubview(contactsStackView)
        NSLayoutConstraint.activate([
            contactsStackView.centerXAnchor.constraint(equalTo: userCardView.centerXAnchor),
            contactsStackView.topAnchor.constraint(equalTo: userLoginLabel.bottomAnchor, constant: 16),
            contactsStackView.widthAnchor.constraint(equalToConstant: 280)
        ])
    }
    
    private func setupProfileButtonConstraints() {
        profileButton.translatesAutoresizingMaskIntoConstraints = false
        userCardView.addSubview(profileButton)
        NSLayoutConstraint.activate([
            profileButton.topAnchor.constraint(equalTo: followersStackView.bottomAnchor, constant: 24),
            profileButton.centerXAnchor.constraint(equalTo: userCardView.centerXAnchor),
            profileButton.widthAnchor.constraint(equalToConstant: 140),
            profileButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupFollowersStackViewContraints() {
        followersStackView.translatesAutoresizingMaskIntoConstraints = false
        followersStackView.addArrangedSubview(followersLabel)
        followersStackView.addArrangedSubview(followingLabel)
        view.addSubview(followersStackView)
        NSLayoutConstraint.activate([
            followersStackView.topAnchor.constraint(equalTo: contactsStackView.bottomAnchor, constant: 16),
            followersStackView.centerXAnchor.constraint(equalTo: userCardView.centerXAnchor),
            followersStackView.widthAnchor.constraint(equalToConstant: 280)
        ])
    }
    
    private func setupRegistrationDateConstraints() {
        userCardView.addSubview(registrationDate)
        registrationDate.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            registrationDate.centerXAnchor.constraint(equalTo: userCardView.centerXAnchor),
            registrationDate.bottomAnchor.constraint(equalTo: userCardView.bottomAnchor, constant: -8),
            registrationDate.widthAnchor.constraint(equalToConstant: 200),
            registrationDate.heightAnchor.constraint(equalToConstant: 22)
        ])
    }
    
    private func setupGitHubBottomImageConstraints() {
        gitHubBottomImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(gitHubBottomImage)
        NSLayoutConstraint.activate([
            gitHubBottomImage.topAnchor.constraint(equalTo: userCardView.bottomAnchor, constant: 60),
            gitHubBottomImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gitHubBottomImage.widthAnchor.constraint(equalToConstant: 44),
            gitHubBottomImage.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func configureLayout() {
        setupUserCardViewConstraints()
        setupUserImageConstraints()
        setupUserNameConstraints()
        setupLoginLabelConstraints()
        setupContactsStackViewConstraints()
        setupFollowersStackViewContraints()
        setupProfileButtonConstraints()
        setupGitHubBottomImageConstraints()
        setupRegistrationDateConstraints()
    }
    
}
