//
//  SearchViewModel.swift
//  PokemonDictionary
//
//  Created by Dayeon Jung on 2021/08/06.
//

import Foundation

class SearchViewModel {
    
    private var pokemonNames: [PokemonName]?
    private var searchedPokemons: [SearchedPokemon] = [] {
        didSet {
            self.updateList?()
        }
    }
        
    var updateList: (() -> Void)?
    
    init() {
        self.getPokemonNames()
    }
    
    private func getPokemonNames() {
        
        API.shared.get(resource: Resource<PokemonNames>(url: .names)) { result in
            switch result {
            case .success(let datas):
                self.pokemonNames = datas.pokemons
                
            case .failure(let error):
                self.pokemonNames = nil
                print("Error", error.localizedDescription)

            }
        }
    }
    
    
    

}

extension SearchViewModel {
    func numberOfSearched() -> Int {
        return self.searchedPokemons.count
    }
    
    private func searchedPokemon(at index: Int) -> SearchedPokemon {
        return self.searchedPokemons[index]
    }
    
    func nameOfSearchedPokemon(at index: Int) -> String {
        return self.searchedPokemon(at: index).displayText()
    }
    
}

extension SearchViewModel: InputDelegate {
    
    func updateInput(with model: Input) {
        guard let pokemonNames = self.pokemonNames else { return }
        
        let languageIndex = model.languageType.rawValue
        let lowercasedText = model.text.lowercased()
        let filtered = pokemonNames.compactMap({ pokemon -> SearchedPokemon? in
            let lowercasedName = pokemon.names[languageIndex].lowercased()
            if lowercasedName.contains(lowercasedText) {
                return SearchedPokemon(name: pokemon,
                                               languageIndex: languageIndex)
                
            }
            return nil
        })
        
        self.searchedPokemons = filtered
    }
    
    
}
