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
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    @IBOutlet weak var hpBarView: HorizontalProgressBarView!
    @IBOutlet weak var attackBarView: HorizontalProgressBarView!
    @IBOutlet weak var defenseBarView: HorizontalProgressBarView!
    @IBOutlet weak var specialAttackBarView: HorizontalProgressBarView!
    @IBOutlet weak var specialDefenseBarView: HorizontalProgressBarView!
    @IBOutlet weak var speedBarView: HorizontalProgressBarView!
    @IBOutlet weak var evolutionHeaderLbl: UILabel!
    
    let networking = Networking()
    let navigationBarTitle = "Detalhes"
    let tableViewCellIdentifier = "detailCell"
    let evolutionCellidentifier = "evolutionPokemonCell"
    let photoCellIdentifier = "photoCell"
    let defaultLanguage = "EN"
    let typePokemonsSegue = "typeSegue"
    let evHeaderText = "Evolução"
    let evHeaderWhitOutEvolutionText = "Este pokemon não possui evolução"
    let maxStat: Double = 250.0
    var pokemonObj: Pokemon? = nil
    var evolutionPokemonList: [Pokemon] = []
    var typePokemonList: [Pokemon] = []
    var imageList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        detailTableView.dataSource = self
        detailTableView.delegate = self
        evolutionCollectionView.dataSource = self
        evolutionCollectionView.delegate = self
        photoCollectionView.dataSource = self
        photoCollectionView.delegate = self
        
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
            getSpritsList()
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
    
    func getSpritsList() {
        if let pokemon = pokemonObj{
            if let artwork = pokemon.sprites.other?.officialArtwork {
                if let img = artwork.frontDefault {
                    if img.uppercased().suffix(4) != ".SVG" {
                        imageList.append(img)
                    }
                }
                if let img = artwork.frontFemale {
                    if img.uppercased().suffix(4) != ".SVG" {
                        imageList.append(img)
                    }
                }
            }
            if let dreamWorld = pokemon.sprites.other?.dreamWorld {
                if let img = dreamWorld.frontDefault {
                    if img.uppercased().suffix(4) != ".SVG" {
                        imageList.append(img)
                    }
                }
                if let img = dreamWorld.frontFemale {
                    if img.uppercased().suffix(4) != ".SVG" {
                        imageList.append(img)
                    }
                }
            }
        }
        photoCollectionView.reloadData()
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = detailTableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier, for: indexPath)
        
        if indexPath.section == 0 {
            cell.textLabel?.text = pokemonObj?.abilities[indexPath.row].ability.name
        } else {
            cell.textLabel?.text = pokemonObj?.types[indexPath.row].type.name
        }
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        return cell
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath , animated: false)
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
                detailVC.pokemonType = (sender as! TypeElement)
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
            
            if !evolution.chain.species.name.isEmpty {
                self.addPokemonToEvolutionList(for: evolution.chain.species.name)
            }
            
            if evolution.chain.evolvesTo.count > 0 {
                self.evolutionHeaderLbl.text = self.evHeaderText
                
                for item in evolution.chain.evolvesTo {
                    
                    if !item.species.name.isEmpty {
                        self.addPokemonToEvolutionList(for: item.species.name)
                    }
                    
                    var ev:[Chain] = item.evolvesTo
                    var count = 0
                    repeat {
                        if ev.count > 0 {
                        if !ev[count].species.name.isEmpty {
                            self.addPokemonToEvolutionList(for: ev[count].species.name)
                        }
                        ev = ev[count].evolvesTo
                        count += 1
                        }
                    } while ev.count > 0
                    
                }
            } else {
                self.evolutionHeaderLbl.text = "\(self.evHeaderText) - \(self.evHeaderWhitOutEvolutionText)"
            }
        }
    }
    
    func addPokemonToEvolutionList(for name:String) {
        
        self.networking.getPokemon(ByName: name) { (pokemon) in
            self.evolutionPokemonList.append(pokemon)
            self.evolutionPokemonList.sort { $0.id < $1.id }
            self.evolutionCollectionView.reloadData()
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
        if collectionView == evolutionCollectionView {
            let evolutionCell = evolutionCollectionView.dequeueReusableCell(withReuseIdentifier: evolutionCellidentifier, for: indexPath) as! EvolutionCollectionViewCell
            
            evolutionCell.setup(with: evolutionPokemonList[indexPath.row])
            
            return evolutionCell
        } else {
            let photoCell = photoCollectionView.dequeueReusableCell(withReuseIdentifier: photoCellIdentifier, for: indexPath) as! PhotoCollectionViewCell
            
            photoCell.setup(with: imageList[indexPath.row])
            
            return photoCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if collectionView == evolutionCollectionView {
            return evolutionPokemonList.count
        } else {
            return imageList.count
        }
    }
    
}
