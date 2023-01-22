//
//  CurrencyListRouter.swift
//  Cryptocurrencies
//
//  Created by Osman Ahmed on 22/01/2023.
//

import Foundation

protocol CurrencyListRouterProtocol{
    func createModule() -> CurrencyListView
}

class CurrencyListRouter: CurrencyListRouterProtocol{
    func createModule() -> CurrencyListView {
            let apiManager = ApiManager.shared
            let presenter: any CurrencyListPresenterProtocol = CurrencyListPresenter()
            let interactor: any CurrencyListInteractorProtocol = CurrencyListInteractor(apiManager: apiManager, presenter: presenter)
            return CurrencyListView(interactor: interactor, presenter: presenter)
    }
}
