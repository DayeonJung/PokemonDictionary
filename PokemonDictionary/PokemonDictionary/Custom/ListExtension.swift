//
//  ListExtension.swift
//  PokemonDictionary
//
//  Created by Dayeon Jung on 2021/08/06.
//

import Foundation
import UIKit


extension UICollectionView {
    
    func loadCell<T>(identifier:T.Type, indexPath:IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: String(describing: identifier), for: indexPath) as! T
    }
        
    func setCell(cellName:UICollectionViewCell.Type) {
        self.register(UINib(nibName: String(describing: cellName), bundle: nil), forCellWithReuseIdentifier: String(describing: cellName))
    }
    
}
