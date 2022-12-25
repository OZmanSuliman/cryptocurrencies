//
// CryptocurrenciesApp.swift
// cryptocurrencies
//
//  Created by Osman Ahmed on 23/12/2022.
//

import SwiftUI

// MARK: - CurrencyAppApp

@main
struct CryptocurrenciesApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            setInteractor()
        }
    }

    func setInteractor() -> CurrencyListScreen {
        if EnvironmentManager.shared.checkIsDev() {
            let apiManager = ApiManagerMock()
            let presenter: CurrencyListPresenterProtocol = CurrencyListPresenter()
            let interactor: CurrencyListInteractorProtocol = CurrencyListInteractorMock(apiManager: apiManager, presenter: presenter)
            return CurrencyListScreen(interactor: interactor, presenter: presenter)
        } else {
            let apiManager = ApiManager()
            let presenter: CurrencyListPresenterProtocol = CurrencyListPresenter()
            let interactor: CurrencyListInteractorProtocol = CurrencyListInteractor(apiManager: apiManager, presenter: presenter)
            return CurrencyListScreen(interactor: interactor, presenter: presenter)
        }
    }
}
