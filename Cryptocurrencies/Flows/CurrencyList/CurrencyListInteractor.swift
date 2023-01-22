//
//  CurrencyListInteractor.swift
// cryptocurrencies
//
//  Created by Osman Ahmed on 23/12/2022.
//

import Foundation
import SwiftUI

// MARK: - CurrencyListInteractorProtocol

protocol CurrencyListInteractorProtocol: ObservableObject {
    func fetchCurrency(_ action: (() -> Void)?)
    func refresh()
    func loadMoreContent(currentItem item: CryptocurrencyModel)
}

// MARK: - CurrencyListInteractor

class CurrencyListInteractor: CurrencyListInteractorProtocol {
    private let apiManager: ApiManagerProtocol
    private var data: Data?
    private let decoder = JSONDecoder()
    private var presenter: any CurrencyListPresenterProtocol
    var cryptocurrencyModel: [CryptocurrencyModel] = []
    var membersListFull = false
    var currentPage = 0
    private let perPage = 10
    private var isFetching = false

    init(apiManager: ApiManagerProtocol, presenter: any CurrencyListPresenterProtocol) {
        self.apiManager = apiManager
        self.presenter = presenter
    }
}

// MARK: CurrencyListInteractorProtocol

extension CurrencyListInteractor {
    func refresh() {
        if !isFetching {
            currentPage = 0
            fetchCurrency()
        }
    }

    // MARK: - PAGINATION

    func loadMoreContent(currentItem item: CryptocurrencyModel) {
        if cryptocurrencyModel.isLastItem(item) {
            fetchCurrency(nil)
        }
    }

    func fetchCurrency(_: (() -> Void)? = nil) {
        isFetching = true
        let start = "\(currentPage * perPage + 1)"
        let perPageStr = "\(perPage)"
        let request = FetchCurrencyRequest(start: start, limit: perPageStr)
        apiManager.apiRequest(request, withSuccess: { [weak self] (response: FetchCurrencyResponse?, _, _) in
            if let CurrencyBaseModel = response?.CurrencyList, CurrencyBaseModel.status?.error_code == 0 {
                self?.currentPage += 1
                if CurrencyBaseModel.cryptocurrencyModel?.count ?? 0 < self?.perPage ?? 10 {
                    self?.membersListFull = true
                    self?.presenter.membersListIsFull = self?.membersListFull
                }
                // notify presenter
                DispatchQueue.main.async {
                    self?.presenter.CurrencyListSuccessed(model: CurrencyBaseModel)
                }
            } else {
                DispatchQueue.main.async {
                    let error = response?.CurrencyList?.status?.error_message ?? Strings.defaultError.fullString()
                    self?.presenter.CurrencyListFaild(error: error)
                    self?.isFetching = false
                }
            }
            self?.isFetching = false
        }) { (error: Error) in
            DispatchQueue.main.async {
                self.presenter.CurrencyListFaild(error: error.localizedDescription)
                self.isFetching = false
            }
        }
    }
}
