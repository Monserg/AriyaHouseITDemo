//
//  UIViewController+Ext.swift
//  OmnieCommerce
//
//  Created by msm72 on 06.03.17.
//  Copyright © 2017 Omniesoft. All rights reserved.
//

import UIKit
import Localize_Swift

extension UIViewController {
    func alertViewDidShow(withTitle title: String, andMessage message: String, completion: @escaping (() -> ())) {
        let alertViewController = UIAlertController.init(title: title.localized(), message: message.localized(), preferredStyle: .alert)
        
        let alertViewControllerAction = UIAlertAction.init(title: "Ok".localized(), style: .default, handler: { action in
            return completion()
        })
        
        alertViewController.addAction(alertViewControllerAction)
        present(alertViewController, animated: true, completion: nil)
    }
}
