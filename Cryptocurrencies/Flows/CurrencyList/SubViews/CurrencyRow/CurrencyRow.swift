//
//  CurrencyRow.swift
//  cryptocurrencies
//
//  Created by Osman Ahmed on 23/12/2022.
//

import SwiftUI

struct CurrencyRow: View {
    var currencyModel: CryptocurrencyModel
    var presenter: CurrencyRowPresenterProtocol

    init(currencyModel: CryptocurrencyModel, presenter: CurrencyRowPresenterProtocol = CurrencyRowPresenter()) {
        self.presenter = presenter
        self.currencyModel = currencyModel
    }

    var body: some View {
        HStack(alignment: .top) {
            NetworkImageView(id: presenter.id(model: currencyModel))
                .frame(width: 30, height: 30, alignment: .bottom)
            Spacer()
            Text(presenter.name(model: currencyModel))
                .font(.system(size: 17))
                .lineLimit(1)
                .scaledToFill()
                .minimumScaleFactor(0.5)
                .foregroundColor(.gray)
                .padding([.top, .trailing, .leading])
                .frame(width: UIScreen.main.bounds.width * 0.25, height: 20, alignment: .center)
            Spacer()
            Text(presenter.dollarRate(model: currencyModel))
                .font(.system(size: 17))
                .foregroundColor(.gray)
                .padding([.top, .trailing])
                .frame(width: UIScreen.main.bounds.width * 0.25, alignment: .center)
            Spacer()
            Text(presenter.changePerHour(model: currencyModel))
                .font(.system(size: 17))
                .foregroundColor(.gray)
                .padding([.top, .trailing])
                .frame(width: UIScreen.main.bounds.width * 0.25, alignment: .center)
        }
    }
}
