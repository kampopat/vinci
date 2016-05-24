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
    private var _service: ForecastServiceProtocol!
    
    // --------------------
    // MARK: UI Elements
    // --------------------
    private var _titleLabel = UILabel()
    private var _retryLabel = UILabel()
    private var _retryGesture = UITapGestureRecognizer()

    // --------------------
    // MARK: Initialisation
    // --------------------
    ////////////////////////////////////////////////////////////////////////////////
    init(service: ForecastServiceProtocol) {
        self._service = service
        super.init(nibName: nil, bundle: nil)
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
        
        configureTitleLabel()
        configureRetryLabel()
        
        self.view.addSubview(_titleLabel)
        self.view.addSubview(_retryLabel)
        
        configureGestureForRetries()
        getViewControllersForSwipeController()
    }
    
    ////////////////////////////////////////////////////////////////////////////////
    private func configureTitleLabel() {
        _titleLabel.text = "Vinci".uppercaseString
        _titleLabel.textColor = UIColor.whiteColor()
        _titleLabel.font = UIFont(name: kDefaultFontBold, size: 20.0)
        _titleLabel.sizeToFit()
        _titleLabel.center = CGPoint(x: self.view.bounds.midX,
                                     y: 35.0)
    }
    
    ////////////////////////////////////////////////////////////////////////////////
    private func configureRetryLabel() {
        _retryLabel.text = kRetryMessage
        _retryLabel.textColor = UIColor.whiteColor()
        _retryLabel.font = UIFont(name: kDefaultFontRegular, size: 22.0)
        _retryLabel.numberOfLines = 0
        _retryLabel.textAlignment = .Center
        let size = CGSize(width: self.view.bounds.width - 85.0,
                          height: self.view.bounds.height)
        
        _retryLabel.frame.size =  _retryLabel.sizeThatFits(size)
        _retryLabel.center = self.view.center
        _retryLabel.alpha = 0.0
        
    }
    
    ////////////////////////////////////////////////////////////////////////////////
    private func configureGestureForRetries() {
        _retryGesture.numberOfTapsRequired = 2
        _retryGesture.numberOfTouchesRequired = 1
        
        _retryGesture.rac_gestureSignal()
            .subscribeNext { [unowned self] _ in
                self.getViewControllersForSwipeController()
        }
    }
    
    ////////////////////////////////////////////////////////////////////////////////
    private func getViewControllersForSwipeController() {
        self.hideRetryMessage()
        self.view.removeGestureRecognizer(self._retryGesture)
        self._service.forecastProducer()
            .flatMap(.Concat, transform: self.viewControllersProducer)
            .start({ (event) in
                switch event {
                case let .Next(viewControllers):
                    self.configureSwipeController(viewControllers)
                case .Failed(_):
                    self.view.addGestureRecognizer(self._retryGesture)
                    self.displayRetryMessage()
                default:
                    break
                }
            })
    }
    
    ////////////////////////////////////////////////////////////////////////////////
    private func configureSwipeController(viewControllers: [UIViewController]) {
        self._swipeVC = ForecastSwipeController(
            viewControllers: viewControllers)
        self.addChildViewController(self._swipeVC)
        self.view.insertSubview(self._swipeVC.view,
                                belowSubview: self._titleLabel)
    }
    
    ////////////////////////////////////////////////////////////////////////////////
    private func displayRetryMessage() {
        UIView.animateWithDuration(0.5) {
            self._retryLabel.alpha = 1.0
        }
    }
    
    ////////////////////////////////////////////////////////////////////////////////
    private func hideRetryMessage() {
        UIView.animateWithDuration(0.35) {
            self._retryLabel.alpha = 0.0
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