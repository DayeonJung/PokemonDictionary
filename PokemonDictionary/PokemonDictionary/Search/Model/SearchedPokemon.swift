//
//  SearchedPokemon.swift
//  PokemonDictionary
//
//  Created by Dayeon Jung on 2021/08/06.
//

import Foundation

struct SearchedPokemon {
    
    let name: PokemonName
    let languageIndex: Int
    
    func displayText() -> String {
        self.name.names[self.languageIndex]
    }
    
}
