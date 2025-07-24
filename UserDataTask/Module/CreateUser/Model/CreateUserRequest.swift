//
//  CreateUserRequest.swift
//  UserDataTask
//
//  Created by Nanda Pradeesh on 23/07/25.
//

import Foundation
struct CreateUserRequest: Codable {
    let name: String
    let email: String
    let gender: String
    let status: String
}
