//
//  AlertHandler.swift
//  UserDataTask
//
//  Created by Nanda Pradeesh on 23/07/25.
//

import Foundation
import UIKit

public class AlertHandler: NSObject {
    
    // MARK: Singleton
    
    public static let sharedInstance = AlertHandler()
    
    private override init() {
        super.init()
    }
    
    // MARK: Methods
    
    public func showAlert(alertMessage: String, title: String, controller: UIViewController, completion: @escaping (_ isSuccess: Bool) -> Void) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: alertMessage, preferredStyle: .alert)
            let okAction = UIAlertAction(title: Constants.ButtonTitle.alertButtonOKTitle, style: .default) { _ in
                completion(true)
            }
            alert.addAction(okAction)
            if let presentedVC = controller.presentedViewController {
                presentedVC.present(alert, animated: true, completion: nil)
            } else {
                controller.present(alert, animated: true, completion: nil)
            }
        }
    }
}
