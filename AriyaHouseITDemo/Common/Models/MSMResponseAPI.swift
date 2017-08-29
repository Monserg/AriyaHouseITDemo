//
//  ResponseAPI.swift
//  OmnieCommerce
//
//  Created by msm72 on 13.03.17.
//  Copyright © 2017 Omniesoft. All rights reserved.
//

import Foundation
import SwiftyJSON
import CoreData

enum BodyType {
    case ItemsArray
    case ItemsDictionary
}

class MSMResponseAPI {
    // MARK: - Properties
    var data: Any?
    
    
    // MARK: - Class Initialization
    init(fromJSON json: JSON, withBodyType type: BodyType) {
        switch type {
        case .ItemsDictionary:
            if let data = json["data"].dictionaryObject {
                self.data = data
            }
            
        case .ItemsArray:
            if let data = json["data"].arrayObject {
                self.data = data
            }
        }
    }
}
