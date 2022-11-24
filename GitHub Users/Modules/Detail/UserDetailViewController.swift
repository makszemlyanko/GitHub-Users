//
//  UserDetailViewController.swift
//  GitHub Users
//
//  Created by Maks Kokos on 21.11.2022.
//

import UIKit
import Kingfisher

final class UserDetailViewController: UIViewController {
    #warning("check layout, have some issues (search: google)")
    
    var userSearchName: String?

    private var userDetail: UserDetail! {
        didSet {
            guard let imageURL = URL(string: self.userDetail.avatarURL) else { return }
            DispatchQueue.main.async {
                self.avatarImage.kf.setImage(with: imageURL)
                self.userNameLabel.text = self.userDetail.name
                self.userLoginLabel.text = self.userDetail.login
                self.email.text = self.userDetail.location ?? "no email"
                self.comanyName.text = self.userDetail.company ?? "no company"
                self.followers.text = "Followers: \(String(self.userDetail.followers))"
                self.following.text = "Following: \(String(self.userDetail.following))"
                self.registrationDate.text = self.userDetail.createdAt
            }
        }
    }
    
    private let followers: UILabel = {
       let label = UILabel()
        label.text = "Followers: 53"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private let following: UILabel = {
       let label = UILabel()
        label.text = "Following: 124"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    
    private let followersStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    
    private let emailimage: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(systemName: "location")
        image.contentMode = .scaleAspectFit
        image.tintColor = .accentGreen
        return image
    }()
    
    private let email: UILabel = {
        let label = UILabel()
        label.text = "useremail@gmail.com"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let emailStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 12
        return stackView
    }()
    
    private let companyImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "building.2")
        image.contentMode = .scaleAspectFit
        image.tintColor = .accentGreen
        return image
    }()
    
    private let comanyName: UILabel = {
        let label = UILabel()
        label.text = "Company name"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let companyStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    private let contacktsStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        return stackView
    }()
    
    
    
    private let userNameLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "User Name"
        label.textAlignment = .center
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()
    
    private let userLoginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Subtitle Label"
        label.textAlignment = .center
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let titleStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let avatarImage: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "blankAva")
        image.clipsToBounds = true
        image.layer.cornerRadius = 60
        return image
    }()
    
    private let userCardView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .backgroundCustomBlack
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let registrationDate: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "on GitHub since November 25, 2009"
        label.textAlignment = .center
        label.textColor = .accentGreen
        label.font = .systemFont(ofSize: 10)
        return label
    }()
    
    private let gitHubBottomImage: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
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
    
    
    
    // NEW LAYOUT down below
    
    func setupUserCardView() {
        view.addSubview(userCardView)
        NSLayoutConstraint.activate([
            userCardView.topAnchor.constraint(equalTo: view.topAnchor, constant: 126),
            userCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            userCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            userCardView.heightAnchor.constraint(equalToConstant: 420)
        ])
    }
    
    private func setupUserImage() {
        userCardView.addSubview(avatarImage)
        NSLayoutConstraint.activate([
            avatarImage.widthAnchor.constraint(equalToConstant: 120),
            avatarImage.heightAnchor.constraint(equalToConstant: 120),
            avatarImage.centerXAnchor.constraint(equalTo: userCardView.centerXAnchor),
            avatarImage.topAnchor.constraint(equalTo: userCardView.topAnchor, constant: 40)
        ])
    }
    
    private func setupUserName() {
        userCardView.addSubview(userNameLabel)
        NSLayoutConstraint.activate([
            userNameLabel.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 24),
            userNameLabel.leadingAnchor.constraint(equalTo: userCardView.leadingAnchor, constant: 20),
            userNameLabel.trailingAnchor.constraint(equalTo: userCardView.trailingAnchor, constant: -20),
            userNameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func setupLoginLabel() {
        userCardView.addSubview(userLoginLabel)
        NSLayoutConstraint.activate([
            userLoginLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 10),
            userLoginLabel.leadingAnchor.constraint(equalTo: userCardView.leadingAnchor, constant: 20),
            userLoginLabel.trailingAnchor.constraint(equalTo: userCardView.trailingAnchor, constant: -20),
            userLoginLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func setupRegistrationDate() {
        #warning("date formatter")
        userCardView.addSubview(registrationDate)
        NSLayoutConstraint.activate([
            registrationDate.centerXAnchor.constraint(equalTo: userCardView.centerXAnchor),
            registrationDate.bottomAnchor.constraint(equalTo: userCardView.bottomAnchor, constant: -8),
            registrationDate.widthAnchor.constraint(equalToConstant: 200),
            registrationDate.heightAnchor.constraint(equalToConstant: 22)
        ])
    }
    
    private func configureLayout() {
        setupUserCardView()
        setupUserImage()
        setupUserName()
        setupLoginLabel()
        
        
        
        
        setupRegistrationDate()
    }
    
}
