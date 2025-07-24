//
//  Constants.swift
//  UserDataTask
//
//  Created by Nanda Pradeesh on 23/07/25.
//

import Foundation
import UIKit

enum Constants {
    static let appName = "User Data Task"
    
    enum PageTitle {
        static let userDataList = "User Data List"
        static let addUserData = "Add User Data"
    }
    
    enum TextFieldPlaceholder {
        static let namePlaceholder = "Enter Name"
        static let emailPlaceholder = "Enter Email"
    }
    
    enum Gender {
        static let male = "male"
        static let female = "female"
    }
    
    enum ButtonTitle {
        static let submitButtonTitle = "Submit"
        static let cancelButtonTitle = "Cancel"
        static let alertButtonOKTitle = "OK"
        static let cancel = "Cancel"
        static let back = "Back"
    }
  
    enum AlertMessage {
        // Titles
        static let userData = "User Data"
        static let addUserData = "Add User Data"
        static let userDetails = "User Details"
        
        // Error Messages
        static let alertMessageError = "Error!"
        static let alertMessageEmptyFields = "Please fill all the fields"
        static let alertMessageName = "Please enter your name"
        static let alertMessageInvalidEmail = "Please enter a valid email"
        static let alertMessageEmailEmpty = "Please enter your email"
        static let alertMessageNoDataFound = "No Data Found."
        static let alertMessageSaveFailed = "Save Failed"
        static let alertMessageSaveSuccess = "Saved Successful"
        static let alertMessageNewUser = "New User Added"
        static let serverError = "Internal server error, please try again after sometime."
        static let invalidURL = "The URL is not valid"
        
        // Other Messages
        static let english = "English"
    }
}
