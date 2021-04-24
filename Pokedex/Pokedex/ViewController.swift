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
    
    override func viewWillLayoutSubviews() {
        super .viewWillLayoutSubviews()
        pokedexCollectionView.collectionViewLayout.invalidateLayout()
    }

}

extension ViewController:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    //MARK: Collection View Layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let columns: CGFloat = 3
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
        
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let pokedexCell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokedexCell", for: indexPath) as! PokedexCollectionViewCell
        pokedexCell.setup()
        
        return pokedexCell
    }
}


