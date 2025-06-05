//
//  AppetizerListViewModelTests.swift
//  MVVM-C-Sample-Tests
//
//  Created by Umair on 01/06/2025.
//

import XCTest
@testable import MVVM_C_Sample

final class AppetizerListViewModelTests: XCTestCase {
    
    var sut : AppetizerListViewModelProtocol!
    var mockService : AppetizerListServiceProtocol!
    
    override func setUp(){
        mockService = MockAppetizerListService()
        sut = AppetizerListViewModel(service: mockService)
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func test_WhenAPICalled() async throws{
        MockAppetizerListService.error = nil
        try await sut.getAppetizerList()
        XCTAssertNotNil(sut?.appetizers)
    }
    
    func test_when_Error_received() async throws{
        MockAppetizerListService.error = AppErrors.badUrl
        do{
            try await sut.getAppetizerList()
        }catch{
            guard let error = error as? AppErrors else{
                return
            }
            XCTAssertEqual(error, AppErrors.badUrl)
            XCTAssertEqual(sut.appetizers.count, 0)
        }
    }
}
