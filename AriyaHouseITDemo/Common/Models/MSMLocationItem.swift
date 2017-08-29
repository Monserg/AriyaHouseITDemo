//
//  LocationItem.swift
//  OmnieCommerce
//
//  Created by msm72 on 27.05.17.
//  Copyright © 2017 Omniesoft. All rights reserved.
//

import Foundation
import CoreLocation

struct MSMLocationItem {
    // MARK: - Properties
    var name: String!
    var latitude: CLLocationDegrees?
    var longitude: CLLocationDegrees?
    var addressCity: String?
    var addressStreet: String?
    var countryCode: String?
    var isVerified: Bool!
    
    
    // MARK: - Custom Functions
    mutating func verifyCoordinates(completion: HandlerLocationCompletion) {
        // Use case "Open map"
        if (countryCode! != "RU" && countryCode! != "KZ") {
            self.latitude   =   49.80456319954445
            self.longitude  =   73.07684898376465
            self.isVerified =   false
        }
        
        completion()
    }
}
