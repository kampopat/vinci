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
    private var _pageControl = UIPageControl()
    
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
    // MARK: View Management
    // --------------------
    ////////////////////////////////////////////////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePageControl()
        self.view.addSubview(_pageControl)
    }
    
    ////////////////////////////////////////////////////////////////////////////////
    private func configurePageControl() {
        _pageControl.numberOfPages = self._viewControllers.count
        _pageControl.currentPage = 0
        _pageControl.alpha = 0.75
        _pageControl.center = CGPoint(x: self.view.bounds.midX,
                                      y: self.view.bounds.height - 30.0)
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
    
    ////////////////////////////////////////////////////////////////////////////////
    func changedToPageIndex(index: Int) {
        _pageControl.currentPage = index
    }
}