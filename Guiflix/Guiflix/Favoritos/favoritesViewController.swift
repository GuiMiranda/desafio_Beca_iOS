//
//  favoritesViewController.swift
//  Guiflix
//
//  Created by Raphael Matrone on 11/10/19.
//  Copyright © 2019 Guilherme Miranda Lopes. All rights reserved.
//

import UIKit
import Lottie

class favoritesViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var favSearch: UISearchBar!
    @IBOutlet weak var favGrid: UICollectionView!
    
    let telaFav = "FavoritosCollectionViewCell"
    let favsCellidentifier = "favCell"
    
    var filmes = [Filme]()
    
    let animationView = AnimationView()
    
    func emptySearch() {
        let animation = Animation.named("seach-empty", subdirectory: nil)
          
          animationView.animation = animation
          animationView.contentMode = .scaleAspectFit
          view.addSubview(animationView)
        
          animationView.backgroundBehavior = .pauseAndRestore
          animationView.translatesAutoresizingMaskIntoConstraints = false
          animationView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
          animationView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
          
          animationView.setContentCompressionResistancePriority(.fittingSizeLevel, for: .horizontal)
        
        animationView.play(fromProgress: 0,
                           toProgress: 1,
                           loopMode: LottieLoopMode.playOnce,
                           completion: { (finished) in
                            if finished {
                              print("Animation Complete")
                            } else {
                              print("Animation cancelled")
                            }
                            self.animationView.removeFromSuperview()
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
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
        if (filmes.count > 0 ) {
            favGrid.reloadData()
        }
        else {
            emptySearch()
        }
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
        
        let filme = filmes[indexPath.row]
        cell.setup(filme: filme)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetalhesViewController(nibName: "DetalhesView", bundle: nil)
        vc.filme = filmes[indexPath.row]
        self.present(vc, animated: true, completion: nil)
    }
    
}
