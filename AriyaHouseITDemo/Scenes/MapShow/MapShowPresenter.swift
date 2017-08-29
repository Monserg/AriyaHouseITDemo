//
//  MapShowPresenter.swift
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

// MARK: - Presentation Logic protocols
protocol MapShowPresentationLogic {
    func presentSomething(response: MapShowModels.Something.ResponseModel)
}

class MapShowPresenter: MapShowPresentationLogic {
    // MARK: - Properties
    weak var viewController: MapShowDisplayLogic?
    
    
    // MARK: - Presentation Logic implementation
    func presentSomething(response: MapShowModels.Something.ResponseModel) {
        let viewModel = MapShowModels.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}