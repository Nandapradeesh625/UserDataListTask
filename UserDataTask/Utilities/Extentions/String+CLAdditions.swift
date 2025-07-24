//
//  String+CLAdditions.swift
//  UserDataTask
//
//  Created by Nanda Pradeesh on 23/07/25.
//

import Foundation

public extension String {

    // Function to validate empty string
    func empty() -> Bool {
        var isEmpty = true;
        let temporaryString: String = self .trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if (temporaryString.count > 0) {
            isEmpty = false;
        }
        return isEmpty;
    }
    // Function to validate empty or whitespace string
    func isEmptyOrWhitespace() -> Bool {
            if(self.isEmpty) {
                return true
            }
            return (self.trimmingCharacters(in: NSCharacterSet.whitespaces) == "")
    }

    // Function to validate email format
    func isValidEmail() -> Bool {
        // Regular expression to match email format
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        let isValid = emailPredicate.evaluate(with: self)
        return isValid;
    }
    
    // Function to validate name format
    func validName(_ name: String) -> Bool {
        // Regular expression to match name format
        let emailReges: String = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
        let characterSet: CharacterSet = NSCharacterSet(charactersIn: emailReges).inverted as CharacterSet
        let filtered = self.components(separatedBy: characterSet ).joined(separator: "")
        return self == filtered
    }
}
