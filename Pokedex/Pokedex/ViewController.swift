//
//  ViewController.swift
//  Pokedex
//
//  Created by Luiz Vasconcellos on 24/04/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pokedexCollectionView: UICollectionView!
    
    private let itemsPerRow: CGFloat = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logo = UIImage(named: "logo-pokemon")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
        pokedexCollectionView.dataSource = self
        pokedexCollectionView.delegate = self
    }

}

extension ViewController:UICollectionViewDataSource,UICollectionViewDelegate {
    
    //MARK: Collection View
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let pokedexCell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokedexCell", for: indexPath) as! PokedexCollectionViewCell
        pokedexCell.setup()
        
        return pokedexCell
    }
}

