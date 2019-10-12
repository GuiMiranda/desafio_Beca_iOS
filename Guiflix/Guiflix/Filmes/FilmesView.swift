//
//  FilmesView.swift
//  Guiflix
//
//  Created by Guilherme Miranda Lopes on 09/10/19.
//  Copyright © 2019 Guilherme Miranda Lopes. All rights reserved.
//

import UIKit

class FilmesView: UIViewController, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var grid: UICollectionView!
    @IBOutlet weak var filmeSearch: UISearchBar!
    
    
    let tela = "FilmesCollectionViewCell"
    let filmesCellidentifier = "filmesCell"
    var filmes: FilmesResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
        carregarDados()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        grid.register(UINib(nibName: tela, bundle: nil), forCellWithReuseIdentifier: filmesCellidentifier)
        grid.delegate = self
        grid.dataSource = self
    }
    
    func carregarDados(){
        let api = APIService()
        api.getPopularFilmes(pagina: 0, success: { (response) in
            self.filmes = response
            self.grid.reloadData()
        }) { (erro) in
            let alert = UIAlertController(title: "Erro", message: "Erro ao carregar a lista", preferredStyle: .alert)
            let button = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(button)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func commonInit() {
        let nib = UINib(nibName: "FilmesView", bundle: nil)
        let Filmesview = nib.instantiate(withOwner: self, options: nil).first as! UIView
        self.view = Filmesview
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return CGSize(width: 100, height: 180)
    }
    
}

extension FilmesView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filmes?.results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = grid.dequeueReusableCell(withReuseIdentifier: filmesCellidentifier, for: indexPath) as? FilmesCollectionViewCell else {fatalError()}
        
        let calendar = Calendar.current
        let filme = filmes?.results?[indexPath.row]
        
        let year = String(calendar.component(.year, from: (filme?.release_date)!.toDate()!))
        
        let poster = filme?.poster_path
        let title = filme?.title
        
        cell.setup(title: title!, poster: poster!, year: year)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetalhesViewController(nibName: "DetalhesView", bundle: nil)
        vc.filme = filmes?.results?[indexPath.row]
        self.present(vc, animated: true, completion: nil)
    }
}

