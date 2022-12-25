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
    let sort = "market_cap"
    let cryptocurrency_type = "all"
    let tag = "all"
    
    init(start: String, limit: String) {
        self.start = start
        self.limit = limit
    }

}

extension FetchCurrencyRequest {
    var endpoint: String { return APIEndpoints.cryptocurrencyList.fullPath(withParameters: start, limit, sort, cryptocurrency_type, tag) }
    var headers: [String : String] { return ["X-CMC_PRO_API_KEY": EnvironmentManager.shared.getAppKey()] }
    var method: HTTPMethod { return .get }
}
