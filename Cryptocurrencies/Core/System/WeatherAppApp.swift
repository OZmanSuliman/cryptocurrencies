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
            let apiManager = ApiManager.shared
            let presenter: any CurrencyListPresenterProtocol = CurrencyListPresenter()
            let interactor: any CurrencyListInteractorProtocol = CurrencyListInteractor(apiManager: apiManager, presenter: presenter)
            return CurrencyListScreen(interactor: interactor, presenter: presenter)
    
    }
}
