//
//  UnitTestMVVMTests.swift
//  UnitTestMVVMTests
//
//  Created by Anand Yadav on 21/09/24.
//

import XCTest
@testable import UnitTestMVVM

class UserViewModelTests: XCTestCase {
    
    var viewModel: UserViewModel!
    var mockService: MockUserService!
    
    override func setUp() {
        super.setUp()
        mockService = MockUserService()
        viewModel = UserViewModel(service: mockService)
    }

    override func tearDown() {
        mockService = nil
        viewModel = nil
        super.tearDown()
    }

    // Test loading state
    func testLoadUsers_LoadingState() {
        // Given
        XCTAssertFalse(viewModel.isLoading)  // Initially not loading

        // When
        viewModel.loadUsers()

        // Then
        XCTAssertTrue(viewModel.isLoading)  // Should be loading when the request is made
    }
    
    // Test successful user fetch
    func testLoadUsers_Success() {
        // Given
        mockService.shouldReturnError = false
        let expectation = XCTestExpectation(description: "Users loaded successfully")
        
        // When
        viewModel.loadUsers()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertFalse(self.viewModel.isLoading)  // Check that loading is stopped
            XCTAssertEqual(self.viewModel.users.count, 2)  // Check that users are populated
            XCTAssertEqual(self.viewModel.users.first?.login, "TestUser1")  // Check the first user details
            XCTAssertNil(self.viewModel.errorMessage)  // No error should be present
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    // Test error scenario
    func testLoadUsers_Failure() {
        // Given
        mockService.shouldReturnError = true
        let expectation = XCTestExpectation(description: "Error handled properly")
        
        // When
        viewModel.loadUsers()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertFalse(self.viewModel.isLoading)  // Check that loading is stopped
            XCTAssertTrue(self.viewModel.users.isEmpty)  // No users should be populated
            XCTAssertEqual(self.viewModel.errorMessage, "Mock Error")  // Error message should be set
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}
