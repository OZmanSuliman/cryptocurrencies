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
    let router = CurrencyListRouter()
    var body: some Scene {
        WindowGroup {
            router.createModule()
        }
    }

}
