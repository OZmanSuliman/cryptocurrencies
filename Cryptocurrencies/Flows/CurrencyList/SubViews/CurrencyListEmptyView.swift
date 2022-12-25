//
//  CurrencyListEmptyView.swift
// cryptocurrencies
//
//  Created by Osman Ahmed on 23/12/2022.
//

import SwiftUI

// MARK: - CurrencyListEmptyView

struct CurrencyListEmptyView: View {
    @State var time = Timer.publish(every: 0.1, on: .current, in: .tracking).autoconnect()
    @State var show = false

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                VStack(alignment: .center) {
                    Spacer()
                    Image(systemName: "icloud.slash.fill")
                        .resizable()
                        .foregroundColor(Color(hex: 0x4EA7D8))
                        .frame(width: 110, height: 100)
                        .padding()
                    Text("No Data To Show")
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
    struct CurrencyListEmptyView_Previews: PreviewProvider {
        static var previews: some View {
            CurrencyListEmptyView()
        }
    }
#endif
