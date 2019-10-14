//
//  favoritesViewController.swift
//  Guiflix
//
//  Created by Raphael Matrone on 11/10/19.
//  Copyright © 2019 Guilherme Miranda Lopes. All rights reserved.
//

import UIKit
import Lottie

protocol favoritosDelegate: class {
    func doSomenthing()
}

class favoritesViewController: UIViewController, UICollectionViewDelegateFlowLayout, favoritosDelegate {
    func doSomenthing() {
        loadFilme()
    }
    
    
    @IBOutlet weak var favSearch: UISearchBar!
    @IBOutlet weak var favGrid: UICollectionView!
    
    let telaFav = "FavoritosCollectionViewCell"
    let favsCellidentifier = "favCell"
    
    var filmes = [Filme]()
    var filmesFiltrados: [Filme] = []
    var searching = false
    
    func emptySearch() {
        let animation = Animation.named("search-empty", subdirectory: nil)
        let animationView = AnimationView()
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        view.addSubview(animationView)

        animationView.backgroundBehavior = .pauseAndRestore
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
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
                            animationView.removeFromSuperview()
                            self.tabBarController?.selectedIndex = 0
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
        favSearch.delegate = self
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
        if (filmes.count == 0 ) {
            emptySearch()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screen = UIScreen.main.bounds
        var bottomPadding: CGFloat = 0.0
        var topPadding: CGFloat = 0.0
        if #available(iOS 11.0, *) {
             let window = UIApplication.shared.keyWindow
             bottomPadding = window?.safeAreaInsets.bottom ?? 0.0
            topPadding = window?.safeAreaInsets.top ?? 0.0
        }

        let menos = bottomPadding + topPadding + 100
        return CGSize(width:screen.width, height: self.view.frame.height - menos)
    }
    
}


extension favoritesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searching ? filmesFiltrados.count : filmes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = favGrid.dequeueReusableCell(withReuseIdentifier: favsCellidentifier, for: indexPath) as? FavoritosCollectionViewCell else {fatalError()}
        let filme = filmes[indexPath.row]
        searching ? cell.setup(filme: filmesFiltrados[indexPath.row]) : cell.setup(filme: filme)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetalhesViewController(nibName: "DetalhesView", bundle: nil)
        if searching {
            vc.filme = filmesFiltrados[indexPath.row]
        } else {
            vc.filme = filmes[indexPath.row]
        }
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
}

extension favoritesViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            searching = false
            favGrid.reloadData()
        } else if searchText == " " {
            searchBar.text = ""
        } else {
            let filtrados = filmes.filter({($0.title?.lowercased().contains(searchText.lowercased()) ?? false)})
            filmesFiltrados = filtrados
            searching = true
            favGrid.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if favSearch.text!.isEmpty{
            favSearch.endEditing(true)
        } else {
        searching = false
        favSearch.text = ""
        favGrid.reloadData()
        favSearch.endEditing(true)
        }
    }
}
