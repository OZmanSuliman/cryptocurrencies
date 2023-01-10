//
//  CurrencyListContentView.swift
// cryptocurrencies
//
//  Created by Osman Ahmed on 23/12/2022.
//

import CoreLocation
import SwiftUI

// MARK: - CurrencyListContentView

struct CurrencyListContentView<Interactor, Presenter>: View where Interactor: CurrencyListInteractorProtocol, Presenter: CurrencyListPresenterProtocol {
    @StateObject var store = AppState.shared
    @State private var appBarHeight: CGFloat = 3.5
    @State var show = false
    @State private var orientation = UIDeviceOrientation.unknown
    @ObservedObject var presenter: Presenter
    @ObservedObject var interactor: Interactor
    @State var time = Timer.publish(every: 0.1, on: .current, in: .tracking).autoconnect()
    let CurrencyList: [CryptocurrencyModel]
    var membersListIsFull: Bool?
    init(presenter: any CurrencyListPresenterProtocol, interactor: any CurrencyListInteractorProtocol, CurrencyList: [CryptocurrencyModel], membersListIsFull: Bool?) {
        self.interactor = interactor as! Interactor
        self.presenter = presenter as! Presenter
        self.CurrencyList = CurrencyList
        self.membersListIsFull = membersListIsFull
        if UIDevice.current.orientation.isLandscape {
            appBarHeight = 1.5
        }
    }

    var body: some View {
        ZStack(alignment: .top, content: {
            List {
                GeometryReader { g in
                    ZStack {
                        Image("banner")
                            .resizable()
                        VStack {
                            // head content
                            setHead()
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width, height: g.frame(in: .global).minY > 0 ? UIScreen.main.bounds.height / appBarHeight + g.frame(in: .global).minY : UIScreen.main.bounds.height / appBarHeight)
                    .onReceive(self.time) { _ in
                        // its not a timer...
                        // for tracking the image is scrolled out or not...
                        let y = g.frame(in: .global).minY
                        if -y > (UIScreen.main.bounds.height / appBarHeight) - 50 {
                            withAnimation {
                                self.show = true
                            }
                        } else {
                            withAnimation {
                                self.show = false
                            }
                        }
                    }
                }
                .frame(width: UIScreen.main.bounds.size.width, alignment: .center)
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets())
                // fixing default height...
                .frame(height: UIScreen.main.bounds.height / appBarHeight + 0.2)
                // body content
                
                if !presenter.cryptocurrencyModel.isEmpty {
                    ForEach(presenter.cryptocurrencyModel) { item in
                        CurrencyRow(currencyModel: item)
                            .listRowBackground(Color.clear)
                    }
                    if presenter.membersListIsFull == false {
                        ActivityIndicatorView()
                            .frame(width: UIScreen.main.bounds.width, alignment: .center)
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                            .onAppear {
                                fetch()
                            }
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
            .refreshable {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    store.stateCalculator = .loading
                    presenter.cryptocurrencyModel = []
                    interactor.refresh()
                }
            }
            .listStyle(.plain)
            if self.show {
                TopView()
            }
        })
            .ignoresSafeArea(edges: .top)
            .onRotate { newOrientation in
                orientation = newOrientation
                switch newOrientation {
                case .landscapeLeft, .landscapeRight:
                    appBarHeight = 1.5
                case .unknown, .portrait, .portraitUpsideDown, .faceUp, .faceDown:
                    appBarHeight = 3.5
                @unknown default:
                    appBarHeight = 3.5
                }
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
}
