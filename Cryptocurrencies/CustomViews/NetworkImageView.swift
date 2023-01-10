//
//  NetworkImageView.swift
// cryptocurrencies
//
//  Created by Osman Ahmed on 23/12/2022.
//

import SwiftUI

// MARK: - NetworkImageView
struct NetworkImageView: View {
    // Declare a new state variable to store the image URL
    @State private var imageURL: URL?
    @State private var isLoading = false
    let id: String
    @State var isCached = false
    
    var body: some View {
        VStack{
            // Use the AsyncImage view to asynchronously load the image
            if isLoading {
                CacheAsyncImage(
                    url: nil,
                    id: id,
                    isCached: $isCached
                ) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .tint(.black)
                    case .success(let image):
                        image
                            .resizable()
                    case .failure(_):
                        ProgressView()
                            .tint(.black)
                    @unknown default:
                        fatalError()
                    }
                }
                .frame(width: 25, height: 25)
            } else if let imageURL = imageURL {
                CacheAsyncImage(
                    url: imageURL,
                    id: id,
                    isCached: $isCached
                ) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .tint(.black)
                    case .success(let image):
                        image
                            .resizable()
                    case .failure(_):
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
        .onAppear{
            if imageURL == nil {
                fetchURL()
            }
        }
    }
    
    private func fetchURL() {
        DispatchQueue.main.async {
            isLoading = true
        }
        // Make the API request to get the image URL
        let request = MetadataRequest(id: id)
        ApiManager().apiRequest(request, withSuccess: { (response: MetadataResponse?, _, _) in
            if let currencyBaseModel = response?.currencyDetails , currencyBaseModel.status?.error_code == 0 {
                let iconURL = currencyBaseModel.data?.cryptocurrencyMetadata?.logo
                self.imageURL = URL(string: iconURL ?? Strings.NA.fullString())!
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            } else if self.isCached == false {
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
        }) { (error: Error) in
            // In case of an error, you could handle it here
            DispatchQueue.main.async {
                self.isLoading = false
            }
        }
    }
}

