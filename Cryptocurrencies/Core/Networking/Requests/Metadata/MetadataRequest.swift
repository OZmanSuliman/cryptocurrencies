//
//  MetadataRequest.swift
// cryptocurrencies
//
//  Created by Osman Ahmed on 23/12/2022.
//

import Foundation

// MARK: - MetadataRequestProtocol

protocol MetadataRequestProtocol: APIRequestProtocol {}

// MARK: - MetadataRequest

struct MetadataRequest: MetadataRequestProtocol {
    var id: String
    init(id: String) {
        self.id = id
    }
    var endpoint: String { return APIEndpoints.metadata.fullPath(withParameters: id) }
    var headers: [String: String] { return ["X-CMC_PRO_API_KEY": EnvironmentManager.shared.getAppKey()] }
    var method: HTTPMethod { return .get }
}
