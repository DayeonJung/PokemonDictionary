//
//  Response.swift
//  PokemonDictionary
//
//  Created by Dayeon Jung on 2021/08/05.
//

import Foundation

// MARK: - PokemonNames
struct PokemonNames: Codable {
    let pokemons: [PokemonName]
}

// MARK: - PokemonName
struct PokemonName: Codable {
    let id: Int
    let names: [String]
}
