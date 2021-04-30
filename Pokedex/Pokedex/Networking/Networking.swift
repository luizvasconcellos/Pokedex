//
//  Networking.swift
//  Pokedex
//
//  Created by Luiz Vasconcellos on 28/04/21.
//

import Foundation
import Alamofire

class Networking {
    
    let pokedexBaseUrl  = "https://pokeapi.co/api/v2/pokemon/"
    let evolutionBaseUrl = "https://pokeapi.co/api/v2/evolution-chain/"
    let pokemonBaseUrl = "https://pokeapi.co/api/v2/pokemon/"
    
    func getPokedex(for url:String, completion: @escaping (Pokedex) -> Void) {
        
        var getUrl = pokedexBaseUrl
        if url != "" {
            getUrl = url
        }
        
        AF.request(getUrl).validate().responseDecodable(of: Pokedex.self) { (response) in
            
            switch response.result {
            case .success:
                print("Validation Successful")
            case let .failure(error):
                print("getPokedex error: \(error)")
                return
            }
            
            guard let pokedex = response.value else { return }
            completion(pokedex)
        }
    }
    
    func getPokemon(ByName name:String, completion: @escaping (Pokemon) -> Void){
        
        let url = pokemonBaseUrl + name.lowercased()
        getPokemon(for: url) { (pokemon) in
            completion(pokemon)
        }
    }
    
    func getPokemon(for url:String, completion: @escaping (Pokemon) -> Void) {
        
        AF.request(url).validate().responseDecodable(of: Pokemon.self) { (response) in
            
            switch response.result {
            case .success:
                print("Validation Successful")
            case let .failure(error):
                print("getpokemon error: \(error)")
                return
            }
            
            guard let pokemonResponse = response.value else { return }
            completion(pokemonResponse)
        }
    }
        
    func getSpecies(for url: String, completion: @escaping (Species) -> Void) {
        
        AF.request(url).validate().responseDecodable(of: Species.self) { (response) in
            switch response.result {
            case .success:
                print("Validation Successful")
            case let .failure(error):
                print(error)
                return
            }
            guard let responseSpecies = response.value else { return }
            
            completion(responseSpecies)
        }
    }
    
    func getEvolutionChain(for url:String, completion: @escaping (EvolutionChain) -> Void) {
        
        AF.request(url).validate().responseDecodable(of: EvolutionChain.self) { (response) in
            
            switch response.result {
            case .success:
                print("Validation Successful")
            case let .failure(error):
                print(error)
                return
            }
            guard let responseEvolution = response.value else { return }
            completion(responseEvolution)
        }
    }
    
    func getAbilityDetail(for url:String, completion: @escaping (AbilityDetail) -> Void) {
        
        AF.request(url).validate().responseDecodable(of: AbilityDetail.self) { (response) in
            
            switch response.result {
            case .success:
                print("Validation Successful")
            case let .failure(error):
                print(error)
                return
            }
            
            guard let abilityDetail = response.value else { return }
            completion(abilityDetail)
        }
    }
}

