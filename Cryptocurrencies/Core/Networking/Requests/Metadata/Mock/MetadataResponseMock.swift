//
//  MetadataResponseMock.swift
// cryptocurrencies
//
//  Created by Osman Ahmed on 23/12/2022.
//

import Foundation

public class MetadataResponseMock: MetadataResponseProtocol {
    var currencyDetails: MetadataBaseModel?

    public required init(with json: Data) {
        guard let json = json as? Data else { return }
        let currencyDetails = try? JSONDecoder().decode(MetadataBaseModel.self, from: json)
    }
}
