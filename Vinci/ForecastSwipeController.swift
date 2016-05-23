//
//  ForecastSwipeController.swift
//  Vinci
//
//  Created by Kam Popat on 23/05/2016.
//  Copyright © 2016 Kam Popat. All rights reserved.
//

import UIKit
import EZSwipeController

class ForecastSwipeController: EZSwipeController {
    
    private var _viewControllers: [UIViewController]
    
    // --------------------
    // MARK: Initialisation
    // --------------------
    ////////////////////////////////////////////////////////////////////////////////
    init(viewControllers: [UIViewController]) {
        self._viewControllers = viewControllers
        super.init()
    }
    
    ////////////////////////////////////////////////////////////////////////////////
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // --------------------
    // MARK: EZSwipeController
    // --------------------
    ////////////////////////////////////////////////////////////////////////////////
    override func setupView() {
        super.setupView()
        datasource = self
        navigationBarShouldNotExist = true
    }
    
    // --------------------
    // MARK: Misc
    // --------------------
    ////////////////////////////////////////////////////////////////////////////////
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}

// --------------------
// MARK: EZSwipeController Data source
// --------------------
extension ForecastSwipeController: EZSwipeControllerDataSource {
    
    ////////////////////////////////////////////////////////////////////////////////
    func viewControllerData() -> [UIViewController] {
        return self._viewControllers
    }
}