//
//  Currency.swift
// cryptocurrencies
//
//  Created by Osman Ahmed on 23/12/2022.
//

import SwiftUI

// MARK: - CurrencyListView

struct CurrencyListView<Interactor, Presenter>: View where Presenter: CurrencyListPresenterProtocol, Interactor: CurrencyListInteractorProtocol {
    @StateObject var store = AppState.shared
    @State var time = Timer.publish(every: 0.1, on: .current, in: .tracking).autoconnect()
    @State var show = false
    let interactor: Interactor
    let presenter: Presenter
    
    
    var body: some View {
        NavigationView {
            switch store.stateCalculator {
            case let .loaded(currencyList):
                if let currencyList = currencyList as? [CryptocurrencyModel] {
                    CurrencyListContentView<CurrencyListInteractor<CurrencyListPresenter>, CurrencyListPresenter>(presenter: presenter as! CurrencyListPresenter, interactor: interactor as! CurrencyListInteractor, CurrencyList: currencyList, membersListIsFull: presenter.membersListIsFull)
                        .background(Color.white)
                        .navigationBarHidden(true)
                } else {
                    CurrencyListErrorView(error: Strings.NA.fullString())
                        .navigationBarHidden(true)
                        .background(Color.white)
                }
            case let .failed(error):
                CurrencyListErrorView(error: error)
                    .navigationBarHidden(true)
                    .background(Color.white)
            case .loading:
                CurrencyListLoadingView()
                    .navigationBarHidden(true)
                    .background(Color.white)
            case .idle:
                CurrencyListErrorView(error: Strings.NA.fullString())
                    .navigationBarHidden(true)
                    .background(Color.white)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .background(Color.white)
        .navigationBarBackButtonHidden(true)
        .onAppear{
            interactor.fetchCurrency(nil)
        }
    }
}

#if DEBUG
    struct CurrencyList_Previews: PreviewProvider {
        static var previews: some View {
            CurrencyListView(interactor:  CurrencyListInteractor(apiManager: ApiManagerMock(), presenter: CurrencyListPresenter()), presenter: CurrencyListPresenter())
        }
    }
#endif
