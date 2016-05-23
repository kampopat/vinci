//
//  ForecastResponseFactory.swift
//  Vinci
//
//  Created by Kam Popat on 23/05/2016.
//  Copyright © 2016 Kam Popat. All rights reserved.
//

import Foundation
import ReactiveCocoa
import SwiftyJSON

// --------------------
// MARK: Protocol
// --------------------
protocol ForecastResponseFactoryProtocol {
    
    /// Produce a list of ForecastResponse objects from response JSON
    static func forecastResponsesProducer(json: JSON)
        -> SignalProducer<[ForecastResponseProtocol], NSError>
}


// --------------------
// MARK: Factory
// --------------------
struct ForecastResponseFactory: ForecastResponseFactoryProtocol {
    
    ////////////////////////////////////////////////////////////////////////////////
    static func forecastResponsesProducer(json: JSON)
        -> SignalProducer<[ForecastResponseProtocol], NSError> {
            
            return SignalProducer { observer, _ in
                guard let forecastList = json["list"].array else {
                    observer.sendFailed(kJSONListError)
                    return
                }
                observer.sendNext(forecastList.flatMap(self.forecastResponse))
                observer.sendCompleted()
            }
    }
    
    ////////////////////////////////////////////////////////////////////////////////
    static private func forecastResponse(forecastJSON: JSON) -> ForecastResponseProtocol {
        
        let timeInterval = forecastJSON["dt"].intValue
        let description = forecastJSON["weather"][0]["description"].stringValue
        let temp = forecastJSON["temp"]["day"].doubleValue
        let tempMax = forecastJSON["temp"]["max"].doubleValue
        let tempMin = forecastJSON["temp"]["min"].doubleValue
        
        let response = ForecastResponse(
            timeInterval: timeInterval,
            weatherDescription: description,
            temp: temp,
            tempMax: tempMax,
            tempMin: tempMin)
        
        return response
    }
}