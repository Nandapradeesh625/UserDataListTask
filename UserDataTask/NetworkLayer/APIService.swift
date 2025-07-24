//
//  APIService.swift
//  UserDataTask
//
//  Created by Nanda Pradeesh on 23/07/25.
//

import Foundation
import Combine

// MARK: - GoRESTEndpoint

enum GoRESTEndpoint: Endpoint {
    
    // MARK: Cases
    case listUsers
    case createUser(request: CreateUserRequest)
    
    // MARK: Base URL
    var baseURL: String {
        return "https://gorest.co.in/public/v2"
    }
    
    // MARK: Path
    var path: String {
        switch self {
        case .listUsers, .createUser:
            return "/users"
        }
    }
    
    // MARK: HTTP Method
    var method: HTTPMethod {
        switch self {
        case .listUsers: return .get
        case .createUser: return .post
        }
    }
    
    // MARK: Headers
    var headers: [String: String]? {
        return [
            "Authorization": "Bearer 14af520f59f34ada404f6d86571160255401e4f56a8e7d91523e7e3e5dc9cc8f",
            "Content-Type": "application/json"
        ]
    }
    
    // MARK: Body
    var body: [String: Any]? {
        switch self {
        case .createUser(let request):
            return [
                "name": request.name,
                "email": request.email,
                "gender": request.gender,
                "status": request.status
            ]
        case .listUsers:
            return nil
        }
    }
}

// MARK: - APIService

class APIService {
    
    // MARK: Singleton
    static let shared = APIService()
    
    // MARK: Fetch Users
    func fetchUsers() -> AnyPublisher<[User], APIError> {
        return NetworkHandler.shared.request(GoRESTEndpoint.listUsers, decodeTo: [User].self)
    }
    
    // MARK: Create User
    func createUser(request: CreateUserRequest) -> AnyPublisher<User, APIError> {
        return NetworkHandler.shared.request(GoRESTEndpoint.createUser(request: request), decodeTo: User.self)
    }
}
