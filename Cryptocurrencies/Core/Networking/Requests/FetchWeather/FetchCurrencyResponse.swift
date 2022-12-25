//
//  FetchCurrencyResponse.swift
// cryptocurrencies
//
//  Created by Osman Ahmed on 23/12/2022.
//

import Foundation

protocol FetchCurrencyResponseProtocol: APIResponseProtocol  {
    var CurrencyList: CryptocurrencyBaseModel? { get }
}

public class FetchCurrencyResponse: FetchCurrencyResponseProtocol {
    var CurrencyList: CryptocurrencyBaseModel?

    public required init(with json: Data) {
        do {
            CurrencyList = try JSONDecoder().decode(CryptocurrencyBaseModel.self, from: json)
        } catch let error{
            print(error)
        }
    }
}
