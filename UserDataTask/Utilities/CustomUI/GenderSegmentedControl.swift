//
//  GenderSegmentedControl.swift
//  UserDataTask
//
//  Created by Nanda Pradeesh on 23/07/25.
//

import Foundation
import UIKit

class GenderSegmentedControl: UISegmentedControl {

    private let options = ["Male", "Female"]

    var selectedGender: String {
        return selectedSegmentIndex == 0 ? "male" : "female"
    }

    init() {
        super.init(items: options)
        self.selectedSegmentIndex = 0
        self.backgroundColor = .white
        self.selectedSegmentTintColor = AppTheme.primaryColor
        self.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        self.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
