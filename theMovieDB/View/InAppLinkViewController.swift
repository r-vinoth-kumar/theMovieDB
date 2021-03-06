//
//  InAppLinkViewController.swift
//  theMovieDB
//
//  Created by Vinoth Kumar Ramalingam on 05/08/18.
//  Copyright © 2018 Vinoth Kumar Ramalingam. All rights reserved.
//

import UIKit
import WebKit

class InAppLinkViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    var link: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.webView.load(URLRequest(url: URL(string: link!)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 100))
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
}
