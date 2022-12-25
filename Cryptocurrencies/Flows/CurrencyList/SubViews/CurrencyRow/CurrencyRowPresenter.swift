//
//  CurrencyRowPresenter.swift
// cryptocurrencies
//
//  Created by Osman Ahmed on 23/12/2022.
//

import Foundation

// MARK: - CurrencyRowPresenterProtocol

protocol CurrencyRowPresenterProtocol {
    func id(model: CryptocurrencyModel) -> String
    func name(model: CryptocurrencyModel) -> String
    func dollarRate(model: CryptocurrencyModel) -> String
    func changePerHour(model: CryptocurrencyModel) -> String
}

// MARK: - WeatherRowPresenterPresenter

class CurrencyRowPresenter: CurrencyRowPresenterProtocol {
    private let store = AppState.shared
    
    func id(model: CryptocurrencyModel) -> String {
        if let id = model.id {
            let idString = "\(id)"
            return idString
        } else {
            return "N/A"
        }
    }
    
    func name(model: CryptocurrencyModel) -> String {
        if let name = model.name {
            return name
        } else {
            return "N/A"
        }
    }
    
    func dollarRate(model: CryptocurrencyModel) -> String {
        if let price = model.quote?.uSD?.price {
            let priceRounded = price.rounded(toPlaces: 2)
            let priceString = "\(priceRounded)"
            return priceString
        } else {
            return "N/A"
        }
    }
    
    func changePerHour(model: CryptocurrencyModel) -> String {
        if let change = model.quote?.uSD?.percent_change_1h {
            let changeRounded = change.rounded(toPlaces: 2)
            let changeString = "\(changeRounded)"
            return changeString
        } else {
            return "N/A"
        }
    }
}

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
