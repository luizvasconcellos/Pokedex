//
//  DetailViewController.swift
//  Pokedex
//
//  Created by Luiz Vasconcellos on 24/04/21.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {

    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var detailTableView: UITableView!
    @IBOutlet weak var evolutionCollectionView: UICollectionView!
    
    @IBOutlet weak var hpBarView: HorizontalProgressBarView!
    @IBOutlet weak var attackBarView: HorizontalProgressBarView!
    @IBOutlet weak var defenseBarView: HorizontalProgressBarView!
    @IBOutlet weak var specialAttackBarView: HorizontalProgressBarView!
    @IBOutlet weak var specialDefenseBarView: HorizontalProgressBarView!
    @IBOutlet weak var speedBarView: HorizontalProgressBarView!
    
    let networking = Networking()
    let navigationBarTitle = "Detalhes"
    let tableViewCellIdentifier = "detailCell"
    let evolutionCellidentifier = "evolutionPokemonCell"
    let defaultLanguage = "EN"
    let typePokemonsSegue = "typeSegue"
    let maxStat: Double = 250.0
    var pokemonObj: Pokemon? = nil
    var evolutionPokemonList: [Pokemon] = []
    var typePokemonList: [Pokemon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        detailTableView.dataSource = self
        detailTableView.delegate = self
        evolutionCollectionView.dataSource = self
        evolutionCollectionView.delegate = self
        
        self.navigationItem.title = navigationBarTitle
        pokemonImage.backgroundColor = UIColor.systemGray5
        pokemonImage.layer.cornerRadius = 5
        
        if let pokemon = pokemonObj {
            
            if let imageURL = pokemon.sprites.other?.officialArtwork.frontDefault {
                KF.url(URL(string: imageURL)).cacheMemoryOnly(true).set(to: pokemonImage)
                
                self.idLbl.text = "№ \(String(pokemon.id))"
                self.nameLbl.text = pokemon.name
            }
            setupStats(for: pokemon)
            setupEvolution()
        }
    }
    
    func setupStats(for pokemon:Pokemon) {
        
        for stat in pokemon.stats {
            switch stat.stat.name.lowercased() {
            case "hp":
                hpBarView.progress = CGFloat(Double(stat.baseStat) / maxStat)
            case "attack":
                attackBarView.progress = CGFloat(Double(stat.baseStat) / maxStat)
            case "defense":
                defenseBarView.progress = CGFloat(Double(stat.baseStat) / maxStat)
            case "special-attack":
                specialAttackBarView.progress = CGFloat(Double(stat.baseStat) / maxStat)
            case "special-defense":
                specialDefenseBarView.progress = CGFloat(Double(stat.baseStat) / maxStat)
            case "speed":
                speedBarView.progress = CGFloat(Double(stat.baseStat) / maxStat)
            default:
                print("")
            }
        }
    }
    
    func setupEvolution() {
        getSpecies()
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = detailTableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier, for: indexPath)
        
        if indexPath.section == 0 {
            cell.textLabel?.text = pokemonObj?.abilities[indexPath.row].ability.name
        } else {
            cell.textLabel?.text = pokemonObj?.types[indexPath.row].type.name
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
        }
        
        return cell
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            if let url = pokemonObj?.abilities[indexPath.row].ability.url {
                showAbilityDetail(for: url)
            }
        } else if indexPath.section == 1 {
            let type = pokemonObj?.types[indexPath.row]
            performSegue(withIdentifier: typePokemonsSegue, sender: type)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        switch section {
        case 0: return "Habilidade"
        case 1: return "Tipo"
        default:
            return ""
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print("passou no numberOfRowsInSection")
        switch section {
        case 0:
            return pokemonObj?.abilities.count ?? 0
        case 1:
            return pokemonObj?.types.count ?? 0
        default:
            return 0
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == typePokemonsSegue {
            if let detailVC = segue.destination as? TypePokemonsViewController {
                detailVC.pokemonType = sender as! TypeElement
            }
        }
    }
}

extension DetailViewController {
    
    func getSpecies() {
        if let url = pokemonObj?.species.url {
            networking.getSpecies(for: url) { (species) in
                if let evChainUrl = species.evolutionChainUrl?.url {
                    self.showEvolution(url: evChainUrl)
                }
            }
        }
    }
    
    func showEvolution(url: String) {
        
        networking.getEvolutionChain(for: url) { (evolution) in
            if evolution.chain.evolvesTo.count > 0 {
                for item in evolution.chain.evolvesTo {
                    //get pokemon
                    if !item.species.name.isEmpty {
                        self.networking.getPokemon(ByName: item.species.name) { (pokemon) in
                            self.evolutionPokemonList.append(pokemon)
//                            self.pokemonList.sort { $0.id < $1.id }
//                            self.pokedexCollectionView.reloadData()
                            self.evolutionCollectionView.reloadData()
                        }
                    }
                }
            }
        }
    }
    
    func showAbilityDetail(for url:String) {
            
        networking.getAbilityDetail(for: url) { (abilityDetail) in
            var desc = ""
            for description in abilityDetail.effectEntries {
                if description.language.name.uppercased() == self.defaultLanguage {
                    desc = description.effect.description
                }
            }
            
            let alert = UIAlertController(title: abilityDetail.name,
                                          message: desc,
                                          preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension DetailViewController:UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let evolutionCell = evolutionCollectionView.dequeueReusableCell(withReuseIdentifier: evolutionCellidentifier, for: indexPath) as! EvolutionCollectionViewCell
        
        evolutionCell.setup(with: evolutionPokemonList[indexPath.row])
        
        return evolutionCell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return evolutionPokemonList.count
    }
    
}
