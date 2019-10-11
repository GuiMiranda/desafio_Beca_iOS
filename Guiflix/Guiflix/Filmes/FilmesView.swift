//
//  FilmesView.swift
//  Guiflix
//
//  Created by Guilherme Miranda Lopes on 09/10/19.
//  Copyright © 2019 Guilherme Miranda Lopes. All rights reserved.
//

import UIKit

class FilmesView: UIViewController {

    
    @IBOutlet weak var filmesViewPrincipal: UIView!
    @IBOutlet weak var filmeTableView: UITableView!
    let nib = "FilmesTableViewCell"
    let identifier = "celulaNova"
    var filmes: FilmesResponse?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commonInit()
        carregarDados()
        filmeTableView.register(UINib(nibName: nib, bundle: nil), forCellReuseIdentifier: identifier)
        filmeTableView.delegate = self
        filmeTableView.dataSource = self
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func carregarDados(){
        let api = APIService()
        api.getPopularFilmes(pagina: 0, success: { (response) in
            self.filmes = response
            self.filmeTableView.reloadData()
        }) { (erro) in
            let alert = UIAlertController(title: "Erro", message: "Erro ao carregar a lista", preferredStyle: .alert)
            let button = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(button)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func commonInit() {
        let nib = UINib(nibName: "FilmesView", bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        self.filmesViewPrincipal.addSubview(view)
    }
    
}

extension FilmesView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filmes?.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let celula = filmeTableView.dequeueReusableCell(withIdentifier: identifier) as? FilmesTableViewCell else {fatalError()}
        let calendar = Calendar.current
        let year = String(calendar.component(.year, from: (filmes?.results?[indexPath.row].release_date)!.toDate()!))
        
        let poster = filmes?.results?[indexPath.row].poster_path
        let title = filmes?.results?[indexPath.row].title

        celula.setup(title: title!, poster: poster!, year: year)
            return celula
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetalhesViewController(nibName: "DetalhesView", bundle: nil)
        vc.filme = filmes?.results?[indexPath.row]
        self.present(vc, animated: true, completion: nil)
    }
    
}
