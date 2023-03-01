//
//  Presenter.swift
//  protocol-based-viper
//
//  Created by Osinnowo Emmanuel on 01/03/2023.
//
//
//            Router
//              ^
//              |
// View <-> Presenter <-> Interactor <-> Network
//
//
//

import UIKit

protocol AnyPresenter {
    var router: AnyRouter? { get set }
    var view: AnyView? { get set }
    var interactor: AnyInteractor? { get set }
    func didFinishFetchUserInteractor(with result: Result<[User]?, Error>)
}

final class UserPresenter: AnyPresenter {
    var view: AnyView?
    var router: AnyRouter?
    var interactor: AnyInteractor? {
        didSet {
            interactor?.fetchAllUsers()
        }
    }
    
    func didFinishFetchUserInteractor(with result: Result<[User]?, Error>) {
        switch result {
        case .success(let users):
            view?.updateUsers(with: users)
        case .failure(let error):
            view?.updateUsers(with: error)
        }
    }
}
