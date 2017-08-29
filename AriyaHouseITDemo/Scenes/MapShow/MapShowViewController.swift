//
//  MapShowViewController.swift
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
import GoogleMaps

// MARK: - Input & Output protocols
protocol MapShowDisplayLogic: class {
    func displayLocationInMap(fromViewModel viewModel: MapShowModels.Location.ViewModel)
    func displayLocationByTapInMap(fromViewModel viewModel: MapShowModels.Location.ViewModel)
}

class MapShowViewController: UIViewController {
    // MARK: - Properties
    var interactor: MapShowBusinessLogic?
    var router: (NSObjectProtocol & MapShowRoutingLogic & MapShowDataPassing)?
    var marker: GMSMarker?
    
    // MARK: - IBOutlets
    // @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var mapView: GMSMapView! {
        didSet {
            self.mapView.delegate = self
        }
    }

    
    // MARK: - Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    
    // MARK: - Setup
    private func setup() {
        let viewController  =   self
        let interactor      =   MapShowInteractor()
        let presenter       =   MapShowPresenter()
        let router          =   MapShowRouter()
        
        viewController.interactor   =   interactor
        viewController.router       =   router
        interactor.presenter        =   presenter
        presenter.viewController    =   viewController
        router.viewController       =   viewController
        router.dataStore            =   interactor
    }
    
    
    // MARK: - Routing
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewSettingsDidLoad()
    }
    
    
    // MARK: - Custom Functions
    func viewSettingsDidLoad() {
        let loadLocationInMapRequestModel = MapShowModels.Location.RequestModel(parameters: nil)
        interactor?.loadLocationInMap(fromRequestModel: loadLocationInMapRequestModel)
        
        // Setup Google Map
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.mapType = .normal
    }
    
    func mapRegionDidLoad(location: MSMLocationItem) {
        let coordinate = CLLocationCoordinate2D(latitude: location.latitude!, longitude: location.longitude!)
        self.mapView.camera = GMSCameraPosition(target: coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
    }
    
    func mapAddMarkers(markers: [CLLocationCoordinate2D]) {
        // Delete all markers
        self.mapView.clear()
        
        // Add new markers from API
        for location in markers {
            // Add custom marker
            let coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            let marker = GMSMarker(position: coordinate)
            marker.map = mapView
            marker.icon = GMSMarker.markerImage(with: .green)
        }
    }
}


// MARK: - MapShowDisplayLogic
extension MapShowViewController: MapShowDisplayLogic {
    func displayLocationInMap(fromViewModel viewModel: MapShowModels.Location.ViewModel) {
        mapRegionDidLoad(location: viewModel.locationItem)
        
        // Add custom marker
        if (!viewModel.locationItem.isVerified) {
            let coordinate = CLLocationCoordinate2D(latitude: viewModel.locationItem.latitude!, longitude: viewModel.locationItem.longitude!)
            self.marker = GMSMarker(position: coordinate)
            self.marker!.map = mapView
            self.marker!.icon = GMSMarker.markerImage(with: .green)
        }
    }
    
    func displayLocationByTapInMap(fromViewModel viewModel: MapShowModels.Location.ViewModel) {
        mapRegionDidLoad(location: viewModel.locationItem)

        // Add custom marker
        let coordinate = CLLocationCoordinate2D(latitude: viewModel.locationItem.latitude!, longitude: viewModel.locationItem.longitude!)

        mapAddMarkers(markers: [coordinate])
    }
}


// MARK: - GMSMapViewDelegate
extension MapShowViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        let loadLocationByTapInMapRequestModel = MapShowModels.Location.RequestModel(parameters: [ "latitude": coordinate.latitude,
                                                                                                   "longitude": coordinate.longitude])
        
        interactor?.loadLocationByTapInMap(fromRequestModel: loadLocationByTapInMapRequestModel)
    }
}
