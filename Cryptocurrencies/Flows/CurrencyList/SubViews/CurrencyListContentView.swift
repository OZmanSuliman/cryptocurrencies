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
    let CurrencyList: [CryptocurrencyModel]
    var membersListIsFull: Bool?
    init(presenter: any CurrencyListPresenterProtocol, interactor: any CurrencyListInteractorProtocol, CurrencyList: [CryptocurrencyModel], membersListIsFull: Bool?) {
        self.interactor = interactor as! Interactor
        self.presenter = presenter as! Presenter
        self.CurrencyList = CurrencyList
        self.membersListIsFull = membersListIsFull
    }

    var body: some View {
        ZStack(alignment: .top, content: {
            List {
                
                AnimatedTopView(appBarHeight: $appBarHeight, show: $show)
                
                if !presenter.cryptocurrencyModel.isEmpty {
                    ForEach(presenter.cryptocurrencyModel) { item in
                        CurrencyRow(currencyModel: item)
                            .listRowBackground(Color.clear)
                    }
                    if presenter.membersListIsFull == false {
                        ProgressView()
                            .tint(.black)
                            .frame(width: UIScreen.main.bounds.width, alignment: .center)
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                            .onAppear {
                                fetch()
                            }
                    }
                } else {
                    VStack(alignment: .center) {
                        Spacer()
                        Image(systemName: Strings.icloud.fullString())
                            .resizable()
                            .foregroundColor(Color(hex: 0x4EA7D8))
                            .frame(width: 110, height: 100)
                            .padding()
                        Text(Strings.noData.fullString())
                            .multilineTextAlignment(.center)
                            .font(.caption)
                            .foregroundColor(.black)
                        Spacer(minLength: 300)
                    }
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
}
