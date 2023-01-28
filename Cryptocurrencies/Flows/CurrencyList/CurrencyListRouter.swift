//
//  CurrencyListRouter.swift
//  Cryptocurrencies
//
//  Created by Osman Ahmed on 22/01/2023.
//

import Foundation

protocol CurrencyListRouterProtocol {
    associatedtype I: CurrencyListInteractorProtocol
    associatedtype P: CurrencyListPresenterProtocol
    func createModule() -> CurrencyListView<I, P>
}

class CurrencyListRouter: CurrencyListRouterProtocol{
    func createModule() -> CurrencyListView<CurrencyListInteractor<CurrencyListPresenter>, CurrencyListPresenter> {
            let apiManager = ApiManager.shared
            let presenter = CurrencyListPresenter()
            let interactor = CurrencyListInteractor(apiManager: apiManager, presenter: presenter)
            return CurrencyListView(interactor: interactor, presenter: presenter)
    }
}
