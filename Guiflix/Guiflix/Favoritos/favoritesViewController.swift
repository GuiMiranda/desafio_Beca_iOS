//
//  favoritesViewController.swift
//  Guiflix
//
//  Created by Raphael Matrone on 11/10/19.
//  Copyright © 2019 Guilherme Miranda Lopes. All rights reserved.
//

import UIKit

class favoritesViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var favSearch: UISearchBar!
    @IBOutlet weak var favGrid: UICollectionView!
    
    let telaFav = "FavoritosCollectionViewCell"
    let favsCellidentifier = "favCell"
    
    var filmes = [Filme]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
//        if let flowLayout = favGrid.collectionViewLayout as? UICollectionViewFlowLayout {
//            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
//        }
    }
    
    
    
    private func commonInit() {
        
        let nib = UINib(nibName: "favoritesViewController", bundle: nil)
        let favView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        self.view = favView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        favGrid.register(UINib(nibName: telaFav, bundle: nil), forCellWithReuseIdentifier: favsCellidentifier)
        favGrid.delegate = self
        favGrid.dataSource = self
        loadFilme()

    }
    
    func loadFilme() {
        filmes = FavoritosRepository.getInstance().listMovies()
        favGrid.reloadData()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screen = UIScreen.main.bounds
        return CGSize(width:screen.width, height: screen.height)
    }
    
}


extension favoritesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filmes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = favGrid.dequeueReusableCell(withReuseIdentifier: favsCellidentifier, for: indexPath) as? FavoritosCollectionViewCell else {fatalError()}
        
        let calendar = Calendar.current
        
        let year = String(calendar.component(.year, from: (filmes[indexPath.row].release_date)!.toDate()!))
        let poster = filmes[indexPath.row].poster_path
        let title = filmes[indexPath.row].original_title
        
        cell.setup(title: title!, poster: poster!, year: year)
        
        return cell
    }
    
}
