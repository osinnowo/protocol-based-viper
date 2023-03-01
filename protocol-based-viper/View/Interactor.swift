//
//  Interactor.swift
//  protocol-based-viper
//
//  Created by Osinnowo Emmanuel on 01/03/2023.
//

import UIKit

protocol AnyInteractor {
    var presenter: AnyPresenter? { get set }
    func fetchAllUsers()
}

final class UserInteractor: AnyInteractor {
    var presenter: AnyPresenter?
    
    func fetchAllUsers() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let users = try? JSONDecoder().decode([User].self, from: data)
                self.presenter?.didFinishFetchUserInteractor(with: .success(users))
            } catch {
                self.presenter?.didFinishFetchUserInteractor(with: .failure(error))
            }
        }
        task.resume()
    }
}
