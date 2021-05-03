//
//  PhotoCollectionViewCell.swift
//  Pokedex
//
//  Created by Luiz Vasconcellos on 02/05/21.
//

import UIKit
import Kingfisher

class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var pokemonImage: UIImageView!
    
    func setup(with image: String) {
        configureLayout()
        if !image.isEmpty {
            print("IMAGE :: " + image)
            KF.url(URL(string: image)).cacheMemoryOnly(true).onSuccess({ (result) in }).set(to: pokemonImage)
        }
    }
    
    private func configureLayout() {
        pokemonImage.backgroundColor = UIColor.systemGray5
    }
}
