//
//  DetailViewController.swift
//  Pokedex
//
//  Created by Luiz Vasconcellos on 24/04/21.
//

import UIKit
import Alamofire
import Kingfisher

class DetailViewController: UIViewController {

    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var detailTableView: UITableView!
    
    @IBOutlet weak var hpBarView: HorizontalProgressBarView!
    @IBOutlet weak var attackBarView: HorizontalProgressBarView!
    @IBOutlet weak var defenseBarView: HorizontalProgressBarView!
    @IBOutlet weak var specialAttackBarView: HorizontalProgressBarView!
    @IBOutlet weak var specialDefenseBarView: HorizontalProgressBarView!
    @IBOutlet weak var speedBarView: HorizontalProgressBarView!
    
    let evolutionBaseUrl = "https://pokeapi.co/api/v2/evolution-chain/"
    let navigationBarTitle = "Detalhes"
    let tableViewCellIdentifier = "detailCell"
    var pokemonObj: Pokemon? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        detailTableView.dataSource = self
        detailTableView.delegate = self
        
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
        }
    }
    
    func setupStats(for pokemon:Pokemon) {
        
        for stat in pokemon.stats {
            switch stat.stat.name.lowercased() {
            case "hp":
                hpBarView.progress = CGFloat(Double(stat.baseStat) / 250.0)
            case "attack":
                attackBarView.progress = CGFloat(Double(stat.baseStat) / 250.0)
            case "defense":
                defenseBarView.progress = CGFloat(Double(stat.baseStat) / 250.0)
            case "special-attack":
                specialAttackBarView.progress = CGFloat(Double(stat.baseStat) / 250.0)
            case "special-defense":
                specialDefenseBarView.progress = CGFloat(Double(stat.baseStat) / 250.0)
            case "speed":
                speedBarView.progress = CGFloat(Double(stat.baseStat) / 250.0)
            default:
                print("")
            }
        }
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
        
        return cell
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            if let url = pokemonObj?.abilities[indexPath.row].ability.url {
                getAbilityDetail(for: url)
            }
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
            print("SECTION :: 0 ROWS:: \(pokemonObj?.abilities.count )")
            return pokemonObj?.abilities.count ?? 0
        case 1:
            print("SECTION :: 1 ROWS:: \(pokemonObj?.types.count )")
            return pokemonObj?.types.count ?? 0
        default:
            return 0
        }
    }
    
}

extension DetailViewController {
    //MARK: API Call
    func getEvolutionChain(for id:Int) {
        
//        let evolutionUrl = evolutionBaseUrl + String(id)
//        AF.request(evolutionUrl).validate().responseDecodable(of: Pokedex.self) { (response) in
//            guard let pokedex = response.value else { return }
//        }
    }
    
    func getAbilityDetail(for url:String) {
        
        AF.request(url).validate().responseDecodable(of: AbilityDetail.self) { (response) in
            guard let abilityDetail = response.value else { return }
            
            var desc = ""
            for description in abilityDetail.effectEntries {
                if description.language.name.uppercased() == "EN" {
                    desc = description.effect
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
