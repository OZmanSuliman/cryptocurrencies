//
//  CurrencyListErrorView.swift
//  CryptocurrenciesUITests
//
//  Created by Osman Ahmed on 22/01/2023.
//

import SwiftUI
import XCTest
@testable import Cryptocurrencies

class CurrencyListErrorViewTests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["testing"]
        app.launch()
    }
    
    func testErrorTextIsDisplayed() {
        let welcome = app.textViews["errorText"]
        XCTAssert(welcome.waitForExistence(timeout: 10))
    }


}
