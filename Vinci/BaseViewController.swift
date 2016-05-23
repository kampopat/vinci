//
//  BaseViewController.swift
//  Vinci
//
//  Created by Kam Popat on 23/05/2016.
//  Copyright © 2016 Kam Popat. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    ////////////////////////////////////////////////////////////////////////////////
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    ////////////////////////////////////////////////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = kDefaultBackgroundColour
    }
}
