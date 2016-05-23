//
//  Errors.swift
//  Vinci
//
//  Created by Kam Popat on 23/05/2016.
//  Copyright © 2016 Kam Popat. All rights reserved.
//

import Foundation


// --------------------
// MARK: Errors
// --------------------

let kServiceErrorDomain = "Forecast Service"

/// Missing list object in JSON
let kJSONListErrorCode = 0001
let kJSONListErrorMessage = "Response from OWM doesn't contain a list of forecasts"

/// NSError thrown when JSON object returned from OWM doesn't contain a "list" object
let kJSONListError = NSError(domain: kServiceErrorDomain,
                             code: kJSONListErrorCode,
                             userInfo: [NSLocalizedDescriptionKey: kJSONListErrorMessage])

/// Error in response
let kOWMResponseErrorCode = 0002
let kOWMResponseErrorMessage = "Error in response from OWM"


/// NSError thrown when an error is returned in the response object
let kOWMResponseError = NSError(domain: kServiceErrorDomain,
                                code: kOWMResponseErrorCode,
                                userInfo: [NSLocalizedDescriptionKey: kOWMResponseErrorMessage])

/// Response result doesn't have a value
let kOWMResponseNilCode = 0003
let kOWMResponseNilMessage = "Response value is nil"


/// NSError thrown when an error is returned in the response object
let kOWMResponseNilError = NSError(domain: kServiceErrorDomain,
                                   code: kOWMResponseNilCode,
                                   userInfo: [NSLocalizedDescriptionKey: kOWMResponseNilMessage])