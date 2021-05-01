//
//  ViewController.swift
//  Pokedex
//
//  Created by Luiz Vasconcellos on 24/04/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pokedexCollectionView: UICollectionView!
    
    let networking = Networking()
    let pokedexRedColor = UIColor(red: 227/255.0, green: 53/255.0, blue: 13/255.0, alpha: 1.0)
    let itemsPerRow: CGFloat = 3
    let searchController = UISearchController(searchResultsController: nil)
    let detailSegueIdentifier = "DetailSegue"
    
    var lastContentOffset: CGFloat = 0
    var pokedexObj:Pokedex? = nil
    var pokemonList:[Pokemon] = []
    
    var filteredPokemons: [Pokemon] = []
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokedexCollectionView.dataSource = self
        pokedexCollectionView.delegate = self
        
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        getPokedexList()
        
        setSearchControllerApparence()
        setNavigationBarApparence()
    }
    
    override func viewWillLayoutSubviews() {
        super .viewWillLayoutSubviews()
        pokedexCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    func setSearchControllerApparence() {
        
        searchController.searchBar.backgroundColor = pokedexRedColor
        searchController.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Buscar...", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray3])
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField,
            let iconView = textField.leftView as? UIImageView, let clearButton = textField.value(forKey: "_clearButton")as? UIButton {

            iconView.image = iconView.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            iconView.tintColor = UIColor.white
            if let img3 = clearButton.image(for: .highlighted) {
                let tintedClearImage = img3.imageWithColor(color1: UIColor.white)
                clearButton.setImage(tintedClearImage, for: .normal)
                clearButton.setImage(tintedClearImage, for: .highlighted)
            }
        }
    }
    
    func setNavigationBarApparence() {
        
        let logoImage = UIImage(named: "logo-pokemon")
        let imageView = UIImageView(image:logoImage)
        self.navigationItem.titleView = imageView
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = pokedexRedColor
        navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        navigationController?.navigationBar.compactAppearance = navigationBarAppearance
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
    }
}

extension ViewController {
    //MARK: Get data
    func getPokedexList() {
        
        var getUrl = ""
        
        if let nextUrl = pokedexObj?.nextPageUrl {
            if nextUrl != "" {
                getUrl = nextUrl
            }
        } else {
            if let previousUrl = pokedexObj?.previousPageUrl {
                if previousUrl != "" {
                    return
                }
            }
        }
        
        var pokedexList:[Basic] = []
        networking.getPokedex(for: getUrl) { (pokedex) in
            self.pokedexObj = pokedex
            if pokedex.all.count > 0 {
                pokedexList = pokedex.all
                self.getPokemon(for: pokedexList)
            }
        }
        
    }
    
    func getPokemon(for pokedexList:[Basic]) {
        
        for item in pokedexList {
            if !item.url.isEmpty {
                
                networking.getPokemon(for: item.url) { (pokemon) in
                    self.pokemonList.append(pokemon)
                    self.pokemonList.sort { $0.id < $1.id }
                    self.pokedexCollectionView.reloadData()
                }
            }
        }
    }
}

extension ViewController:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
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
        if isFiltering {
            return filteredPokemons.count
        } else {
            return pokemonList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let pokedexCell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokedexCell", for: indexPath) as! PokedexCollectionViewCell
        
        let pokemon: Pokemon
        if isFiltering {
            pokemon = filteredPokemons[indexPath.row]
        } else {
            pokemon = pokemonList[indexPath.row]
        }
        
        pokedexCell.setup(with: pokemon)
        
        return pokedexCell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        if (lastContentOffset < scrollView.contentOffset.y) {
            getPokedexList()
            let searchBar = searchController.searchBar
            self.filterContentForSearchText(searchBar.text!)
            lastContentOffset = scrollView.contentOffset.y
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if pokemonList.count > 0 {
            let pokemon: Pokemon
            if isFiltering {
                pokemon = filteredPokemons[indexPath.row]
            } else {
                pokemon = pokemonList[indexPath.row]
            }
            performSegue(withIdentifier: detailSegueIdentifier, sender: pokemon)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == detailSegueIdentifier {
            if let detailVC = segue.destination as? DetailViewController {
                detailVC.pokemonObj = sender as! Pokemon
            }
        }
    }
}

extension ViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
    
    func filterContentForSearchText(_ searchText: String) {

        filteredPokemons = pokemonList.filter { $0.name.lowercased().contains(searchText.lowercased()) || (String($0.id) == searchText)
        }
        pokedexCollectionView.reloadData()
    }
    
}

extension UIImage {
    ///Extension para colocar os icones da searchbar brancos.
    func imageWithColor(color1: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        color1.setFill()

        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setBlendMode(CGBlendMode.normal)

        let rect = CGRect(origin: .zero, size: CGSize(width: self.size.width, height: self.size.height))
        context?.clip(to: rect, mask: self.cgImage!)
        context?.fill(rect)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
}
