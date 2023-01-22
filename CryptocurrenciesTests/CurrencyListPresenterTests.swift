//
//  CurrencyListPresenterTests.swift
//  CryptocurrenciesTests
//
//  Created by Osman Ahmed on 22/01/2023.
//

import XCTest
@testable import Cryptocurrencies

class CurrencyListPresenterTests: XCTestCase {
    var sut: CurrencyListPresenter!
    var store: AppState!
    
    override func setUp() {
        super.setUp()
        store = AppState.shared
        sut = CurrencyListPresenter()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        store.stateCalculator = .idle
    }
    
    func testCurrencyListSuccessed() {
        // Given
        let model = CryptocurrencyBaseModel(status: Status(timestamp: "2022-01-01", error_code: 0, error_message: nil, elapsed: 1, credit_count: 1, notice: ""), cryptocurrencyModel: [CryptocurrencyModel(id: 1, name: "Bitcoin", symbol: "BTC", slug: "bitcoin", cmc_rank: 1, num_market_pairs: 100, circulating_supply: 21000000, total_supply: 21000000, max_supply: 21000000, last_updated: "2022-01-01", date_added: "2022-01-01", tags: ["virtual","crypto","currency"], quote: Quote(USD: Currency(price: 1000.0, volume_24h: 100000000, volume_change_24h: 1000000, percent_change_1h: 1.0, percent_change_24h: 2.0, percent_change_7d: 3.0, market_cap: 1000000000, market_cap_dominance: 50, fully_diluted_market_cap: 1100000000, last_updated: "2022-01-01"), BTC: Currency(price: 1000.0, volume_24h: 100000000, volume_change_24h: 1000000, percent_change_1h: 1.0, percent_change_24h: 2.0, percent_change_7d: 3.0, market_cap: 1000000000, market_cap_dominance: 50, fully_diluted_market_cap: 1100000000, last_updated: "2022-01-01")))])

        // When
        sut.CurrencyListSuccessed(model: model)
        let exp = expectation(description: "wait for state calculator to be loaded")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
               exp.fulfill()
           }
           waitForExpectations(timeout: 2, handler: nil)
        // Then
        XCTAssertEqual(sut.cryptocurrencyModel.count, 1)
        XCTAssertEqual(sut.cryptocurrencyModel[0].name, "Bitcoin")
        XCTAssertEqual(sut.itemsCount, 1)
        XCTAssertEqual(AppState.shared.stateCalculator, .loaded(sut.cryptocurrencyModel))
    }
    
    func testCurrencyListFaild() {
        // Given
        let error = "Failed to fetch data"
        
        // When
        sut.CurrencyListFaild(error: error)
        let exp = expectation(description: "wait for state calculator to be loaded")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
               exp.fulfill()
           }
           waitForExpectations(timeout: 2, handler: nil)
        // Then
        if store.stateCalculator == .idle {
            XCTAssertEqual(store.stateCalculator, .failed(error))
        } else {
            XCTAssertNotEqual(store.stateCalculator, .failed(error))
        }
    }
}
