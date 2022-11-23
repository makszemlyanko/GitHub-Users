//
//  UserDetailViewController.swift
//  GitHub Users
//
//  Created by Maks Kokos on 21.11.2022.
//

import UIKit
import Kingfisher

final class UserDetailViewController: UIViewController {
    
    var user: User? {
        didSet {
            guard let imageURL = URL(string: self.user?.avatarURL ?? "") else { return }
            DispatchQueue.main.async {
                self.avatarImage.kf.setImage(with: imageURL)
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
        image.image = UIImage(systemName: "envelope")
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
        stackView.spacing = 8
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
//        stackView.spacing = 4
        stackView.alignment = .leading
        return stackView
    }()
    
    
    
    private let userName: UILabel = {
       let label = UILabel()
        label.text = "User Name"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()
    
    private let subtitle: UILabel = {
        let label = UILabel()
        label.text = "Subtitle Label"
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
    
    private var avatarImage: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "blankAva")
        image.contentMode = .scaleAspectFill
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
        setupCardView()
    }
    
    
    func setupCardView() {
        view.addSubview(userCardView)
        view.addSubview(gitHubBottomImage)
        
        userCardView.addSubview(avatarImage)
        
        titleStackView.addArrangedSubview(userName)
        titleStackView.addArrangedSubview(subtitle)
        
        userCardView.addSubview(titleStackView)
        userCardView.addSubview(registrationDate)
        
        
        NSLayoutConstraint.activate([
            userCardView.topAnchor.constraint(equalTo: view.topAnchor, constant: 126),
            userCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            userCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            userCardView.heightAnchor.constraint(equalToConstant: 420)
        ])
        
        avatarImage.widthAnchor.constraint(equalToConstant: 120).isActive = true
        avatarImage.heightAnchor.constraint(equalToConstant: 120).isActive = true
        avatarImage.centerXAnchor.constraint(equalTo: userCardView.centerXAnchor).isActive = true
        avatarImage.topAnchor.constraint(equalTo: userCardView.topAnchor, constant: 40).isActive = true
        
        titleStackView.centerXAnchor.constraint(equalTo: userCardView.centerXAnchor).isActive = true
        titleStackView.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 24).isActive = true
        titleStackView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        titleStackView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        
        registrationDate.centerXAnchor.constraint(equalTo: userCardView.centerXAnchor).isActive = true
        registrationDate.bottomAnchor.constraint(equalTo: userCardView.bottomAnchor, constant: -8).isActive = true
        registrationDate.widthAnchor.constraint(equalToConstant: 200).isActive = true
        registrationDate.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        gitHubBottomImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -58).isActive = true
        gitHubBottomImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        gitHubBottomImage.widthAnchor.constraint(equalToConstant: 44).isActive = true
        gitHubBottomImage.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        emailStackView.addArrangedSubview(emailimage)
        emailStackView.addArrangedSubview(email)
        
        companyStackView.addArrangedSubview(companyImage)
        companyStackView.addArrangedSubview(comanyName)
        
        contacktsStackView.addArrangedSubview(emailStackView)
        contacktsStackView.addArrangedSubview(companyStackView)
        
        userCardView.addSubview(contacktsStackView)
        
        
        contacktsStackView.topAnchor.constraint(equalTo: titleStackView.bottomAnchor, constant: 16).isActive = true
        contacktsStackView.centerXAnchor.constraint(equalTo: userCardView.centerXAnchor).isActive = true
        contacktsStackView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        contacktsStackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        
        followersStackView.addArrangedSubview(followers)
        followersStackView.addArrangedSubview(following)
        
        userCardView.addSubview(followersStackView)
        
        
        followersStackView.widthAnchor.constraint(equalToConstant: 260).isActive = true
        followersStackView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        followersStackView.centerXAnchor.constraint(equalTo: userCardView.centerXAnchor).isActive = true
        followersStackView.topAnchor.constraint(equalTo: contacktsStackView.bottomAnchor, constant: 16).isActive = true
        
    }
}
