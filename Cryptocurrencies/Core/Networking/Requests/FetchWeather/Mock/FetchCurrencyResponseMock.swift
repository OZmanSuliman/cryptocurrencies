//
//  FetchCurrencyResponseMock.swift
// cryptocurrencies
//
//  Created by Osman Ahmed on 23/12/2022.
//

import Foundation

public class FetchCurrencyResponseMock: FetchCurrencyResponseProtocol {
    var CurrencyList: CryptocurrencyBaseModel?

    public required init(with json: Data) {
        guard let json = json as? Data else { return }
        let CurrencyList = try? JSONDecoder().decode(CryptocurrencyBaseModel.self, from: json)
    }
}
