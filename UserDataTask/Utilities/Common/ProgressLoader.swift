//
//  ProgressLoader.swift
//  UserDataTask
//
//  Created by Nanda Pradeesh on 23/07/25.
//

import Foundation
import UIKit

extension UIViewController {
    private var loaderAlertController: UIAlertController? {  // Keep a reference to the loader alert
        return presentedViewController as? UIAlertController
    }

    func showLoaderProgress(completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: nil, message: "Please wait\n\n", preferredStyle: .alert)
        let spinnerIndicator = UIActivityIndicatorView(style: .medium)
        spinnerIndicator.center = CGPoint(x: 135.0, y: 65.5)
        spinnerIndicator.color = UIColor.black
        spinnerIndicator.startAnimating()
        alertController.view.addSubview(spinnerIndicator)
        present(alertController, animated: false, completion: completion)
    }
    
    func dismissAlert() {
        loaderAlertController?.dismiss(animated: true, completion: nil)
    }
}
