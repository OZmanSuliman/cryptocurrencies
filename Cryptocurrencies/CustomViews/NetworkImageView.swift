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
    
    
    var body: some View {
        VStack{
            // Use the AsyncImage view to asynchronously load the image
            if isLoading {
                CacheAsyncImage(
                    url: nil,
                    id: id
                ) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                    case .failure(_):
                        ActivityIndicatorView()
                    @unknown default:
                        fatalError()
                    }
                }
                .frame(width: 25, height: 25)
            } else if let imageURL = imageURL {
                CacheAsyncImage(
                    url: imageURL, id: id
                ) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                    case .failure(_):
                        Image("appLogo")
                            .resizable()
                    @unknown default:
                        fatalError()
                    }
                }
                .frame(width: 25, height: 25)
            } else {
                Image("appLogo")
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
                self.imageURL = URL(string: iconURL ?? "NA")!
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            } else {
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



struct CacheAsyncImage<Content>: View where Content: View {

    private let url: URL?
    private let id: String
    private let scale: CGFloat
    private let transaction: Transaction
    private let content: (AsyncImagePhase) -> Content

    init(
        url: URL?,
        id: String,
        scale: CGFloat = 1.0,
        transaction: Transaction = Transaction(),
        @ViewBuilder content: @escaping (AsyncImagePhase) -> Content
    ) {
        self.url = url
        self.id = id
        self.scale = scale
        self.transaction = transaction
        self.content = content
    }

    var body: some View {
        if let cached = ImageCache[id] {
            content(.success(cached))
        } else if let url = url {
            AsyncImage(
                url: url,
                scale: scale,
                transaction: transaction
            ) { phase in
                cacheAndRender(phase: phase)
            }
        } else {
            ProgressView()
        }
    }

    func cacheAndRender(phase: AsyncImagePhase) -> some View {
        if case .success(let image) = phase {
            ImageCache[id] = image
        }

        return content(phase)
    }
}


fileprivate class ImageCache {
    static private var cache: [String: Image] = [:]

    static subscript(url: String) -> Image? {
        get {
            ImageCache.cache[url]
        }
        set {
            ImageCache.cache[url] = newValue
        }
    }
}
