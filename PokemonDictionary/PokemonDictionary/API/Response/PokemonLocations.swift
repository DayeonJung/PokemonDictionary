//
//  PokemonLocations.swift
//  PokemonDictionary
//
//  Created by Dayeon Jung on 2021/08/05.
//

import Foundation

// MARK: - PokemonLocations
struct PokemonLocations: Codable {
    let pokemons: [PokemonLocation]
}

// MARK: - PokemonLocation
struct PokemonLocation: Codable {
    let lat, lng: Double
    let id: Int
}
