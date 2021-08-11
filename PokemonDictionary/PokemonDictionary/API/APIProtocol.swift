//
//  APIProtocol.swift
//  PokemonDictionary
//
//  Created by Dayeon Jung on 2021/08/10.
//

import Foundation

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


protocol ErrorControllable: ToastMessageShowable {
    func showToastMessage(with type: APIError)
}
 
extension ErrorControllable {
    
    func showToastMessage(with type: APIError) {
        let errorMessage = "Error" + type.localizedDescription
        print(errorMessage)
        DispatchQueue.main.async {
            self.showToast(message: errorMessage)
        }
    }
}
