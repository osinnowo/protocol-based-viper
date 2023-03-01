//
//  View.swift
//  protocol-based-viper
//
//  Created by Osinnowo Emmanuel on 01/03/2023.
//

import UIKit

protocol AnyView {
    var presenter: AnyPresenter? { get set }
    func updateUsers(with users: [User]?)
    func updateUsers(with error: Error)
}

final class UserViewController: UIViewController, AnyView {
    var presenter: AnyPresenter?

    private static let cell: String = "cell"
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cell)
        return tableView
    }()
    
    private var users: [User]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func updateUsers(with users: [User]?) {
        DispatchQueue.main.async {
            self.users = users
            self.tableView.reloadData()
        }
    }
    
    func updateUsers(with error: Error) {
        print(error.localizedDescription)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

extension UserViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = self.users?[indexPath.row].name
        return cell
    }
}
