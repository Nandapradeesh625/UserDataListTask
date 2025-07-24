//
//  CustomTextField.swift
//  Dicetekassessment
//
//  Created by Nanda Pradeesh on 23/07/25.
//

import Foundation
import UIKit

@IBDesignable class CustomTextField: UITextField {
    
    @IBInspectable var customCornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = customCornerRadius
            layer.masksToBounds = true
        }
    }
    
    @IBInspectable var customBorderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = customBorderColor.cgColor
            layer.masksToBounds = true
        }
    }
    
    @IBInspectable var customBorderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = customBorderWidth
        }
    }
    
    //MARK:- View Life Cycle
    override func draw(_ rect: CGRect) {
        
    }
    override func awakeFromNib() {
        
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateColors()
    }
    
    private func updateColors() {
        let isDark = traitCollection.userInterfaceStyle == .dark
        textColor = isDark ? .white : .black
        let placeholderColor = isDark ? UIColor.lightGray : UIColor.darkGray
        if let placeholder = placeholder {
            attributedPlaceholder = NSAttributedString(
                string: placeholder,
                attributes: [.foregroundColor: placeholderColor]
            )
        }
    }
}
