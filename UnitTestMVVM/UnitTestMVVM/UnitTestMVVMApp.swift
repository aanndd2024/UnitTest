//
//  UnitTestMVVMApp.swift
//  UnitTestMVVM
//
//  Created by Anand Yadav on 21/09/24.
//

import SwiftUI

@main
struct UnitTestMVVMApp: App {
    var body: some Scene {
        WindowGroup {
            UserListView(viewModel: UserViewModel(service: RealUserService()))

        }
    }
}
