//
//  PokemonDetailsViewModel.swift
//  PokemonDictionary
//
//  Created by Dayeon Jung on 2021/08/07.
//

import Foundation

struct PokemonDetailsViewModel {
    
    let id: Int
    let names: [String]
    let locations: [(Double, Double)]   // 0: lat, 1: lng
    
}
