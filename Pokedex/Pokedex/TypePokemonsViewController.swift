//
//  TypePokemonsViewController.swift
//  Pokedex
//
//  Created by Luiz Vasconcellos on 30/04/21.
//

import UIKit

class TypePokemonsViewController: UIViewController {

    @IBOutlet weak var pokemonCollectionView: UICollectionView!
    
    let networking = Networking()
    let cellReuseIdentifier = "pokemonTypeCell"
    let itemsPerRow: CGFloat = 3
    
    var pokemonType: TypeElement? = nil
    var pokemonList:[Pokemon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pokemonCollectionView.dataSource = self
        pokemonCollectionView.delegate = self

        if let type = self.pokemonType {
            self.navigationItem.title = type.type.name
            self.getPokemonList(for: type)
        }
    }
    
    override func viewWillLayoutSubviews() {
        super .viewWillLayoutSubviews()
        pokemonCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    func getPokemonList(for type:TypeElement) {
        networking.getPokemons(forType: type.type.url) { (type) in
            if type.pokemon.count > 0 {
                
                self.getPokemonInfo(for: type.pokemon)
            }
        }
    }
    
    func getPokemonInfo(for pokeList: [PokemonType]) {
        for item in pokeList {
            networking.getPokemon(for: item.pokemon.url) { (pokemon) in
                self.pokemonList.append(pokemon)
                self.pokemonList.sort { $0.id < $1.id }
                self.pokemonCollectionView.reloadData()
            }
        }
    }
}

extension TypePokemonsViewController: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
 
    //MARK: Collection View Layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let columns: CGFloat = itemsPerRow
        let spacing:CGFloat = 5
        let totalHorizontalSpacing = (columns - 1) * spacing
        
        let itemWidth = (collectionView.bounds.width - totalHorizontalSpacing) / columns
        let itemSize = CGSize(width: itemWidth, height: itemWidth * 1.8)
        
        return itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    //MARK: Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemonList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let pokedexCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! PokedexCollectionViewCell
        let pokemon = pokemonList[indexPath.row]
        pokedexCell.setup(with: pokemon)
        return pokedexCell
    }
}
