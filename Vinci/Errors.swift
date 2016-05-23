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