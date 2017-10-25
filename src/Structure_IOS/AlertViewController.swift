//
//  AlertViewController.swift
//  Structure_IOS
//
//  Created by DaoLQ on 10/24/17.
//  Copyright © 2017 DaoLQ. All rights reserved.
//

import UIKit

protocol AlertViewController {
}

extension AlertViewController where Self: UIViewController {

    func showAlertView(title: String?, message: String?, cancelButton: String?, otherButtons: [String]? = nil, type: UIAlertControllerStyle = .alert, cancelAction: (() -> ())? = nil, otherAction: ((Int) -> ())? = nil) {
        let alertViewController = UIAlertController(title: title ?? Constants.appName ,
                                                    message: message,
                                                    preferredStyle: .alert)
        
        if let cancelButton = cancelButton {
            let cancelAction = UIAlertAction(title: cancelButton, style: .cancel, handler: { (action) in
                cancelAction?()
            })
            alertViewController.addAction(cancelAction)
        }
        
        if let otherButtons = otherButtons {
            for (index, otherButton) in otherButtons.enumerated() {
                let otherAction = UIAlertAction(title: otherButton,
                                                style: .default, handler: { (action) in
                                                    otherAction?(index)
                })
                alertViewController.addAction(otherAction)
            }
        }
        DispatchQueue.main.async {
            self.present(alertViewController, animated: true, completion: nil)
        }
    }
    
    func showErrorAlert(message:String?) {
        showAlertView(title: "Error", message: message, cancelButton: "OK")
    }
}
