//
//  AppErrors.swift
//  MVVM-C-Sample
//
//  Created by Umair on 12/05/2025.
//

import Foundation
enum AppErrors: Error{
    case badUrl
    case invalidParams
    case badData
    case invalidResponse
    case unknown
    case unableToParse
}

extension AppErrors{
    var description : String{
        switch self{
            
        case .badUrl:
            return NSLocalizedString("badUrl", comment: "badUrl")
        case .invalidParams:
            return NSLocalizedString("invalidParams", comment: "invalidParams")
        case .badData:
            return NSLocalizedString("badData", comment: "badData")
        case .invalidResponse:
            return NSLocalizedString("invalidResponse", comment: "invalidResponse")
        case .unknown:
            return NSLocalizedString("unknow", comment: "unknow")
        case .unableToParse:
            return NSLocalizedString("unableToParse", comment: "unableToParse")
        }
    }
}
