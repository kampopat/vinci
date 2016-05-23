//
//  ForecastService.swift
//  Vinci
//
//  Created by Kam Popat on 23/05/2016.
//  Copyright © 2016 Kam Popat. All rights reserved.
//

import Foundation
import Alamofire
import ReactiveCocoa
import SwiftyJSON
import enum Result.NoError
import Reachability


typealias RequestParameters = [String : AnyObject]

// --------------------
// MARK: Forecast Service Protocol
// --------------------
protocol ForecastServiceProtocol {
    var url: String { get }
    
    func forecastProducer() -> SignalProducer<[ForecastResponseProtocol], NSError>
    func requestParameterProducer() -> SignalProducer<RequestParameters, NoError>
}


// --------------------
// MARK: Forecast Service
// --------------------
struct ForecastService: ForecastServiceProtocol {
    var url: String
    
    ////////////////////////////////////////////////////////////////////////////////
    func requestParameterProducer() -> SignalProducer<RequestParameters, NoError> {
        return SignalProducer { observer, _ in
            
            var parameters = RequestParameters()
            parameters["q"] = kOWMLocation
            parameters["units"] = kOWMUnits
            parameters["cnt"] = kOWMCount
            parameters["lang"] = kOWMLanguage
            parameters["appid"] = kOWMAppID
            
            observer.sendNext(parameters)
            observer.sendCompleted()
        }
    }
    
    ////////////////////////////////////////////////////////////////////////////////
    func forecastProducer() -> SignalProducer<[ForecastResponseProtocol], NSError> {
        
        return self.requestParameterProducer()
            .promoteErrors(NSError)
            .flatMap(.Latest, transform: self.apiRequestProducer)
            .flatMap(.Latest, transform: self.apiResponseProducer)
        
        //TODO: Timeout?
    }
    
    ////////////////////////////////////////////////////////////////////////////////
    private func apiRequestProducer(parameters: RequestParameters)
        -> SignalProducer<Request, NSError> {
            
            return SignalProducer { observer, _ in
                let request = Alamofire.request(.GET, self.url, parameters: parameters)
                observer.sendNext(request)
                observer.sendCompleted()
            }
    }
    
    ////////////////////////////////////////////////////////////////////////////////
    private func apiResponseProducer(request: Request)
        -> SignalProducer<[ForecastResponseProtocol], NSError> {
            
            return SignalProducer { observer, _ in
                
                request.responseJSON { response in
                
                    //Make sure error is nil
                    guard response.result.error == nil else {
                        log.error("\(response.result.error)")
                        observer.sendFailed(kOWMResponseError)
                        return
                    }
                    
                    //Make sure response has a value
                    guard let value = response.result.value else {
                        observer.sendFailed(kOWMResponseNilError)
                        return
                    }
                    
                    //Get forecast response array
                    ForecastResponseFactory
                        .forecastResponsesProducer(JSON(value))
                        .start({ (event) -> () in
                            switch (event) {
                            case let .Next(response):
                                observer.sendNext(response)
                            case .Completed():
                                observer.sendCompleted()
                            default:
                                break
                            }
                        })
                }
            }
    }
}