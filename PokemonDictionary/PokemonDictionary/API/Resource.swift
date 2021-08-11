//
//  Resource.swift
//  PokemonDictionary
//
//  Created by Dayeon Jung on 2021/08/05.
//

import Foundation


struct Resource<T> {
    var urlRequest: URLRequest?
    let parse: (Data) -> T?
}

extension Resource where T: Decodable {

    init(url: URLString, parameters: [String: String]? = nil) {
        
        var component = URLComponents(string: url.value)
        if let param = parameters, !param.isEmpty {
            var items = [URLQueryItem]()
            for (name, value) in param {
                if name.isEmpty { continue }
                items.append(URLQueryItem(name: name, value: value))
            }
            component?.queryItems = items
        }
        
        if let componentURL = component?.url {
            self.urlRequest = URLRequest(url: componentURL)
        }
        
        self.parse = { data in
            try? JSONDecoder().decode(T.self, from: data)
        }
    }
    
    
}
