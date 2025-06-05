//
//  AppetizerListServiceTests.swift
//  MVVM-C-Sample-Tests
//
//  Created by Umair on 31/05/2025.
//

import XCTest
@testable import MVVM_C_Sample

final class AppetizerListServiceTests: XCTestCase {

    private var sut : AppetizerListServiceProtocol?
    
    override func setUp() {
        sut = MockAppetizerListService()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testWhenApiReturnsSuccessResponse() async{
        do{
            let response = try await sut?.getAppetizerList()
            XCTAssertGreaterThan(response?.request.count ?? 0, 0)
        }catch{
            print(error.localizedDescription)
        }
    }
    
    
}
