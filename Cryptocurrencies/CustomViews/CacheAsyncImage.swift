//
//  CacheAsyncImage.swift
//  Cryptocurrencies
//
//  Created by Osman Ahmed on 10/01/2023.
//

import SwiftUI

struct CacheAsyncImage<Content>: View where Content: View {

    private let url: URL?
    private let id: String
    private let scale: CGFloat
    private let transaction: Transaction
    private let content: (AsyncImagePhase) -> Content
    @Binding var isCached: Bool
    init(
        url: URL?,
        id: String,
        isCached: Binding<Bool>,
        scale: CGFloat = 1.0,
        transaction: Transaction = Transaction(),
        @ViewBuilder content: @escaping (AsyncImagePhase) -> Content
    ) {
        self.url = url
        self.id = id
        self._isCached = isCached
        self.scale = scale
        self.transaction = transaction
        self.content = content
    }

    var body: some View {
        if let cached = ImageCache[id] {
            content(.success(cached))
                .onAppear{
                    self.isCached = true
                }
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
                .tint(.black)
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
