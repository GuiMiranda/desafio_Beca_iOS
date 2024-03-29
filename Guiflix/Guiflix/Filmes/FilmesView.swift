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
    var filmesFiltrados: [Filme] = []
    var filmesResultados: [Filme] = []
    var searching = false
    var fetchingMore = false
    var paginaAPI = 2
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
        carregarDados(pag: 0)
        filmeSearch.delegate = self
        filmeSearch.searchTextField.textColor = UIColor.white
        filmeSearch.tintColor = .white
        grid.alwaysBounceVertical = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        grid.register(UINib(nibName: tela, bundle: nil), forCellWithReuseIdentifier: filmesCellidentifier)
        grid.delegate = self
        grid.dataSource = self
    }
    
    func carregarDados(pag : Int) {
        let api = APIService()
        api.getPopularFilmes(pagina: pag, success: { (response) in
   
            if pag == 0 {
                self.filmes = response
            } else {
                self.filmesResultados = (self.filmes?.results)!
                self.filmesResultados.append(contentsOf: response.results!)
                self.filmes?.results = self.filmesResultados
                self.paginaAPI += 1
            }
            
           
            
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
        return searching ? filmesFiltrados.count : filmes?.results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = grid.dequeueReusableCell(withReuseIdentifier: filmesCellidentifier, for: indexPath) as? FilmesCollectionViewCell else {fatalError()}
        guard let filme = filmes?.results?[indexPath.row] else {fatalError()}
        searching ? cell.setup(filme: filmesFiltrados[indexPath.row]) : cell.setup(filme: filme)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetalhesViewController(nibName: "DetalhesView", bundle: nil)
        
        guard let filmeOriginal = filmes?.results?[indexPath.row] else {fatalError()}
        if searching {
            vc.filme = filmesFiltrados[indexPath.row]
        } else {
            vc.filme = filmeOriginal
        }
        self.present(vc, animated: true, completion: nil)
    }
    func scrollViewDidScroll(_ scrollView:UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height {
            if !fetchingMore {
                beginBatchFetched()
            }
        }
    }
    func beginBatchFetched(){
        fetchingMore = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.carregarDados(pag: self.paginaAPI)
            self.fetchingMore = false

        })
        

    }
}

    
    extension FilmesView: UISearchBarDelegate {
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if searchText.isEmpty {
                searching = false

                grid.reloadData()
            } else if searchText == " " {
                filmeSearch.text = ""
            } else {
                let api = APIService()
                api.getSearchFilmes(pagina: 0, query: filmeSearch.text!, success: { (FilmesResponse) in
                    self.filmesFiltrados = FilmesResponse.results!
                    self.searching = true
                    self.grid.reloadData()
                }) { (mensagem) in
                    self.searching = false
                    self.grid.reloadData()
                }
                
//                guard let filtrados = filmes?.results?.filter({$0.title?.lowercased().contains(searchText.lowercased()) ?? false}) else {return}
//                filmesFiltrados = filtrados
//                searching = true
//                grid.reloadData()
            }
        }
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            if filmeSearch.text!.isEmpty{
                filmeSearch.endEditing(true)
            } else {
                searching = false
                filmeSearch.text = ""
                grid.reloadData()
                filmeSearch.endEditing(true)
            }
        }
        
}
