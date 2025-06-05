//
//  Mockable.swift
//  MVVM-C-Sample
//
//  Created by Umair on 31/05/2025.
//

import Foundation

protocol Mockable: AnyObject{
    var bundle : Bundle {get}
    func loadJson<T:Codable>(fileName: String, type: T.Type) -> T
}

extension Mockable{
    
    var bundle : Bundle {
        return Bundle(for: type(of: self))
    }
    
    func loadJson<T:Codable>(fileName: String, type: T.Type) -> T{
        guard let path = bundle.url(forResource: fileName, withExtension: "json") else {
            fatalError("File path can not be found")
        }
        
        do{
            let data = try Data(contentsOf: path)
            let decodedObject = try JSONDecoder().decode(T.self, from: data)
            return decodedObject
        }catch{
            fatalError("Failed to decode json")
        }
    }
}
