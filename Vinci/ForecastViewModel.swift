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
    var date: String { get }
    var weatherDescription: String { get }
    var temp: String { get }
}

// --------------------
// MARK: View Model
// --------------------
struct ForecastViewModel: ForecastViewModelProtocol {
    var date: String
    var weatherDescription: String
    var temp: String
    
    /// Create a new view model object using a forecast response
    init(forecast: ForecastResponseProtocol) {
        self.weatherDescription = forecast.weatherDescription
        self.temp = String(format: "%.0f", forecast.temp) + kDegreeSymbol
        
        let newdateFormatter = NSDateFormatter()
        newdateFormatter.locale = NSLocale.currentLocale()
        newdateFormatter.dateFormat = "EEE dd MMM"
        self.date = newdateFormatter.stringFromDate(
            NSDate(timeIntervalSince1970: NSTimeInterval(forecast.timeInterval)))
    }
}