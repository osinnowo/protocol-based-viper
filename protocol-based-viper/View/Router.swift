//
//  Router.swift
//  protocol-based-viper
//
//  Created by Osinnowo Emmanuel on 01/03/2023.
//

import UIKit

typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter {
    var entry: EntryPoint? { get }
    static func start() -> EntryPoint?
}

final class UserRouter: AnyRouter {
    var entry: EntryPoint?

    static func start() -> EntryPoint? {
        var view: AnyView = UserViewController()
        var interactor: AnyInteractor = UserInteractor()
        var presenter: AnyPresenter = UserPresenter()
        var router = UserRouter()
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        presenter.interactor = interactor
        presenter.view = view
        presenter.router = router
        
        router.entry = view as? EntryPoint
      
        return router.entry
    }
}
