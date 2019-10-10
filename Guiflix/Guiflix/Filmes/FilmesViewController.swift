//
//  FilmesViewController.swift
//  Guiflix
//
//  Created by Guilherme Miranda Lopes on 09/10/19.
//  Copyright © 2019 Guilherme Miranda Lopes. All rights reserved.
//

import UIKit

class FilmesViewController: UIViewController {

    var filmesView : FilmesView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        filmesView = FilmesView(frame: view.frame)
        
        filmesView?.filmeTableView.register(FilmesTableViewCell.self, forCellReuseIdentifier: "celulaNova")

        
        if let v = filmesView {
            self.view.addSubview(v)
        }
    
        filmesView?.filmeTableView.delegate = self
        filmesView?.filmeTableView.dataSource = self
          
    }
}

extension FilmesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        print("Entrou no método cellForRowAt")
//
        if let cell = filmesView?.filmeTableView.dequeueReusableCell(withIdentifier: "celulaNova") as? FilmesTableViewCell {
            
            cell.setup()
        }
        
//        guard let celula = filmesView?.filmeTableView.dequeueReusableCell(withIdentifier: "celulaNova") as? FilmesTableViewCell else {fatalError()}
//
//        celula.lblTitle.text = "testando "
//
//        print("Finalizou a configuração da célula")
//
//
//
//
//        return celula
        
        return UITableViewCell()
        
    }
    
    
}
