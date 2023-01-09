//
//cryptocurrenciesTests.swift
//cryptocurrenciesTests
//
//  Created by Osman Ahmed on 23/12/2022.
//


@testable import Cryptocurrencies
import XCTest

class WeatherAppTests: XCTestCase {
    var apiManager: ApiManager!
    var environmentManager: EnvironmentManager!
    var currencyListPresenter: (any CurrencyListPresenterProtocol)!
    var currencyListInteractor: (any CurrencyListInteractorProtocol)!
    var store: AppState!

    override func setUpWithError() throws {
        currencyListPresenter = CurrencyListPresenter()
        apiManager = ApiManager.shared
        store = AppState.shared
    }

    override func tearDownWithError() throws {
        environmentManager = nil
        apiManager = nil
        currencyListPresenter = nil
        currencyListInteractor = nil
        store = AppState()
    }

    func test_interactor() {
        var jsonData: Data?

        do {
            let fileUrl = Bundle.main.url(forResource: "jsonFile", withExtension: "json")!
            jsonData = try Data(contentsOf: fileUrl)
        } catch {
            // handle error
        }

        let mockupInteractor = CurrencyListInteractorMock(apiManager: self.apiManager, presenter: self.currencyListPresenter, jsonData: jsonData)
        let expectation = self.expectation(description: "interactor")
        XCTAssertNotNil(store.stateCalculator)
        currencyListInteractor.fetchCurrency() {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 9, handler: nil)
        XCTAssertNotEqual(store.stateCalculator, AppStateEnum.loading)
    }

    func test_Presenter_faild() {
        store.stateCalculator = .idle
        currencyListPresenter.CurrencyListFaild(error: "error")
        XCTAssertEqual(store.stateCalculator, AppStateEnum.failed("error"))
    }
}
