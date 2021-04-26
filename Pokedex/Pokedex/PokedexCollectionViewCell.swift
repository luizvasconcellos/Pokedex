//
//  PokedexCollectionViewCell.swift
//  Pokedex
//
//  Created by Luiz Vasconcellos on 24/04/21.
//

import UIKit

class PokedexCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var namelbl: UILabel!
    
    func setup(with pokemon: Pokemon) {
        configureLayout()
        
        if let id = pokemon.id {
            idLbl.text = "№ \(String(id))"
//            idLbl.text = "№ \(String(format: "%03d", String(id)))"
        } else {
            idLbl.text = "№ -"
        }
        namelbl.text = pokemon.name
    }
    
    private func configureLayout() {
        pokemonImage.backgroundColor = UIColor.systemGray5
        pokemonImage.layer.cornerRadius = 5
        
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.systemGray5.cgColor
    }
}
