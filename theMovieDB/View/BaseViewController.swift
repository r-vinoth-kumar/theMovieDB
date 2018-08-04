//
//  BaseViewController.swift
//  theMovieDB
//
//  Created by Vinoth Kumar Ramalingam on 30/07/18.
//  Copyright © 2018 Vinoth Kumar Ramalingam. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    @IBOutlet var errorView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func showErrorWith(message: String, animated: Bool) {
    }

    func hideError(animated: Bool) {
    }

}
