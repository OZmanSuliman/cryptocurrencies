//
//  CurrencyListInteractorMock.swift
// cryptocurrencies
//
//  Created by Osman Ahmed on 23/12/2022.
//

import CoreLocation
import Foundation

// MARK: - CurrencyListInteractorMock
class CurrencyListInteractorMock: CurrencyListInteractorProtocol {
    private var cryptocurrencyBaseModel: CryptocurrencyBaseModel?
    private let apiManager: ApiManagerProtocol
    private var presenter: any CurrencyListPresenterProtocol
    private var jsonData: Data?
    init(apiManager: ApiManagerProtocol, presenter: any CurrencyListPresenterProtocol, jsonData: Data?) {
        self.apiManager = apiManager
        self.presenter = presenter
        self.jsonData = jsonData
    }

    func fetchCurrency( _ action: (() -> Void)?) {
        guard let jsonData = jsonData else { return }
        let decoder = JSONDecoder()
        cryptocurrencyBaseModel = try? decoder.decode(CryptocurrencyBaseModel.self, from: jsonData)
        action?()
    }

    func refresh() {
        // No implementation needed
    }

    func loadMoreContent(currentItem item: CryptocurrencyModel) {
        // No implementation needed
    }
}
