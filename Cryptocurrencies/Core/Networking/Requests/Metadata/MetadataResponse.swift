//
//  MetadataResponse.swift
// cryptocurrencies
//
//  Created by Osman Ahmed on 23/12/2022.
//

import Foundation

protocol MetadataResponseProtocol: APIResponseProtocol  {
    var currencyDetails: MetadataBaseModel? { get }
}

public class MetadataResponse: MetadataResponseProtocol {
    var currencyDetails: MetadataBaseModel?

    public required init(with json: Data) {
        do {
            currencyDetails = try JSONDecoder().decode(MetadataBaseModel.self, from: json)
        } catch let error{
            print(error)
        }
    }
}
