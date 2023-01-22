//
//  CurrencyListPresenterMock.swift
//  Cryptocurrencies
//
//  Created by Osman Ahmed on 22/01/2023.
//

import Foundation

class CurrencyListPresenterMock: CurrencyListPresenterProtocol {
    var successCalled = false
    var failureCalled = false
    var error: String?
    var itemsCount: Int = 0
    var membersListIsFull: Bool?
    var cryptocurrencyModel: [CryptocurrencyModel] = []
    
    func CurrencyListSuccessed(model: CryptocurrencyBaseModel) {
        successCalled = true
        cryptocurrencyModel = model.cryptocurrencyModel ?? []
        itemsCount = cryptocurrencyModel.count
    }
    
    func CurrencyListFaild(error: String) {
        failureCalled = true
        self.error = error
    }
}
