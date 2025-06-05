//
//  ImageDownloader.swift
//  MVVM-C-Sample
//
//  Created by Umair on 13/05/2025.
//

import UIKit
//import Foundation

class ImageDownloader{
    var cache : NSCache<NSString, UIImage> = NSCache<NSString, UIImage>()
    static let shared = ImageDownloader()
    private init(){}
    
    func downloadImage(urlString: String, completion: @escaping(UIImage?) -> Void){
        
        let key = NSString(string: urlString)
        if let image = cache.object(forKey: key){
            completion(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            return completion(nil)
        }
        
        URLSession.shared.dataTask(with: url) {[weak self] data, response, error in
            if let _ = error{
                completion(nil)
                return
            }
            
            guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                return completion(nil)
            }
            
            guard let data else {
                return completion(nil)
            }
            
            guard let image = UIImage(data: data) else{
                completion(nil)
                return
            }
            
            self?.cache.setObject(image, forKey: key)
            completion(image)
        }.resume()
    }
}
