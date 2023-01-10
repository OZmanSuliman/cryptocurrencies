//
//  FetchCurrencyRequest.swift
// cryptocurrencies
//
//  Created by Osman Ahmed on 23/12/2022.
//

import Foundation

// MARK: - FetchCurrencyRequestProtocol

protocol FetchCurrencyRequestProtocol: APIRequestProtocol {

}

// MARK: - FetchCurrencyRequest

struct FetchCurrencyRequest: FetchCurrencyRequestProtocol {
    var start: String
    var limit: String
    let sort = Strings.marketCap.fullString()
    let cryptocurrency_type = Strings.all.fullString()
    let tag = Strings.all.fullString()
    
    init(start: String, limit: String) {
        self.start = start
        self.limit = limit
    }

}

extension FetchCurrencyRequest {
    var endpoint: String { return APIEndpoints.cryptocurrencyList.fullPath(withParameters: start, limit, sort, cryptocurrency_type, tag) }
    var headers: [String : String] { return [Strings.apiKey.fullString(): EnvironmentManager.shared.getAppKey()] }
    var method: HTTPMethod { return .get }
}
