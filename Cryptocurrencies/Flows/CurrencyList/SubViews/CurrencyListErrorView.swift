//
//  CurrencyListErrorView.swift
// cryptocurrencies
//
//  Created by Osman Ahmed on 23/12/2022.
//

import SwiftUI

// MARK: - CurrencyListErrorView

struct CurrencyListErrorView: View {
    var error: String
    @StateObject var store = AppState.shared
    @State var time = Timer.publish(every: 0.1, on: .current, in: .tracking).autoconnect()
    @State var show = false
    @State private var appBarHeight: CGFloat = 3.5
    init(error: String) {
        self.error = error
    }

    var body: some View {
        VStack(alignment: .leading) {
            AnimatedTopView(appBarHeight: $appBarHeight, show: $show)
            HStack {
                Spacer()
                VStack(alignment: .center) {
                    Spacer()
                    Image(systemName: Strings.icloud.fullString())
                        .resizable()
                        .foregroundColor(Color(hex: 0x4EA7D8))
                        .frame(width: 110, height: 100)
                        .padding()
                    Text(error)
                        .multilineTextAlignment(.center)
                        .font(.caption)
                        .foregroundColor(.black)
                    Spacer(minLength: 300)
                }
                Spacer()
            }
            .padding()
        }
        .ignoresSafeArea(edges: .top)
    }
}

#if DEBUG
    struct CurrencyListErrorView_Previews: PreviewProvider {
        static var previews: some View {
            CurrencyListErrorView(error: Strings.defaultError.fullString())
        }
    }
#endif
