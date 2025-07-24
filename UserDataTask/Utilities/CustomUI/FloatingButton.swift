//
//  FloatingButton.swift
//  UserDataTask
//
//  Created by Nanda Pradeesh on 23/07/25.
//

import UIKit

final class FloatingButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = AppTheme.primaryColor
        tintColor = AppTheme.buttonTextColor
        setImage(UIImage(systemName: "person.badge.plus"), for: .normal)
        layer.cornerRadius = 28
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowRadius = 4

        // Accessibility
        accessibilityLabel = "Create User"
        accessibilityTraits = .button
    }
}
