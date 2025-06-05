//
//  NetworkManager.swift
//  MVVM-C-Sample
//
//  Created by Umair on 12/05/2025.
//

import Foundation

enum HttpMethod : String{
    case get = "GET"
    case post = "POST"
}

protocol NetworkManagerProtocol{
    func executeRequest<T:Codable>(endPoint: String, params: Encodable?, method: HttpMethod) async throws -> T
}


final class NetworkManager: NetworkManagerProtocol{
    
    let manager : URLSession
    
    init(manager: URLSession = .shared) {
        self.manager = manager
    }
    
    func executeRequest<T:Codable>(endPoint: String, params: Encodable?, method: HttpMethod = .get) async throws -> T{
        
        guard let url = URL(string: Constants.baseUrl + endPoint) else {
            throw AppErrors.badUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let body = params{
            do{
                request.httpBody = try JSONEncoder().encode(body)
            }catch{
                throw AppErrors.invalidParams
            }
        }
        
        let (data, response) = try await manager.data(for: request)
        
        guard let resp = response as? HTTPURLResponse, 200...299 ~= resp.statusCode else {
            throw AppErrors.invalidResponse
        }
        
        do {
            let model = try JSONDecoder().decode(T.self, from: data)
            return model
        }catch{
            fatalError(error.localizedDescription)
        }
    }
}
