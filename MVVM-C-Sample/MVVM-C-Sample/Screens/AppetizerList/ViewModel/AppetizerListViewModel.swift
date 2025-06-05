//
//  AppetizerListViewModel.swift
//  MVVM-C-Sample
//
//  Created by Umair on 12/05/2025.
//

import Foundation

protocol AppetizerListViewModelProtocol{
    var appetizers : [Appetizer] {get}
    func getAppetizerList() async throws
}

final class AppetizerListViewModel: AppetizerListViewModelProtocol{
    
    var service : AppetizerListServiceProtocol
    private(set) var appetizers : [Appetizer] = []
    
    init(service: AppetizerListServiceProtocol) {
        self.service = service
    }
    
    
    func getAppetizerList() async throws {
        let response = try await service.getAppetizerList()
        self.appetizers = response.request
    }
    
}
