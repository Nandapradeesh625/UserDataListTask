//
//  NetworkHandler.swift
//  UserDataTask
//
//  Created by Nanda Pradeesh on 23/07/25.
//

import Foundation
import Combine

class NetworkHandler {
    static let shared = NetworkHandler()
    private init() {}
    
    func request<T: Decodable>(_ endpoint: Endpoint, decodeTo type: T.Type) -> AnyPublisher<T, APIError> {
        guard let request = endpoint.urlRequest else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { result -> Data in
                guard let httpResponse = result.response as? HTTPURLResponse else {
                    throw APIError.noData
                }
                if !(200...299).contains(httpResponse.statusCode) {
                    throw APIError.serverError(httpResponse.statusCode)
                }
                return result.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                (error as? APIError) ?? APIError.unknown(error)
            }
            .eraseToAnyPublisher()
    }
}
