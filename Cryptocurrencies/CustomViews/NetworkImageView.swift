//
//  NetworkImageView.swift
// cryptocurrencies
//
//  Created by Osman Ahmed on 23/12/2022.
//

import SwiftUI

// MARK: - NetworkImageView

struct NetworkImageView: View {
    @StateObject private var state: AppState

    init(id: String) {
        #warning("move url to presenter")
        let state = AppState()
        self._state = StateObject(wrappedValue: state)
        state.stateCalculator = .loading
        fetchUrl(id: id)
    }

    var body: some View {
        switch state.stateCalculator {
        case .loading:
            ActivityIndicatorView()
        case let .loaded(imageURL):
            if let imageURL = imageURL as? URL {
                AsyncImage(url: imageURL) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                    } else if phase.error != nil {
                        Image("appLogo")
                            .resizable()
                    } else {
                        ActivityIndicatorView()
                    }
                }
                .frame(width: 25, height: 25)
            } else {
                Image("appLogo")
                    .resizable()
                    .frame(width: 25, height: 25)
            }

        default:
            Image("appLogo")
                .resizable()
                .frame(width: 25, height: 25)
        }
    }
}

extension NetworkImageView {
    func fetchUrl(id: String) {
        let request = MetadataRequest(id: id)
        ApiManager().apiRequest(request, withSuccess: { (response: MetadataResponse?, _, _) in
            if let currencyBaseModel = response?.currencyDetails {
                let iconURL = currencyBaseModel.data?.cryptocurrencyMetadata?.logo
                let imageURL = URL(string: iconURL ?? "NA")!
                DispatchQueue.main.async {
                    self.state.stateCalculator = .loaded(imageURL)
                }
            }
        }) { (error: Error) in
            self.state.stateCalculator = .failed(error.localizedDescription)
        }
    }
}

// MARK: - NetworkImageView_Previews

struct NetworkImageView_Previews: PreviewProvider {
    static var previews: some View {
        NetworkImageView(id: "01n")
    }
}
