//
//  UserViewModel.swift
//  UnitTestMVVM
//
//  Created by Anand Yadav on 21/09/24.
//

import Combine
import Foundation

class UserViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false  // Tracks the loading state

    private let service: UserServiceProtocol
    
    init(service: UserServiceProtocol) {
        self.service = service
    }
    
//    func loadUsers() {
//        isLoading = true  // Start loading
//        service.fetchUsers { [weak self] result in
//            DispatchQueue.main.async {
//                self?.isLoading = false  // Stop loading
//                switch result {
//                case .success(let fetchedUsers):
//                    self?.users = fetchedUsers
//                case .failure(let error):
//                    self?.errorMessage = error.localizedDescription
//                }
//            }
//        }
//    }
    
    func loadUsers(completion: @escaping () -> Void = {}) {
        isLoading = true
        service.fetchUsers { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let fetchedUsers):
                    self?.users = fetchedUsers
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
                completion()  // Call the completion handler when done
            }
        }
    }
}
