//
//  Alertable.swift
//  BandLabApp
//
//  Created by l.vasilyeva on 23.04.2022.
//  Copyright © 2022 AlexeyVasilyev. All rights reserved.
//

import UIKit

public protocol Alertable {}

public extension Alertable where Self: UIViewController {
    
    func showAlert(title: String = "", message: String, preferredStyle: UIAlertController.Style = .alert, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: completion)
    }
}
