//
//  ForecastResponse.swift
//  Vinci
//
//  Created by Kam Popat on 23/05/2016.
//  Copyright © 2016 Kam Popat. All rights reserved.
//

import Foundation

// --------------------
// MARK: Forecast Response Protocol
// --------------------

/// The weather properties we care about receiving from OWM
protocol ForecastResponseProtocol {
    var weatherDescription: String { get }
    var temp: Double { get }
    var tempMax: Double { get }
    var tempMin: Double { get }
}


// --------------------
// MARK: Forecast Response
// --------------------

struct ForecastResponse: ForecastResponseProtocol {
    var weatherDescription: String
    var temp: Double
    var tempMax: Double
    var tempMin: Double
}