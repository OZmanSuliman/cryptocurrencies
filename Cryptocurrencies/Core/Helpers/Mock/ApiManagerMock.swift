//
//  ApiManagerMock.swift
//  Cryptocurrencies
//
//  Created by Osman Ahmed on 22/01/2023.
//

import Foundation

class ApiManagerMock: ApiManagerProtocol {
    var error: Error?
    var response: APIResponseProtocol?
    var statusCode: Int?
    var apiError: String?
    
    func apiRequest<Response: APIResponseProtocol>(_ request: APIRequestProtocol, withSuccess success: @escaping apiSuccess<Response>, WithApiFailure failure: @escaping apiFailure) {
        if let error = error {
            failure(error)
        } else {
            success(response as? Response, apiError, statusCode)
        }
    }
    
}
