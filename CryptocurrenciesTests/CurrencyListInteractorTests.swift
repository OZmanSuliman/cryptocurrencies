//
//  CurrencyListInteractorTests.swift
//  CryptocurrenciesTests
//
//  Created by Osman Ahmed on 22/01/2023.
//

@testable import Cryptocurrencies
import XCTest

class CurrencyListInteractorTests: XCTestCase {
    var apiManagerMock: ApiManagerMock!
    var presenterMock: CurrencyListPresenterMock!
    var interactor: CurrencyListInteractor!

    override func setUp() {
        apiManagerMock = ApiManagerMock()
        presenterMock = CurrencyListPresenterMock()
        interactor = CurrencyListInteractor(apiManager: apiManagerMock, presenter: presenterMock)


        // given
        let jsonString = """
        {
            "status": {
                "timestamp": "2022-01-01",
                "error_code": 0,
                "elapsed": 1,
                "credit_count": 1,
                "notice": ""
            },
            "data": [
                {
                    "id": 1,
                    "name": "Bitcoin",
                    "symbol": "BTC",
                    "slug": "bitcoin",
                    "cmc_rank": 1,
                    "num_market_pairs": 100,
                    "circulating_supply": 21000000,
                    "total_supply": 21000000,
                    "max_supply": 21000000,
                    "last_updated": "2022-01-01",
                    "date_added": "2022-01-01",
                    "tags": [
                        "virtual",
                        "crypto",
                        "currency"
                    ],
                    "quote": {
                        "USD": {
                            "price": 1000.0,
                            "volume_24h": 100000000,
                            "volume_change_24h": 1.0,
                            "percent_change_1h": 1.0,
                            "percent_change_24h": 2.0,
                            "percent_change_7d": 3.0,
                            "market_cap": 1000000000,
                            "market_cap_dominance": 1.0,
                            "fully_diluted_market_cap": 1.0,
                            "last_updated": "2022-01-01"
                        }
                    }
        }
                ]
            }
        """
        apiManagerMock.response = FetchCurrencyResponse(with: jsonString.data(using: .utf8)!)
    }

    func testFetchCurrency() {
        // when
        interactor.fetchCurrency()
        let exp = expectation(description: "wait for state calculator to be loaded")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            exp.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
        // then
        XCTAssertEqual(presenterMock.successCalled, true)
    }

    func testFetchCurrencyFailed() {
        // given
        apiManagerMock.error = NSError(domain: "", code: 0, userInfo: nil)

        // when
        interactor.fetchCurrency()
        let exp = expectation(description: "wait for state calculator to be loaded")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            exp.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
        // then
        XCTAssertEqual(presenterMock.failureCalled, true)
    }

    func testRefresh() {
        // given
        interactor.currentPage = 5

        // when
        interactor.refresh()
        let exp = expectation(description: "wait for state calculator to be loaded")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            exp.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
        // then
        XCTAssertEqual(interactor.currentPage, 1)
        XCTAssertEqual(presenterMock.successCalled, true)
    }

    func testLoadMoreContent() {
        // given
        let item = CryptocurrencyModel(id: 1, name: "Bitcoin", symbol: "BTC", slug: "bitcoin", cmc_rank: 1, num_market_pairs: 100, circulating_supply: 21_000_000, total_supply: 21_000_000, max_supply: 21_000_000, last_updated: "2022-01-01", date_added: "2022-01-01", tags: ["virtual", "crypto", "currency"], quote: Quote(USD: Currency(price: 1000.0, volume_24h: 100_000_000, volume_change_24h: 1_000_000, percent_change_1h: 1.0, percent_change_24h: 2.0, percent_change_7d: 3.0, market_cap: 1_000_000_000, market_cap_dominance: 50, fully_diluted_market_cap: 1_100_000_000, last_updated: "2022-01-01"), BTC: Currency(price: 1000.0, volume_24h: 100_000_000, volume_change_24h: 1_000_000, percent_change_1h: 1.0, percent_change_24h: 2.0, percent_change_7d: 3.0, market_cap: 1_000_000_000, market_cap_dominance: 50, fully_diluted_market_cap: 1_100_000_000, last_updated: "2022-01-01")))
        interactor.cryptocurrencyModel = [item]
        interactor.membersListFull = false

        // when
        interactor.loadMoreContent(currentItem: item)
        let exp = expectation(description: "wait for state calculator to be loaded")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            exp.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
        // then
        XCTAssertEqual(presenterMock.successCalled, true)
    }

    func testLoadMoreContentFullList() {
        // given
        let item = CryptocurrencyModel(id: 1, name: "Bitcoin", symbol: "BTC", slug: "bitcoin", cmc_rank: 1, num_market_pairs: 100, circulating_supply: 21_000_000, total_supply: 21_000_000, max_supply: 21_000_000, last_updated: "2022-01-01", date_added: "2022-01-01", tags: ["virtual", "crypto", "currency"], quote: Quote(USD: Currency(price: 1000.0, volume_24h: 100_000_000, volume_change_24h: 1_000_000, percent_change_1h: 1.0, percent_change_24h: 2.0, percent_change_7d: 3.0, market_cap: 1_000_000_000, market_cap_dominance: 50, fully_diluted_market_cap: 1_100_000_000, last_updated: "2022-01-01"), BTC: Currency(price: 1000.0, volume_24h: 100_000_000, volume_change_24h: 1_000_000, percent_change_1h: 1.0, percent_change_24h: 2.0, percent_change_7d: 3.0, market_cap: 1_000_000_000, market_cap_dominance: 50, fully_diluted_market_cap: 1_100_000_000, last_updated: "2022-01-01")))
        interactor.cryptocurrencyModel = [item]
        interactor.membersListFull = true

        // when
        interactor.loadMoreContent(currentItem: item)

        // then
        XCTAssertEqual(presenterMock.successCalled, false)
    }
}
