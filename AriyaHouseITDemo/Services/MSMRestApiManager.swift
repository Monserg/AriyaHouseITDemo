//
//  MSMRestApiManager.swift
//  OmnieCommerce
//
//  Created by msm72 on 13.03.17.
//  Copyright © 2017 Omniesoft. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

typealias RequestParametersType = (method: HTTPMethod, apiStringURL: String, bodyType: BodyType, parameters: [String: Any]?)

enum RequestType {
    // Location
    case locationByCoordinates([String: Any])
    
    
    func introduced() -> RequestParametersType {
        // Parametes named such as in Postman
        switch self {
        // Location
        case .locationByCoordinates(let params):    return (method: .get,
                                                            apiStringURL: "/clientGeocode",
                                                            bodyType: .ItemsDictionary,
                                                            parameters: params)
        }
    }
}

final class MSMRestApiManager {
    // MARK: - Properties
    static let instance = MSMRestApiManager()
    
    var appURL: URL!
    let appHostURL = URL.init(string: "https://api-dev.supermenu.kz/address")!
    let headers = ["Content-Type": "application/json"]
    
    var appApiString: String! {
        didSet {
            appURL = appHostURL.appendingPathComponent(appApiString)
        }
    }
    
    // MARK: - Class Initialization
    private init() { }
    
    
    // MARK: - Class Functions
    
    // Main Generic func
    func userRequestDidRun(_ requestType: RequestType, withHandlerResponseAPICompletion handlerResponseAPICompletion: @escaping (MSMResponseAPI?) -> Void) {
        let requestParameters = requestType.introduced()
        appApiString = requestParameters.apiStringURL
        
        if (requestParameters.parameters != nil) {
            for (index, dictionary) in requestParameters.parameters!.enumerated() {
                let key = dictionary.key
                let value = dictionary.value
                
                if (index) == 0 {
                    appURL = URL.init(string: appURL.absoluteString.appending("?\(key)=\(value)"))
                } else {
                    appURL = URL.init(string: appURL.absoluteString.appending("&\(key)=\(value)"))
                }
            }
        }
        
        Alamofire.request(appURL, method: requestParameters.method, parameters: requestParameters.parameters, encoding: URLEncoding.default, headers: headers).responseJSON { dataResponse -> Void in
            guard dataResponse.error == nil && dataResponse.result.value != nil else {
                handlerResponseAPICompletion(nil)
                return
            }
            
            var responseAPI: MSMResponseAPI!
            let json = JSON(dataResponse.result.value!)
            responseAPI = MSMResponseAPI.init(fromJSON: json, withBodyType: requestParameters.bodyType)
            
            handlerResponseAPICompletion(responseAPI)
         
            return
        }
    }
}
