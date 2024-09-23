//
//  UserService.swift
//  UnitTestMVVM
//
//  Created by Anand Yadav on 21/09/24.
//

import Foundation
enum UserServiceError: Error {
    case invalidURL, invalidData, invalidUser
}

protocol UserServiceProtocol {
    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void)
}

class RealUserService: UserServiceProtocol {
    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        guard let url = URL(string: "https://api.github.com/users") else {
            completion(.failure(UserServiceError.invalidURL))
            return
        }

        // Make the network request
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                // If there is an error, return it
                completion(.failure(error))
                return
            }

            guard let data = data else {
                // If no data is received, return an error
                completion(.failure(UserServiceError.invalidData))
                return
            }

            do {
                // Decode the JSON data into an array of User objects
                let users = try JSONDecoder().decode([User].self, from: data)
                completion(.success(users))  // Success case
            } catch {
                // If decoding fails, return the decoding error
                completion(.failure(error))
            }
        }.resume()
    }
}
