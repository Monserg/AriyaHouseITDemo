//
//  MapShowInteractor.swift
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

// MARK: - Business Logic protocols
protocol MapShowBusinessLogic {
    func loadLocationInMap(fromRequestModel requestModel: MapShowModels.Location.RequestModel)
    func loadLocationByTapInMap(fromRequestModel requestModel: MapShowModels.Location.RequestModel)
    func loadLocationByAddressString(fromRequestModel requestModel: MapShowModels.Location.RequestModel)
}

protocol MapShowDataStore {
    // var name: String { get set }
}

class MapShowInteractor: MapShowBusinessLogic, MapShowDataStore {
    // MARK: - Properties
    var presenter: MapShowPresentationLogic?
    var worker: MapShowWorker?
    // var name: String = ""
    let locationManager = MSMLocationManager()
    
    
    // MARK: - Business logic implementation
    func loadLocationInMap(fromRequestModel requestModel: MapShowModels.Location.RequestModel) {
        worker = MapShowWorker()
        worker?.doSomeWork()
        
        // Start MSMLocationManager
        locationManager.startCoreLocation()
        
        // Search location
        locationManager.handlerLocationCompletion = { _ in
            let responseModel = MapShowModels.Location.ResponseModel(locationItems: [self.locationManager.currentLocation])
            self.presenter?.prepareDisplayLocationInMap(fromResponseModel: responseModel)
        }
    }
    
    func loadLocationByTapInMap(fromRequestModel requestModel: MapShowModels.Location.RequestModel) {
        MSMRestApiManager.instance.userRequestDidRun(.locationByCoordinates(requestModel.parameters!), withHandlerResponseAPICompletion: { responseAPI in
            if let data = responseAPI!.data as? [String: AnyObject], data.count > 0 {
                self.locationManager.currentLocation.mapped(json: data)
            }
            
            let responseModel = MapShowModels.Location.ResponseModel(locationItems: [self.locationManager.currentLocation])
            self.presenter?.prepareDisplayLocationByTapInMap(fromResponseModel: responseModel)
        })
    }
    
    func loadLocationByAddressString(fromRequestModel requestModel: MapShowModels.Location.RequestModel) {
        MSMRestApiManager.instance.userRequestDidRun(.locationByAddressString(requestModel.parameters!), withHandlerResponseAPICompletion: { responseAPI in
            var locations = [MSMLocationItem]()

            if let items = responseAPI!.data as? [[String: AnyObject]], items.count > 0 {
                for item in items {
                    let location = MSMLocationItem()
                    location.mapped(json: item)
                    
                    locations.append(location)
                }
            }
            
            let responseModel = MapShowModels.Location.ResponseModel(locationItems: locations)
            self.presenter?.prepareDisplayLocationByAddressString(fromResponseModel: responseModel)
        })
    }
}
