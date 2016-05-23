//
//  ForecastContainer.swift
//  Vinci
//
//  Created by Kam Popat on 23/05/2016.
//  Copyright © 2016 Kam Popat. All rights reserved.
//

import UIKit
import ReactiveCocoa

class ForecastContainer: BaseViewController {
    
    private var _swipeVC: ForecastSwipeController!
    
    // --------------------
    // MARK: View Management
    // --------------------
    ////////////////////////////////////////////////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let service = ForecastService(url: kOWMBaseUrl)
        service.forecastProducer()
            .flatMap(.Concat, transform: self.viewControllersProducer)
            .startWithNext { viewControllers in
                self._swipeVC = ForecastSwipeController(
                    viewControllers: viewControllers)
                self.addChildViewController(self._swipeVC)
                self.view.addSubview(self._swipeVC.view)
        }
    }

    
    ////////////////////////////////////////////////////////////////////////////////
    private func viewControllersProducer(forecasts: [ForecastResponseProtocol])
        -> SignalProducer<[UIViewController], NSError> {
        
        return SignalProducer(values: forecasts)
            .flatMap(FlattenStrategy.Concat,
                     transform: self.viewControllerProducer)
            .collect()
    }
    
    ////////////////////////////////////////////////////////////////////////////////
    private func viewControllerProducer(forecast: ForecastResponseProtocol)
        -> SignalProducer<UIViewController, NSError> {
            
            return SignalProducer { observer, _ in
                let dailyVM = ForecastViewModel(forecast: forecast)
                let dailyVC = ForecastViewController(viewModel: dailyVM)
                observer.sendNext(dailyVC)
                observer.sendCompleted()
            }
    }
    
    
}