//
//  UIViewControllerExtension.swift
//  onTheMap
//
//  Created by Mohamed Abdelkhalek Salah on 5/4/20.
//  Copyright © 2020 Mohamed Abdelkhalek Salah. All rights reserved.
//

import Foundation
import UIKit


extension UIViewController {
    func showAlertError(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Try Again!", style: .default, handler: { (action) in
            self.navigationController?.popViewController(animated: true)
        }))
        present(alertVC, animated: true, completion: nil)
    }
}
