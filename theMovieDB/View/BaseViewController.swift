//
//  BaseViewController.swift
//  theMovieDB
//
//  Created by Vinoth Kumar Ramalingam on 30/07/18.
//  Copyright © 2018 Vinoth Kumar Ramalingam. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    @IBOutlet var errorView: ErrorView?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func showErrorWith(message: String, animated: Bool) {
        errorView?.showErrorWith(message: message, animated: animated)
    }

    func hideError(animated: Bool) {
        errorView?.hideError(animated: animated)
    }

}
