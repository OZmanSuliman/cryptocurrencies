//
//  NetworkImageView.swift
// cryptocurrencies
//
//  Created by Osman Ahmed on 23/12/2022.
//

import SwiftUI

// MARK: - NetworkImageView

struct NetworkImageView: View {
    let id: String
    @State var isCached = false
    @ObservedObject var presenter: NetworkImagePresenter
    @ObservedObject var interactor: NetworkImageInteractor

    var body: some View {
        VStack {
            if presenter.isLoading {
                CacheAsyncImage(
                    url: nil,
                    id: id,
                    isCached: $isCached
                ) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .tint(.black)
                    case let .success(image):
                        image
                            .resizable()
                    case .failure:
                        ProgressView()
                            .tint(.black)
                    @unknown default:
                        fatalError()
                    }
                }
                .frame(width: 25, height: 25)
            } else if let imageURL = presenter.imageURL {
                CacheAsyncImage(
                    url: imageURL,
                    id: id,
                    isCached: $isCached
                ) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .tint(.black)
                    case let .success(image):
                        image
                            .resizable()
                    case .failure:
                        Image(Strings.appLogo.rawValue)
                            .resizable()
                    @unknown default:
                        fatalError()
                    }
                }
                .frame(width: 25, height: 25)
            } else {
                Image(Strings.appLogo.rawValue)
                    .resizable()
            }
        }
        .onAppear {
            if presenter.imageURL == nil {
                fetchURL()
            }
        }
    }

    private func fetchURL() {
        interactor.fetchURL(id: id, cached: $isCached)
    }
}
