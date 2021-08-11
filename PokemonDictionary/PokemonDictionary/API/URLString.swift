//
//  URLString.swift
//  PokemonDictionary
//
//  Created by Dayeon Jung on 2021/08/05.
//

import Foundation

enum URLString {
    case names
    case locations
    case pokemonDetail(Int)
    
    var value: String {
        switch self {
        case .names: return "https://demo0928971.mockable.io/pokemon_name"
        case .locations: return "https://demo0928971.mockable.io/pokemon_locations"
        case .pokemonDetail(let id): return "https://pokeapi.co/api/v2/pokemon/\(id)"
        
        }
        
    }
}


