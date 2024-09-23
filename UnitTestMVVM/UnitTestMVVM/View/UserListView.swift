//
//  UserListView.swift
//  UnitTestMVVM
//
//  Created by Anand Yadav on 21/09/24.
//

import SwiftUI

struct UserListView: View {
    @ObservedObject var viewModel: UserViewModel

    var body: some View {
            VStack {
                if viewModel.isLoading {
                    ProgressView()  // Loading indicator
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(2) // Larger loading indicator
                        .padding()
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                } else {
                    List(viewModel.users, id: \.id) { user in
                        Text(user.login)
                    }
                }
            }
            .onAppear {
                viewModel.loadUsers()
            }
        }
    }

struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView(viewModel: UserViewModel(service: MockUserService()))
    }
}
