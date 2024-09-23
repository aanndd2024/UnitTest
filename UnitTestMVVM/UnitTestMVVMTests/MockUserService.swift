//
//  MockUserService.swift
//  UnitTestMVVM
//
//  Created by Anand Yadav on 23/09/24.
//

import Foundation

//class MockUserService: UserServiceProtocol {
//    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void) {
//        // Mock user data
//        let mockUsers = [User(id: 1, login: "MockUser")]
//        completion(.success(mockUsers))
//    }
//}


class MockUserService: UserServiceProtocol {
    var shouldReturnError = false

    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        if shouldReturnError {
            let error = NSError(domain: "TestError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Mock Error"])
            completion(.failure(error))
        } else {
            let mockUsers = [User(id: 1, login: "TestUser1"), User(id: 2, login: "TestUser2")]
            completion(.success(mockUsers))
        }
    }
}
