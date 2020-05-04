//
//  Endpoint.swift
//  MasterDetails
//
//  Created by Shashi Kant on 5/3/20.
//  Copyright © 2020 Shashi Kant. All rights reserved.
//

import Foundation

protocol Endpoint {
    
    var base: String { get }
    var path: String { get }
}

extension Endpoint {
    
    var apiKey: String {
        return "abspath=1"
    }
    
    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        components.query = apiKey
        return components
    }
    
    var request: URLRequest {
        let url = urlComponents.url!
        return URLRequest(url: url)
    }
}

enum UID {
    
    case uidType
}

extension UID: Endpoint {
    
    var base: String {
        return "https://api.fyu.se/"
    }
    
    var path: String {
        switch self {
        case .uidType: return "/1.4/group/web/jlp75qdubezgc"
       
        }
    }
}
