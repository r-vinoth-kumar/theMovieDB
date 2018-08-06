//
//  InAppLinkViewControllerTest.swift
//  theMovieDBTests
//
//  Created by Vinoth Kumar Ramalingam on 05/08/18.
//  Copyright © 2018 Vinoth Kumar Ramalingam. All rights reserved.
//

import XCTest
import WebKit

@testable import theMovieDB

class InAppLinkViewControllerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInAppLinkLoad() {
        let link = "https://www.foxmovies.com/movies/fight-club"
        let VC = InAppLinkViewController(nibName: nil, bundle: nil)
        VC.webView = WKWebView()
        VC.link = link
        VC.viewDidLoad()
        XCTAssertEqual(link, VC.link)
    }
}
