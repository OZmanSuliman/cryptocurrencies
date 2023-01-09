//
//  CurrencyListInteractorMock.swift
// cryptocurrencies
//
//  Created by Osman Ahmed on 23/12/2022.
//

import CoreLocation
import Foundation

// MARK: - CurrencyListInteractorMock

class CurrencyListInteractorMock {
    private let apiManager: ApiManagerProtocol
    private var data: Data?
    private let decoder = JSONDecoder()
    private var presenter: any CurrencyListPresenterProtocol

    init(apiManager: ApiManagerProtocol, presenter: any CurrencyListPresenterProtocol) {
        self.apiManager = apiManager
        self.presenter = presenter
        fetchCurrency()
    }
}

// MARK: CurrencyListInteractorProtocol

extension CurrencyListInteractorMock: CurrencyListInteractorProtocol {
    func loadMoreContent(currentItem item: CryptocurrencyModel) {
        
    }
    
    func refresh() {
        
    }
    
    func fetchCurrency(_ action: ( () -> Void)? = nil) {
        let request = FetchCurrencyRequestMock()
        apiManager.apiRequest(request, withSuccess: { (response: FetchCurrencyResponseMock?, _, _) in
            if let CurrencyBaseModel = response?.CurrencyList {
                // notify presenter
                DispatchQueue.main.async {
                    self.presenter.CurrencyListSuccessed(model: CurrencyBaseModel)
                }
            }
        }) { (error: Error) in
            DispatchQueue.main.async {
                #warning("add custom error enum")
                self.presenter.CurrencyListFaild(error: error.localizedDescription)
            }
        }
    }
}
