//
//  FetchCurrencyRequestMock.swift
// cryptocurrencies
//
//  Created by Osman Ahmed on 23/12/2022.
//

import Foundation

// MARK: - FetchCurrencyRequestMock

struct FetchCurrencyRequestMock: FetchCurrencyRequestProtocol {
    var endpoint: String { return Strings.Currency_14.fullString() }
    var method: HTTPMethod { return .get }
}
