//
//  CurrencyListPresenter.swift
// cryptocurrencies
//
//  Created by Osman Ahmed on 23/12/2022.
//

import Foundation

// MARK: - CurrencyListPresenterProtocol

protocol CurrencyListPresenterProtocol {
    func CurrencyListSuccessed(model: CryptocurrencyBaseModel)
    func CurrencyListFaild(error: String)
    var itemsCount: Int { get }
    var membersListIsFull: Bool? { get set }
}

// MARK: - CurrencyListPresenter

class CurrencyListPresenter {
    private let store = AppState.shared
    private var cryptocurrencyModel: [CryptocurrencyModel] = []
    private var membersListFull = false
    private var itemsListCount: Int = 0
    init() {
        store.stateCalculator = .loading
    }
}

// MARK: CurrencyListPresenterProtocol

extension CurrencyListPresenter: CurrencyListPresenterProtocol {
    var itemsCount: Int {
        itemsListCount
    }
    
    var membersListIsFull: Bool? {
        get {
            return membersListFull
        }
        set {
            membersListFull = newValue ?? false
        }
    }

    func CurrencyListFaild(error: String) {
        switch store.stateCalculator {
        case .loading, .idle:
            store.stateCalculator = .failed(error)
        default:
            break
        }
    }

    func CurrencyListSuccessed(model: CryptocurrencyBaseModel) {
        guard let fetchedCryptocurrency = model.cryptocurrencyModel else { return }
        cryptocurrencyModel.append(contentsOf: fetchedCryptocurrency)
        itemsListCount = cryptocurrencyModel.count
        store.stateCalculator = .loaded(cryptocurrencyModel)
    }
}
