//
//  UIViewController+Extension.swift
//  UserDataTask
//
//  Created by Nanda Pradeesh on 23/07/25.
//

import UIKit

// MARK: - Keyboard Handling
extension UIViewController {

    func observeKeyboardChanges(scrollView: UIScrollView) {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification,
                                               object: nil,
                                               queue: .main) { [weak self] notification in
            guard let self = self,
                  let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
            scrollView.contentInset.bottom = keyboardFrame.height + 20
        }

        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification,
                                               object: nil,
                                               queue: .main) { _ in
            scrollView.contentInset.bottom = 0
        }
    }

    func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    func showAlert(title: String = "Alert", message: String, buttonTitle: String = "OK", completion: (() -> Void)? = nil) {
           let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
           
           let okAction = UIAlertAction(title: buttonTitle, style: .default) { _ in
               completion?()
           }
           
           alert.addAction(okAction)
           present(alert, animated: true)
       }
}

