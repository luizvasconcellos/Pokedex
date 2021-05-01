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
                guard let pokedex = response.value else { return }
                completion(pokedex)
            case let .failure(error):
                print("getPokedex error: \(error)")
                return
            }
            
            
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
                guard let pokemonResponse = response.value else { return }
                completion(pokemonResponse)
            case let .failure(error):
                print("getPokemon error: \(error)")
                return
            }
            
            
        }
    }
        
    func getSpecies(for url: String, completion: @escaping (Species) -> Void) {
        
        AF.request(url).validate().responseDecodable(of: Species.self) { (response) in
            switch response.result {
            case .success:
                guard let responseSpecies = response.value else { return }
                completion(responseSpecies)
            case let .failure(error):
                print(error)
                return
            }
            
        }
    }
    
    func getEvolutionChain(for url:String, completion: @escaping (EvolutionChain) -> Void) {
        
        AF.request(url).validate().responseDecodable(of: EvolutionChain.self) { (response) in
            
            switch response.result {
            case .success:
                guard let responseEvolution = response.value else { return }
                completion(responseEvolution)
            case let .failure(error):
                print(error)
                return
            }
            
        }
    }
    
    func getAbilityDetail(for url:String, completion: @escaping (AbilityDetail) -> Void) {
        
        AF.request(url).validate().responseDecodable(of: AbilityDetail.self) { (response) in
            
            switch response.result {
            case .success:
                guard let abilityDetail = response.value else { return }
                completion(abilityDetail)
            case let .failure(error):
                print(error)
                return
            }
            
            
        }
    }
    
    func getPokemons(forType typeUrl: String, completion: @escaping (Type) -> Void) {
        
        AF.request(typeUrl).validate().responseDecodable(of: Type.self) { (response) in
            
            switch response.result {
            case .success:
                guard let type = response.value else { return }
                completion(type)
            case let .failure(error):
                print(error)
                return
            }
            
            
        }
    }
}

