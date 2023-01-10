//
//  NetworkImageInteractor.swift
//  Cryptocurrencies
//
//  Created by Osman Ahmed on 10/01/2023.
//

import SwiftUI

// MARK: - NetworkImageInteractor

class NetworkImageInteractor: ObservableObject {
    var presenter: NetworkImagePresenter
    init(presenter: NetworkImagePresenter) {
        self.presenter = presenter
    }
}

extension NetworkImageInteractor {
    func fetchURL(id: String, cached: Binding<Bool>) {
        @Binding var isCached: Bool
        _isCached = cached
        presenter.setLoading(isLoading: true)
        let request = MetadataRequest(id: id)
        ApiManager().apiRequest(request, withSuccess: { (response: MetadataResponse?, _, _) in
            if let currencyBaseModel = response?.currencyDetails, currencyBaseModel.status?.error_code == 0 {
                let iconURL = currencyBaseModel.data?.cryptocurrencyMetadata?.logo
                self.presenter.setUrl(url: URL(string: iconURL ?? Strings.NA.fullString())!)
                self.presenter.setLoading(isLoading: false)
            } else if isCached == false {
                self.presenter.setLoading(isLoading: false)
            }
        }) { (_: Error) in
            self.presenter.setLoading(isLoading: false)
        }
    }
}
