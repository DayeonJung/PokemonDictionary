//
//  APIManager.swift
//  PokemonDictionary
//
//  Created by Dayeon Jung on 2021/08/05.
//

import Foundation

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


class API {
    enum APIError: LocalizedError {
        case urlNotSupport
        case noData(String?)
        case unknown(String?)
        
        var errorDescription: String? {
            switch self {
            case .urlNotSupport: return "URL not supported"
            case .noData(let message): return "has no data" + (message ?? "")
            case .unknown(let message): return "unknown error occured. " + (message ?? "")
            }
        }
    }
    
    static let shared: API = API()
    
    private lazy var session = URLSession(configuration: .default)
    
    private init() { }

    func get<T>(resource: Resource<T>,
                      completionHandler: @escaping (Result<T, APIError>) -> Void) {
        
        guard let _ = resource.urlRequest?.url else {
            completionHandler(.failure(.urlNotSupport))
            return
        }
        
        self.session.load(resource) { parsed, error in
            guard let parsed = parsed else { completionHandler(.failure(.noData(error)))
                return
            }
            
            completionHandler(.success(parsed))
        }
    }

    func getData(from url: URL, completionHandler: @escaping (Result<Data?, APIError>) -> ()) {
        session.loadData(from: url) { data, error in
            if let error = error {
                completionHandler(.failure(.unknown(error.description)))
                return
            }
            
            completionHandler(.success(data))
        }
    }

}

