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

    init(error: String) {
        self.error = error
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                VStack(alignment: .center) {
                    Spacer()
                    Image(systemName: "exclamationmark.icloud.fill")
                        .resizable()
                        .foregroundColor(Color(hex: 0x4EA7D8))
                        .frame(width: 110, height: 100)
                        .padding()
                    Text(error)
                        .font(.title)

                    Spacer()
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
            CurrencyListErrorView(error: "An Error Occured")
        }
    }
#endif
