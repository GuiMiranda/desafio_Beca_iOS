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
        if let v = filmesView {
            self.view.addSubview(v)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        filmesView?.lblFilme.text = "Sucesso!!!"
    }

}
