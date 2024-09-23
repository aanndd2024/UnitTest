//
//  UserDetailView.swift
//  UnitTestMVVM
//
//  Created by Anand Yadav on 21/09/24.
//
import SwiftUI

struct UserDetailView: View {
    let user: User
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Username: \(user.login)")
            Spacer()
        }
        .padding()
        .navigationTitle(user.login)
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView(user: User(id: 1, login: "MyLogin"))
    }
}
