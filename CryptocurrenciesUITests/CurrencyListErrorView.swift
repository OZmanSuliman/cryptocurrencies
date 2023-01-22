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
    
    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    
    func testErrorTextIsDisplayed() {
        let error = "Test Error"
        let view = CurrencyListErrorView(error: error)
        let viewHostingController = UIHostingController(rootView: view)
        
        let errorText = viewHostingController.view.subviews.first(where: { $0 is UILabel }) as? UILabel
        XCTAssertNotNil(errorText)
        XCTAssertEqual(errorText?.text, error)
    }
}
