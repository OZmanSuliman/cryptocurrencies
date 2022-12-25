//
//  CurrencyListContentView.swift
// cryptocurrencies
//
//  Created by Osman Ahmed on 23/12/2022.
//

import CoreLocation
import SwiftUI

// MARK: - CurrencyListContentView

struct CurrencyListContentView: View {
    @StateObject var store = AppState.shared
    @State var time = Timer.publish(every: 0.1, on: .current, in: .tracking).autoconnect()
    @State private var appBarHeight: CGFloat = 3.5
    @State private var orientation = UIDeviceOrientation.unknown
    let CurrencyList: [CryptocurrencyModel]
    var animatedTopView: AnimatedTopView?
    let interactor: CurrencyListInteractorProtocol
    var membersListIsFull: Bool?
    init(interactor: CurrencyListInteractorProtocol, CurrencyList: [CryptocurrencyModel], membersListIsFull: Bool?) {
        self.interactor = interactor
        self.CurrencyList = CurrencyList
        self.membersListIsFull = membersListIsFull
        animatedTopView = AnimatedTopView(headView: setHead(), bodyView: setBody(), membersListIsFull: membersListIsFull, fetch: fetch, refresh: interactor.refresh)

        if UIDevice.current.orientation.isLandscape {
            appBarHeight = 2.0
        }
    }

    var body: some View {
        animatedTopView
            .onAppear {
                interactor.fetchCurrency(nil)
            }
    }
}

extension CurrencyListContentView {
    func fetch() {
        interactor.fetchCurrency(nil)
    }
    func setHead() -> AnyView {
        return AnyView(
            HStack {
                VStack(alignment: .leading) {
                    Spacer(minLength: 0)
                    HStack(alignment: .top) {
                        Image("appLogo")
                            .resizable()
                            .frame(width: 30, height: 30)
                        Text("Weather App")
                            .font(.title)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                    }
                    .padding(.top)
                    Text("One Month free, then $4.99/month.")
                        .font(.caption)
                        .foregroundColor(.white)
                }
                Spacer(minLength: 0)
            }
            .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top == 0 ? 15 : (UIApplication.shared.windows.first?.safeAreaInsets.top)! + 5)
            .padding([.leading, .bottom])
        )
    }

    func setBody() -> AnyView {
        AnyView(
            VStack {
                if !CurrencyList.isEmpty {
                    ForEach(CurrencyList) { item in
                        CurrencyRow(currencyModel: item)
                    }
                } else {
                    Spacer()
                    Text("No Data Available About the Currencys😢")
                        .font(.subheadline)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .padding(.top, 50)
                    Spacer()
                }
            }
            .padding()
        )
    }
}
