//
//  APIManager.swift
//  PokemonDictionary
//
//  Created by Dayeon Jung on 2021/08/05.
//

import UIKit

extension URLSession {
    func load<T>(_ resource: Resource<T>, completion: @escaping (T?, String?) -> Void) {
        dataTask(with: resource.urlRequest!) { data, response, error in
            if let response = response as? HTTPURLResponse,
                (200..<300).contains(response.statusCode) {
                completion(data.flatMap(resource.parse), nil)
            } else {
                completion(nil, error?.localizedDescription)
            }
        }.resume()
    }
    
    func loadData(from url: URL, completion: @escaping (Data?, String?) -> ()) {
        dataTask(with: url) { data, response, error in
            if let response = response as? HTTPURLResponse,
                (200..<300).contains(response.statusCode) {
                completion(data, nil)
            } else {
                completion(nil, error?.localizedDescription)
            }
        }.resume()
    }
}


class API: ErrorControllable {
    
    static let shared: API = API()
    
    private lazy var session = URLSession(configuration: .default)
    
    private init() { }

    func get<T>(resource: Resource<T>,
                      completionHandler: @escaping (Result<T, APIError>) -> Void) {
        
        guard let _ = resource.urlRequest?.url else {
            let errorType: APIError = .urlNotSupport
            self.showToastMessage(with: errorType)
            completionHandler(.failure(errorType))
            return
        }
        
        self.session.load(resource) { parsed, error in
            guard let parsed = parsed else {
                let errorType: APIError = .noData(error)
                self.showToastMessage(with: errorType)
                completionHandler(.failure(errorType))
                return
            }
            
            completionHandler(.success(parsed))
        }
    }

    func getData(from url: URL, completionHandler: @escaping (Result<Data?, APIError>) -> ()) {
        session.loadData(from: url) { data, error in
            if let error = error {
                let errorType: APIError = .unknown(error.description)
                self.showToastMessage(with: errorType)
                completionHandler(.failure(errorType))
                return
            }
            
            completionHandler(.success(data))
        }
    }

}

