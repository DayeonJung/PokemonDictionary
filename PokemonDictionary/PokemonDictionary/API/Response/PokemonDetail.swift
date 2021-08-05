//
//  PokemonDetail.swift
//  PokemonDictionary
//
//  Created by Dayeon Jung on 2021/08/05.
//

import Foundation

// MARK: - PokemonDetails
struct PokemonDetails: Codable {
    let id: Int
    let height: Int
    let weight: Int
    let sprites: Sprites
}

// MARK: - Sprites
class Sprites: Codable {
    let backDefault: String
    let backFemale: String?
    let backShiny: String
    let backShinyFemale: String?
    let frontDefault: String
    let frontFemale: String?
    let frontShiny: String
    let frontShinyFemale: String?
//    let other: Other?
//    let versions: Versions?

    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backFemale = "back_female"
        case backShiny = "back_shiny"
        case backShinyFemale = "back_shiny_female"
        case frontDefault = "front_default"
        case frontFemale = "front_female"
        case frontShiny = "front_shiny"
        case frontShinyFemale = "front_shiny_female"
//        case other, versions
    }
}
