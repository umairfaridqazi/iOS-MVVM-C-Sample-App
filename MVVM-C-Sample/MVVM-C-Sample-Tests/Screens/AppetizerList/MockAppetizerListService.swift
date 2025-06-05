//
//  MockAppetizerListService.swift
//  MVVM-C-Sample
//
//  Created by Umair on 31/05/2025.
//

@testable import MVVM_C_Sample

final class MockAppetizerListService: AppetizerListServiceProtocol, Mockable{
    static var error : AppErrors?
    
    func getAppetizerList() async throws -> AppetizerListResponseModel {
        if let err = Self.error{
            throw err
        }else{
            
        }
        let model = loadJson(fileName: "AppetizerResponse", type: AppetizerListResponseModel.self)
        return model
    }
}
