//
//  MapShowModels.swift
//  AriyaHouseITDemo
//
//  Created by msm72 on 29.08.17.
//  Copyright (c) 2017 RemoteJob. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

// MARK: - Data models
enum MapShowModels {
    // MARK: - Use cases
    enum Location {
        struct RequestModel {
            let parameters: [String: Any]?
        }
        
        struct ResponseModel {
            let locationItems: [MSMLocationItem]
        }
        
        struct ViewModel {
            let locationItems: [MSMLocationItem]
        }
    }
}
