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
    
    var presenter: SearchResultPresenterProtocol?
    
    // MARK: - Properties
    
    weak var delegate: SearchResultViewControllerDelegate?
    
    let searchResultTableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = UIColor.backgroundDarkGray
        table.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.cellId)
        return table
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchUserTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultTableView.frame = view.bounds
        searchResultTableView.separatorStyle = .none
    }
    
    private func configureSearchUserTableView() {
        view.addSubview(searchResultTableView)
        searchResultTableView.dataSource = self
        searchResultTableView.delegate = self
    }
}

// MARK: - Data Source

extension SearchResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.user != nil ? 1 : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.cellId, for: indexPath) as? UserTableViewCell else { return UITableViewCell() }
        cell.userLogin.text = presenter?.user?.login
        cell.userId.text = "# \(presenter?.user?.id ?? 0)"
        let imageURL = URL(string: presenter?.user?.avatarURL ?? "")
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
        presenter?.user == nil ? 350 : 0
    }
}

// MARK: - Delegate

extension SearchResultViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userName = presenter?.user?.login
        delegate?.showUserDetail(userName: userName ?? "")
    }
}

// MARK: - Presenter's protocol

extension SearchResultViewController: SearchResultProtocol {
    func updateTableView() {
        searchResultTableView.reloadData()
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}
