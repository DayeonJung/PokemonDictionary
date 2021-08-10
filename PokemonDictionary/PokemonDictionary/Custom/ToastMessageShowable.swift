//
//  ShowToast.swift
//  PokemonDictionary
//
//  Created by Dayeon Jung on 2021/08/10.
//

import UIKit

protocol ToastMessageShowable {
    func showToast(message: String?)
}

extension ToastMessageShowable {
    func showToast(message: String?) {
        
        let toastLabel = InsetLabel()
        toastLabel.font = UIFont.systemFont(ofSize: 14)
        toastLabel.text = message
        toastLabel.textColor = .white
        
        toastLabel.backgroundColor = .gray
        toastLabel.layer.cornerRadius = 16
        toastLabel.clipsToBounds = true
        

        if let window = UIApplication.shared.windows.first {
            window.addSubview(toastLabel)
            toastLabel.translatesAutoresizingMaskIntoConstraints = false
            toastLabel.centerXAnchor.constraint(equalTo: window.centerXAnchor).isActive = true
            toastLabel.bottomAnchor.constraint(equalTo: window.bottomAnchor,
                                               constant: -20).isActive = true
            
            
            toastLabel.alpha = 0
            UIView.animate(withDuration: 0.2) {
                toastLabel.alpha = 1
            } completion: { _ in
                UIView.animate(withDuration: 0.2, delay: 1.0) {
                    toastLabel.alpha = 0
                } completion: { _ in
                    toastLabel.removeFromSuperview()
                }

            }

        }
    }
}
