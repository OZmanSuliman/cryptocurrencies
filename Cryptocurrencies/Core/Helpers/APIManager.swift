//
//  APIManager.swift
// cryptocurrencies
//
//  Created by Osman Ahmed on 23/12/2022.
//

import Foundation

// MARK: - ApiManagerProtocol

protocol ApiManagerProtocol {
    func apiRequest<Response: APIResponseProtocol>(_ request: APIRequestProtocol, withSuccess success: @escaping apiSuccess<Response>, WithApiFailure failure: @escaping apiFailure)
}

typealias apiSuccess<Response: APIResponseProtocol> = (_ response: Response?, _ error: String?, _ statusCode: Int?) -> Void
typealias apiFailure = (_ error: Error) -> Void

// MARK: - HTTPMethod

enum HTTPMethod: String {
    case get
    case post
}

// MARK: - ApiManager

class ApiManager: ApiManagerProtocol {
    static let shared = ApiManager()
    private let serialQueue = DispatchQueue(label: "networkSerialQueue")
    func apiRequest<Response>(_ request: APIRequestProtocol, withSuccess success: @escaping apiSuccess<Response>, WithApiFailure failure: @escaping apiFailure) where Response: APIResponseProtocol {
        requestResource(serviceURL: request.endpoint, httpMethod: request.method, headers: request.headers, parameters: request.parameters, withSuccess: success, WithApiFailure: failure)
    }
    private func requestResource<Response>(serviceURL: String, httpMethod: HTTPMethod, headers: [String: String]?, parameters: [String: Any]?, withSuccess success: @escaping apiSuccess<Response>, WithApiFailure failure: @escaping apiFailure) where Response: APIResponseProtocol {
        serialQueue.async {
            let dispatchGroup = DispatchGroup()
            dispatchGroup.enter()
        guard let url = URL(string: "\(serviceURL)") else {
            failure(NSError(domain: "", code: 500, userInfo: nil))
            return
        }
        var request = URLRequest(url: url)
        headers?.forEach {
            request.setValue($1, forHTTPHeaderField: $0)
        }
        request.httpMethod = httpMethod.rawValue

        if let parameters = parameters,
           !parameters.isEmpty {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        }
            let sessionTask = URLSession(configuration: .default).dataTask(with: request) { data, _, error in
                
                if let data = data {
                    success(Response(with: data), nil, nil)
                    dispatchGroup.leave()
                } else if let error = error {
                    failure(error)
                    dispatchGroup.leave()
                } else {
                    failure(NSError(domain: "", code: 500, userInfo: nil))
                    dispatchGroup.leave()
                }
            }
            sessionTask.resume()
            dispatchGroup.wait()
        }
    }
}
