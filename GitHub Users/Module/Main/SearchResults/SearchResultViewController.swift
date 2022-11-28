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
    
    var user: User?
    
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
        searchUserTableView.separatorStyle = .none
    }


}

extension SearchResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        user != nil ? 1 : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.cellId, for: indexPath) as? UserTableViewCell else { return UITableViewCell() }
        cell.userLogin.text = self.user?.login
        cell.userId.text = "# \(self.user?.id ?? 0)"
        let imageURL = URL(string: self.user?.avatarURL ?? "")
        cell.userAvatar.kf.setImage(with: imageURL)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let imageView = UIImageView()
        let image = UIImage(named: "notFound")
        imageView.image = image
        imageView.contentMode = .center
        return imageView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return user == nil ? 350 : 0
    }
    
    
}

extension SearchResultViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userName = user?.login
        delegate?.showUserDetail(userName: userName!)
    }
}
