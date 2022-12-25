//
//  APIMock.swift
// cryptocurrencies
//
//  Created by Osman Ahmed on 23/12/2022.
//

import Foundation

// MARK: - ApiManagerMock

class ApiManagerMock: ApiManagerProtocol {
    func apiRequest<Response>(_ request: APIRequestProtocol, withSuccess success: @escaping apiSuccess<Response>, WithApiFailure failure: @escaping apiFailure) where Response : APIResponseProtocol {
        
    }
    
//    private let decoder = JSONDecoder()
//
//    func apiRequest<Response: APIResponseProtocol>(_ request: APIRequestProtocol, withSuccess success: @escaping apiSuccess<Response>, WithApiFailure failure: @escaping apiFailure) {
//        guard let path = Bundle.main.path(forResource: request.endpoint, ofType: "txt") else {
//            failure(NSError(domain: "invalid file", code: 500, userInfo: nil))
//            return
//        }
//
//        if let json = streamReading(path: path, keyword: getKeyword(request: request)) {
//            let response = Response(with: json)
//            success(response, "error", 200)
//        } else {
//            failure(NSError(domain: "empty", code: 500, userInfo: nil))
//        }
//    }
//
//    func getKeyword(request: APIRequestProtocol) -> String? {
//        if let keyword = request.parameters["keyword"] as? String{
//            return keyword
//        }
//        return nil
//    }
}
