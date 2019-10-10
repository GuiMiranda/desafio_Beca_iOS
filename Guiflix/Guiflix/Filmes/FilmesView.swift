//
//  FilmesView.swift
//  Guiflix
//
//  Created by Guilherme Miranda Lopes on 09/10/19.
//  Copyright © 2019 Guilherme Miranda Lopes. All rights reserved.
//

import UIKit

class FilmesView: UIViewController {

    @IBOutlet weak var filmeTableView: UITableView!
    let nib = "FilmesTableViewCell"
    let identifier = "celulaNova"
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        commonInit()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commonInit()
        filmeTableView.register(UINib(nibName: nib, bundle: nil), forCellReuseIdentifier: identifier)
//        filmeTableView.register(FilmesTableViewCell.self, forCellReuseIdentifier: identifier)
        filmeTableView.delegate = self
        filmeTableView.dataSource = self
        
    }
    
    
    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        commonInit()
//    }
//
    private func commonInit() {

        let nib = UINib(nibName: "FilmesView", bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView

        self.view.addSubview(view)

    }
    
}

extension FilmesView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let celula = filmeTableView.dequeueReusableCell(withIdentifier: identifier) as? FilmesTableViewCell else {fatalError()}
        let ano = 2000 + indexPath.row
        celula.setup(filme: "Vingadores", imagem: "FilmeTeste", ano: String(ano))
        
        return celula
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Parabéns", message: "Você escolheu a linha de índice \(indexPath.row + 1)", preferredStyle: .alert)
        let button = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(button)
        self.present(alert, animated: true, completion: nil)
    }
    
}
