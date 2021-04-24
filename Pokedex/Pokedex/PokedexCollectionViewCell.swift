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
    
    func setup() {
        pokemonImage.backgroundColor = UIColor.systemGray5
        pokemonImage.layer.cornerRadius = 5
//        self.backgroundColor = UIColor.systemGray5
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.systemGray5.cgColor
    }
}
