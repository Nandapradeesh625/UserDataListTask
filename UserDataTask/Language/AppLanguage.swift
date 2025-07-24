//
//  AppLanguage.swift
//  UserDataTask
//
//  Created by Nanda Pradeesh on 23/07/25.
//

import Foundation
import UIKit

enum AppLanguageType: String {
    case english = "en"
}

class AppLanguage: NSObject {
    static let shared = AppLanguage()
    
    private func languageBundle(for language: String) -> Bundle? {
        guard let path = Bundle.main.path(forResource: language, ofType: "lproj") else {
            return nil
        }
        return Bundle(path: path)
    }
    
    func localizedString(for key: String, value: String, table: String? = nil) -> String {
        let currentLanguage = UserDefaults.standard.string(forKey: "AppleLanguages") ?? AppLanguageType.english.rawValue
        let bundle = languageBundle(for: currentLanguage) ?? Bundle.main
        return bundle.localizedString(forKey: key, value: value, table: table)
    }
    
    func currentLanguage() -> AppLanguageType {
        let currentLanguage = UserDefaults.standard.string(forKey: "AppleLanguages") ?? AppLanguageType.english.rawValue
        return AppLanguageType(rawValue: currentLanguage) ?? .english
    }
    
    func changeLanguage(to language: AppLanguageType) {
        UserDefaults.standard.setValue([language.rawValue], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
    }
}

