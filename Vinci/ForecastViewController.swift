//
//  ForecastViewController.swift
//  Vinci
//
//  Created by Kam Popat on 23/05/2016.
//  Copyright © 2016 Kam Popat. All rights reserved.
//

import UIKit
import Chameleon

class ForecastViewController: BaseViewController {
    
    private var _viewModel: ForecastViewModelProtocol
    
    // --------------------
    // MARK: UI Elements
    // --------------------
    private var _temperatureLabel = UILabel()
    private var _descriptionLabel = UILabel()
    private var _dateLabel = UILabel()
    private var _temperatureContainer = UIView()
    private var _maxTempLabel = UILabel()
    private var _minTempLabel = UILabel()
    
    // --------------------
    // MARK: Initialisation
    // --------------------
    ////////////////////////////////////////////////////////////////////////////////
    init(viewModel: ForecastViewModelProtocol) {
        self._viewModel = viewModel
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
        self.view.backgroundColor = RandomFlatColorWithShade(.Dark)
        
        configureTemperatureLabel()
        configureDescriptionLabel()
        configureDateLabel()
        
        self.view.addSubview(_temperatureLabel)
        self.view.addSubview(_descriptionLabel)
        self.view.addSubview(_dateLabel)
    }
    
    ////////////////////////////////////////////////////////////////////////////////
    private func configureTemperatureLabel() {
        _temperatureLabel.text = _viewModel.temp
        _temperatureLabel.textColor = UIColor.whiteColor()
        _temperatureLabel.font = UIFont(name: kDefaultFontUltraLight, size: 125.0)
        _temperatureLabel.sizeToFit()
        _temperatureLabel.center = CGPoint(x: self.view.bounds.midX,
                                           y: self.view.bounds.midY - 60.0)
    }
    
    ////////////////////////////////////////////////////////////////////////////////
    private func configureDescriptionLabel() {
        _descriptionLabel.text = _viewModel.weatherDescription.uppercaseString
        _descriptionLabel.textColor = UIColor.whiteColor()
        _descriptionLabel.font = UIFont(name: kDefaultFontBold, size: 32.0)
        _descriptionLabel.numberOfLines = 0
        _descriptionLabel.textAlignment = .Center
        let size = CGSize(width: self.view.bounds.width - 55.0,
                          height: self.view.bounds.height)
        
        _descriptionLabel.frame.size = _descriptionLabel.sizeThatFits(size)
        _descriptionLabel.center = CGPoint(x: self.view.bounds.midX,
                                           y: self.view.bounds.midY
                                            + CGFloat(_descriptionLabel.frame.height/4)
                                            + 45.0)
    }
    
    ////////////////////////////////////////////////////////////////////////////////
    private func configureDateLabel() {
        _dateLabel.text = _viewModel.date
        _dateLabel.textColor = UIColor.whiteColor()
        _dateLabel.font = UIFont(name: kDefaultFontRegular, size: 22.0)
        _dateLabel.sizeToFit()
        _dateLabel.center = CGPoint(x: self.view.bounds.midX,
                                    y: _descriptionLabel.frame.origin.y
                                        + _descriptionLabel.frame.size.height
                                        + 40.0)
    }
}













