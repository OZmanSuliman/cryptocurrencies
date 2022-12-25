//
//  APIRequestProtocol.swift
// cryptocurrencies
//
//  Created by Osman Ahmed on 23/12/2022.
//

import Foundation

protocol APIRequestProtocol {
    
    var endpoint: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any] { get }
    var arrayParameters: [[String: Any]]? { get }
    var formData: Data? { get }
    var formDataParameters: [String: Any]? { get }
    var headers: [String: String] { get }
    var isFormURLEncoded: Bool? { get }
    var apiTokenType: APITokenType? { get }
}

extension APIRequestProtocol {

    var method: HTTPMethod { return .get }
    var parameters: [String: Any] { return [:] }
    var arrayParameters: [[String: Any]]? { return [[:]] }
    var headers: [String: String] { return [:] }
    var formData: Data? { return nil }
    var formDataParameters: [String: Any]? { return [:] }
    var isFormURLEncoded: Bool? { return false }
    var apiTokenType: APITokenType? { return .accessToken }
}


enum APITokenType {
    case none // for requests that doesn't need an access token
    case accessToken
    case refreshToken
}
