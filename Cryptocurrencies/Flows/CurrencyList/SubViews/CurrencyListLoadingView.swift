//
//  CurrencyListLoadingView.swift
// cryptocurrencies
//
//  Created by Osman Ahmed on 23/12/2022.
//

import SwiftUI

// MARK: - CurrencyListLoadingView

struct CurrencyListLoadingView: View {
    @StateObject var store = AppState.shared
    @State var time = Timer.publish(every: 0.1, on: .current, in: .tracking).autoconnect()
    @State var show = false
    @State private var orientation = UIDeviceOrientation.unknown
    @State private var appBarHeight: CGFloat = 3.5

    var body: some View {
        AnimatedTopView(headView: setHead(), bodyView: setBody(), membersListIsFull: true, fetch: nil, refresh: nil)
    }
}

extension CurrencyListLoadingView {
    func setHead() -> AnyView {
        return AnyView(
            VStack {
                ActivityIndicatorView()
            }
        )
    }

    func setBody() -> AnyView {
        AnyView(
            VStack {
                Spacer(minLength: 100)
                ActivityIndicatorView()

            }
            .padding()
        )
    }
}

#if DEBUG
    struct CurrencyListLoadingView_Previews: PreviewProvider {
        static var previews: some View {
            CurrencyListLoadingView()
        }
    }
#endif
