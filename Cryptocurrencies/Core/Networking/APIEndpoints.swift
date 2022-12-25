//
//  API.swift
// cryptocurrencies
//
//  Created by Osman Ahmed on 23/12/2022.
//

import Foundation

enum APIEndpoints: String {

case cryptocurrencyList = "/v1/cryptocurrency/listings/latest?start=%@&limit=%@&sort=%@&cryptocurrency_type=%@&tag=%@"
case metadata = "/v2/cryptocurrency/info?id=%@"
    /** Contains the full path to the endpoint */
    func fullPath(withParameters parameters: CVarArg...) -> String {
        var endpoint = self.rawValue

        if parameters.count > 0 {
            endpoint = String(format: endpoint, arguments: parameters)
        }

        return "\(EnvironmentManager.shared.getBaseUrl())\(endpoint)"
    }
}
