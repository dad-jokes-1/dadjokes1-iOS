//
//  UIViewController+Ext.swift
//  DadJokes
//
//  Created by John Kouris on 1/3/20.
//  Copyright © 2020 John Kouris. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentDJAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = DJAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
}
