//
//  HTTPClient.swift
//  MasterDetails
//
//  Created by Shashi Kant on 5/3/20.
//  Copyright © 2020 Shashi Kant. All rights reserved.
//

import Foundation
import UIKit

class HTTPClient: APIClient {
    
    let imageCache = NSCache<NSString, UIImage>()
    let session: URLSession
    enum NetworkError: Error {
        case badURL
        case failedToLoad
    }
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    //in the signature of the function in the success case we define the Class type thats is the generic one in the API
    func getResult(from uidType: UID, completion: @escaping (Result<UIDList?, APIError>) -> Void) {
        
        let endpoint = uidType
        let request = endpoint.request
        
        fetch(with: request, decode: { json -> UIDList? in
            guard let uidList = json as? UIDList else { return  nil }
            return uidList
        }, completion: completion)
    }
    
    // Loads an image from the specified URL on a background thread
    func loadImage(from url: URL, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
                   completion(.success(cachedImage))
        } else {
        
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                guard let image = UIImage(data: data) else {
                    completion(.failure(.failedToLoad))
                    return
                }
                DispatchQueue.main.async {
                    self.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                    completion(.success(image))
                }
            } catch {
                completion(.failure(.failedToLoad))
            }
        }
     }
    }

    
}



