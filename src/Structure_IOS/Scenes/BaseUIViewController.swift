//
//  BaseUIViewController.swift
//  Structure_IOS
//
//  Created by DaoLQ on 10/24/17.
//  Copyright © 2017 DaoLQ. All rights reserved.
//

import UIKit

class BaseUIViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        guard (self.viewIfLoaded != nil) else { return }
    }
}
