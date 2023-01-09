//
//  CurrencyListPresenter.swift
// cryptocurrencies
//
//  Created by Osman Ahmed on 23/12/2022.
//

import Foundation
import Combine
// MARK: - CurrencyListPresenterProtocol

protocol CurrencyListPresenterProtocol: ObservableObject {
    func CurrencyListSuccessed(model: CryptocurrencyBaseModel)
    func CurrencyListFaild(error: String)
    var itemsCount: Int { get }
    var membersListIsFull: Bool? { get set }
    var cryptocurrencyModel: [CryptocurrencyModel] { get set }
}

// MARK: - CurrencyListPresenter

class CurrencyListPresenter: CurrencyListPresenterProtocol  {
    private let store = AppState.shared
    @Published var cryptocurrencyModel: [CryptocurrencyModel] = []
    private var membersListFull = false
    private var itemsListCount: Int = 0
    init() {
        store.stateCalculator = .loading
    }
}

// MARK: CurrencyListPresenterProtocol

extension CurrencyListPresenter {
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
//        cryptocurrencyModel = Array(Set(cryptocurrencyModel))
        itemsListCount = cryptocurrencyModel.count
        store.stateCalculator = .loaded(cryptocurrencyModel)
    }
}
