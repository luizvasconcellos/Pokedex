//
//  EvolutionCollectionViewCell.swift
//  Pokedex
//
//  Created by Luiz Vasconcellos on 29/04/21.
//

import UIKit
import Kingfisher

class EvolutionCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonNameLbl: UILabel!
    
    func setup(with pokemon: Pokemon) {
        configureLayout()
        if let imageURL = pokemon.sprites.other?.officialArtwork.frontDefault {
            KF.url(URL(string: imageURL)).cacheMemoryOnly(true).onSuccess({ (result) in
                //TODO:: Incluir para remover a animação de carregamento
            }).set(to: pokemonImage)
            
            self.pokemonNameLbl.text = pokemon.name
        }
    }
    
    private func configureLayout() {
        pokemonImage.backgroundColor = UIColor.systemGray5
        pokemonImage.layer.cornerRadius = 5
        
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.systemGray5.cgColor
    }
}
