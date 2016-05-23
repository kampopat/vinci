//
//  ForecastViewModel.swift
//  Vinci
//
//  Created by Kam Popat on 23/05/2016.
//  Copyright © 2016 Kam Popat. All rights reserved.
//

import Foundation

// --------------------
// MARK: Protocol
// --------------------
protocol ForecastViewModelProtocol {
    // Similar to a forecast response but types are what the view will need
    var weatherDescription: String { get }
    var temp: String { get }
    var tempMax: String { get }
    var tempMin: String { get }
}

// --------------------
// MARK: View Model
// --------------------
struct ForecastViewModel: ForecastViewModelProtocol {
    
    var weatherDescription: String
    var temp: String
    var tempMax: String
    var tempMin: String
    
    /// Create a new view model object using a forecast response
    init(forecast: ForecastResponseProtocol) {
        self.weatherDescription = forecast.weatherDescription
        self.temp = String(forecast.temp) + kDegreeSymbol
        self.tempMax = String(forecast.tempMax) + kDegreeSymbol
        self.tempMin = String(forecast.tempMin) + kDegreeSymbol
    }
}