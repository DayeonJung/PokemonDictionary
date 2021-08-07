//
//  SearchViewModel.swift
//  PokemonDictionary
//
//  Created by Dayeon Jung on 2021/08/06.
//

import Foundation

class SearchViewModel {
    
    private var names: [PokemonName]?
    private var locations: [PokemonLocation]?
    private var searchedPokemons: [SearchedPokemon] = [] {
        didSet {
            self.updateList?()
        }
    }
        
    var updateList: (() -> Void)?
    var moveToDestinationVC: ((PokemonDetailsViewModel) -> Void)?
    
    init() {
        self.getPokemonNames()
        self.getLocationsOfPokemons()
    }
    
    private func getPokemonNames() {
        
        API.shared.get(resource: Resource<PokemonNames>(url: .names)) { result in
            switch result {
            case .success(let datas):
                self.names = datas.pokemons
                
            case .failure(let error):
                self.names = nil
                print("Error", error.localizedDescription)

            }
        }
    }
    
    private func getLocationsOfPokemons() {
        
        API.shared.get(resource: Resource<PokemonLocations>(url: .locations)) { result in
            switch result {
            case .success(let datas):
                self.locations = datas.pokemons
                
            case .failure(let error):
                self.locations = nil
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
    
    func didSelectItem(at index: Int) {
        let pokemon = self.searchedPokemon(at: index)
        let id = pokemon.name.id
        let names = pokemon.name.names
        let latLngInfo = self.findLocationInfos(with: id)
        let pokemonDetailVM = PokemonDetailsViewModel(id: id,
                                                      names: names,
                                                      locations: latLngInfo)
        self.moveToDestinationVC?(pokemonDetailVM)
    }
    
    private func findLocationInfos(with id: Int) -> [(Double, Double)] {
        guard let locationInfos = locations else { return [] }
        return locationInfos.compactMap({ location -> (Double, Double)? in
            guard location.id == id else {
                return nil
            }
            return (location.lat, location.lng)
        })
    }
    
}

extension SearchViewModel: InputDelegate {
    
    func updateInput(with model: Input) {
        guard let pokemonNames = self.names else { return }
        
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
