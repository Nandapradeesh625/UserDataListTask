//
//  UserViewModel.swift
//  UserDataTask
//
//  Created by Nanda Pradeesh on 23/07/25.
//

import Foundation
import Combine

// MARK: - UserViewModel

class UserViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var users: [User] = []
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false

    // MARK: - Private Properties
    private var cancellables = Set<AnyCancellable>()

    func getUsers() {
        isLoading = true
        APIService.shared.fetchUsers()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] users in
                self?.users = users
            }
            .store(in: &cancellables)
    }

    func createUser(request: CreateUserRequest, completion: @escaping (Result<User, Error>) -> Void) {
        APIService.shared.createUser(request: request)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completionSink in
                if case .failure(let error) = completionSink {
                    self?.errorMessage = error.localizedDescription
                    completion(.failure(error))
                }
            } receiveValue: { [weak self] user in
                self?.users.insert(user, at: 0)
                completion(.success(user))
            }
            .store(in: &cancellables)
    }
}
