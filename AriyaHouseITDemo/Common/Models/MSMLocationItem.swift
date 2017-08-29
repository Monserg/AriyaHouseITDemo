//
//  LocationItem.swift
//  OmnieCommerce
//
//  Created by msm72 on 27.05.17.
//  Copyright © 2017 Omniesoft. All rights reserved.
//

import Foundation
import CoreLocation

class MSMLocationItem {
    // MARK: - Properties
    var codeID: Int64!
    var name: String?
    var latitude: CLLocationDegrees?
    var longitude: CLLocationDegrees?
    var countryCode: String?
    var isVerified = true
    
    
    // MARK: - Class Initialization
    init(codeID: Int64!, name: String?, latitude: CLLocationDegrees?, longitude: CLLocationDegrees?, countryCode: String?) {
        self.codeID = codeID
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.countryCode = countryCode
    }

    
    // MARK: - Custom Functions
    func mapped(json: [String: AnyObject]) {
        if let codeID = json["id"] as? Int64 {
            self.codeID = codeID
        }
        
        if let name = json["name"] as? String {
            self.name = name
        }
        
        if let latitude = json["latitude"] as? Double {
            self.latitude = latitude
        }
        
        if let longitude = json["longitude"] as? Double {
            self.longitude = longitude
        }
    }

    
    // MARK: - Custom Functions
    func verifyCoordinates(completion: HandlerLocationCompletion) {
        // Use case "Open map"
        if (countryCode! != "RU" && countryCode! != "KZ") {
            self.latitude   =   49.80456319954445
            self.longitude  =   73.07684898376465
            self.isVerified =   false
        }
        
        completion()
    }
}
