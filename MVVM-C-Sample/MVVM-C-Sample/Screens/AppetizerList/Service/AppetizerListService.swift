//
//  AppetizerListService.swift
//  MVVM-C-Sample
//
//  Created by Umair on 12/05/2025.
//
import Foundation

protocol AppetizerListServiceProtocol{
    func getAppetizerList() async throws -> AppetizerListResponseModel
}

class AppetizerListService: AppetizerListServiceProtocol{
    
    let networkManager : NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    enum endpoints : String{
        case appetizers = "appetizers"
    }
        

    func getAppetizerList() async throws -> AppetizerListResponseModel {
        let model : AppetizerListResponseModel = try await networkManager.executeRequest(endPoint: endpoints.appetizers.rawValue, params: nil, method: .get)
        return model
    }
    
}
