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
    private var _descriptionLabel = UILabel()
    
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
        _descriptionLabel.text = _viewModel.weatherDescription
        _descriptionLabel.textColor = UIColor.whiteColor()
        _descriptionLabel.sizeToFit()
        _descriptionLabel.center = self.view.center
        
        self.view.addSubview(_descriptionLabel)
    }
}