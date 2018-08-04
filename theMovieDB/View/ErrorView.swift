//
//  ErrorView.swift
//  theMovieDB
//
//  Created by Vinoth Kumar Ramalingam on 05/08/18.
//  Copyright © 2018 Vinoth Kumar Ramalingam. All rights reserved.
//

import UIKit

class ErrorView: UIView {
    @IBOutlet weak var message: UILabel!
    private var errorShowed = false

    func showErrorWith(message: String, animated: Bool) {
        if errorShowed {
            return
        }
        errorShowed = true
        self.isHidden = false
        self.message.text = message
        if (animated) {
            self.frame.origin.y += 40
            UIView.animate(withDuration: 0.4,
                           delay: 0,
                           options: .curveEaseOut,
                           animations: {
                            self.frame.origin.y -= 40
            }, completion: { _ in })
        }
    }

    func hideError(animated: Bool) {
        if !errorShowed {
            return
        }
        errorShowed = false
        if !animated {
            self.isHidden = true
        }
        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       options: .curveEaseOut,
                       animations: {
                        self.frame.origin.y += 40
        }, completion: { _ in
            self.frame.origin.y -= 40
            self.isHidden = true
        })
    }
}
