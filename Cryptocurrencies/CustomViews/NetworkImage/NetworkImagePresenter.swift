//
//  NetworkImagePresenter.swift
//  Cryptocurrencies
//
//  Created by Osman Ahmed on 10/01/2023.
//

import Foundation

// MARK: - NetworkImagePresenter

class NetworkImagePresenter: ObservableObject {
    @Published var imageURL: URL?
    @Published var isLoading = false

    func setUrl(url: URL) {
        DispatchQueue.main.async {
            self.imageURL = url
        }
    }

    func setLoading(isLoading: Bool) {
        DispatchQueue.main.async {
            self.isLoading = isLoading
        }
    }
}
