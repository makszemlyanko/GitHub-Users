//
//  SearchResultViewController.swift
//  GitHub Users
//
//  Created by Maks Kokos on 24.11.2022.
//

import UIKit

protocol SearchResultViewControllerDelegate: AnyObject {
    func showUserDetail(userName: String)
}

final class SearchResultViewController: UIViewController {
    
    weak var delegate: SearchResultViewControllerDelegate?
    
    var users = [User]()
    
    let searchUserTableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = UIColor.backgroundDarkGray
        table.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.cellId)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        view.addSubview(searchUserTableView)
        searchUserTableView.dataSource = self
        searchUserTableView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchUserTableView.frame = view.bounds
    }
}

extension SearchResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.cellId, for: indexPath) as? UserTableViewCell else { return UITableViewCell() }
        cell.loginLabel.text = self.users[indexPath.row].login
        cell.idLabel.text = "Id: \(self.users[indexPath.row].id)"
        let imageURL = URL(string: self.users[indexPath.row].avatarURL)
        cell.avatarImage.kf.setImage(with: imageURL)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
}

extension SearchResultViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userName = users[indexPath.row].login
        delegate?.showUserDetail(userName: userName)
    }
}
