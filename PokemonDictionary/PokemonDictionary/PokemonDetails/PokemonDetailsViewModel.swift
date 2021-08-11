//
//  PokemonDetailsViewModel.swift
//  PokemonDictionary
//
//  Created by Dayeon Jung on 2021/08/07.
//

import Foundation

class PokemonDetailsViewModel {
    
    private let id: Int
    private let names: [String]
    private let locations: [(Double, Double)]   // 0: lat, 1: lng
    
    private var imageStr: String?
    private var height: Int?
    private var weight: Int?
    
    var updateStackView: (() -> Void)?
    
    init(_ id: Int,
         _ names: [String],
         _ locations: [(Double, Double)]) {
        self.id = id
        self.names = names
        self.locations = locations
        
        self.getDetails()
    }
    
    private func getDetails() {
        
        API.shared.get(resource: Resource<PokemonDetails>(url: .pokemonDetail(self.id))) { result in
            
            switch result {
            case .success(let datas):
                self.height = datas.height
                self.weight = datas.weight
                self.imageStr = self.pickProperImageStr(response: datas)

            case .failure(_):
                self.imageStr = nil

            }
            
            self.updateStackView?()
            
        }
    }
    
    private func pickProperImageStr(response: PokemonDetails?) -> String? {
        guard let response = response else { return nil }
        let sprites = response.sprites
        
        if let frontDefault = sprites.frontDefault {
            return frontDefault
        }
        
        return [sprites.frontFemale,
                sprites.frontShiny,
                sprites.frontShinyFemale,
                sprites.backDefault,
                sprites.backFemale,
                sprites.backShiny,
                sprites.backShinyFemale].shuffled().compactMap({$0}).first
    }
}

extension PokemonDetailsViewModel {
    func namesOfPokemon() -> String {
        return self.names.joined(separator: " / ")
    }
    
    func heightOfPokemon() -> String {
        guard let height = self.height else {
            return "-"
        }
        return String(height)
    }
    
    func weightOfPokemon() -> String {
        guard let weight = self.weight else {
            return "-"
        }
        return String(weight)
    }
    
    func imageString() -> String? {
        return self.imageStr
    }
    
    func hasHabitat() -> Bool {
        return !self.locations.isEmpty
    }
    
    func locationInfos() -> [(Double, Double)] {
        return self.locations
    }
}
