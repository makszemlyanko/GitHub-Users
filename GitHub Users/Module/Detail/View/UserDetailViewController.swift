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
    
    var presenter: UserDetailPresenterProtocol?

    private let userAvatar: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "blankAva")
        image.clipsToBounds = true
        image.layer.cornerRadius = 60
        return image
    }()
    
    private let userName: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 22)
        return label
    }()
    
    private let userLogin: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let userLocation: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let userEmail: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let userOrganization: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let followers: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private let following: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    
    private var profileURL = String()
    
    private let registrationDate: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = .accentGreen
        return label
    }()
    
    private let githubBottomImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "title")
        return image
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
    
    private let userCardView: UIView = {
        let view = UIView()
        view.backgroundColor = .backgroundCustomBlack
        view.layer.cornerRadius = 20
        return view
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
    
    @objc func didTapProfileButton() {
        let profileUrl = profileURL
        guard let url = URL(string: profileUrl) else { return }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundDarkGray
        configureUserDetailLayout()
    }
    
    // MARK: - Layout
    
    private func configureUserDetailLayout() {
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
    
    private func setupUserCardViewConstraints() {
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
        userCardView.addSubview(userName)
        userName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userName.topAnchor.constraint(equalTo: userAvatar.bottomAnchor, constant: 24),
            userName.leadingAnchor.constraint(equalTo: userCardView.leadingAnchor, constant: 20),
            userName.trailingAnchor.constraint(equalTo: userCardView.trailingAnchor, constant: -20),
            userName.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    private func setupLoginLabelConstraints() {
        userCardView.addSubview(userLogin)
        userLogin.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userLogin.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 6),
            userLogin.leadingAnchor.constraint(equalTo: userCardView.leadingAnchor, constant: 20),
            userLogin.trailingAnchor.constraint(equalTo: userCardView.trailingAnchor, constant: -20),
            userLogin.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func setupContactsStackViewConstraints() {
        contactsStackView.translatesAutoresizingMaskIntoConstraints = false
        contactsStackView.addArrangedSubview(userLocation)
        contactsStackView.addArrangedSubview(userOrganization)
        contactsStackView.addArrangedSubview(userEmail)
        view.addSubview(contactsStackView)
        NSLayoutConstraint.activate([
            contactsStackView.centerXAnchor.constraint(equalTo: userCardView.centerXAnchor),
            contactsStackView.topAnchor.constraint(equalTo: userLogin.bottomAnchor, constant: 16),
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
        followersStackView.addArrangedSubview(followers)
        followersStackView.addArrangedSubview(following)
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
        githubBottomImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(githubBottomImage)
        NSLayoutConstraint.activate([
            githubBottomImage.topAnchor.constraint(equalTo: userCardView.bottomAnchor, constant: 60),
            githubBottomImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            githubBottomImage.widthAnchor.constraint(equalToConstant: 44),
            githubBottomImage.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}

// MARK: - Presenter's protocol

extension UserDetailViewController: UserDetailProtocol {
    func setUserDetail(detail: UserDetail?) {
        guard let imageURL = URL(string: detail?.avatarURL ?? "") else { return }
        self.userAvatar.kf.setImage(with: imageURL)
        self.userName.text = detail?.name
        self.userLogin.text = detail?.login
        self.userLocation.text = detail?.location
        self.userOrganization.text = detail?.company
        self.userEmail.text = detail?.email
        self.followers.text = "\(String(detail?.followers ?? 0)) followers"
        self.following.text = "\(String(detail?.following ?? 0)) following"
        self.registrationDate.text = "On GitHub since \(String(describing: detail?.createdAt.convertToDisplayFormat() ?? ""))"
        self.profileURL = detail?.htmlUrl ?? ""
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}
