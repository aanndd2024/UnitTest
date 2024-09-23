//
//  UserService.swift
//  UnitTestMVVM
//
//  Created by Anand Yadav on 21/09/24.
//

import Foundation

protocol UserServiceProtocol {
    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void)
}

class RealUserService: UserServiceProtocol {
    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        // Example URL, you can replace this with any API endpoint
        guard let url = URL(string: "https://api.github.com/users") else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
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
                let error = NSError(domain: "No Data", code: -1, userInfo: nil)
                completion(.failure(error))
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
