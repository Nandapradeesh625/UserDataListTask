//
//  CustomStackView.swift
//  UserDataTask
//
//  Created by Nanda Pradeesh on 23/07/25.
//

import Foundation
import UIKit

@IBDesignable class CustomStackView: UIStackView {
    
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

}
