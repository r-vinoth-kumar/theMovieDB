//
//  ErrorViewTests.swift
//  theMovieDBTests
//
//  Created by Vinoth Kumar Ramalingam on 05/08/18.
//  Copyright © 2018 Vinoth Kumar Ramalingam. All rights reserved.
//

import XCTest
import UIKit

@testable import theMovieDB

class ErrorViewTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testShowErrorView() {
        let errorMessage = "Error"
        let view = ErrorView()
        view.message = UILabel()
        view.showErrorWith(message: errorMessage, animated: true)
        XCTAssertEqual(view.isHidden, false)
        XCTAssertEqual(errorMessage, view.message.text)
    }

    func testHideErrorView() {
        let errorMessage = "Error"
        let view = ErrorView()
        view.message = UILabel()
        view.showErrorWith(message: errorMessage, animated: false)
        view.hideError(animated: false)
        XCTAssertEqual(view.isHidden, true)
    }

    func testErrorViewAlreadyShown() {
        let errorMessage = "Error"
        let view = ErrorView()
        view.message = UILabel()
        view.showErrorWith(message: errorMessage, animated: false)
        view.showErrorWith(message: errorMessage, animated: true)
        XCTAssertEqual(view.isHidden, false)
    }

    func testErrorViewAlreadyHidden() {
        let view = ErrorView()
        view.hideError(animated: true)
        XCTAssertEqual(view.isHidden, true)
    }
}
