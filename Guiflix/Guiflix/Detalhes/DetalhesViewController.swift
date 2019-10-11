//
//  DetalheViewController.swift
//  Guiflix
//
//  Created by Scott Yamagami Takahashi on 10/10/19.
//  Copyright © 2019 Guilherme Miranda Lopes. All rights reserved.
//

import UIKit

class DetalhesViewController: UIViewController {
    
    var filme : Filme?
    let imagemNaoFavoritado = UIImage(named: "favorite_border_black_24pt")
    let imagemFavoritado = UIImage(named: "favorite_black_24pt")
    
    //iboutlets de variaveis
    @IBOutlet weak var voltarButton: UIBarButtonItem!
    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var favoritoButton: UIBarButtonItem!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var notaLabel: UILabel!
    @IBOutlet weak var sinopseTextField: UITextView!
    @IBOutlet weak var generoTextField: UITextView!
    
    @IBOutlet weak var sinopseLabel: UILabel!
    @IBOutlet weak var generoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popularCamposFilme()
        preencherLabels()
    }
    
    
    func popularCamposFilme(){
        //TODO remover o mock
        filme = Filme(popularity: 1, vote_count: 1, video: false, poster_path: "/e1mjopzAS2KNsvpbpahQ1a6SkSn.jpg", id: 123, adult: false, backdrop_path: "", original_language: "", original_title: "", genre_ids: [], genre: ["Suspense", "Acao"], title: "Filme blabla", vote_average: 9.98, overview: "From DC Comics comes the Suicide Squad, an antihero team of incarcerated supervillains who act as deniable assets for the United States government, undertaking high-risk black ops missions in exchange for commuted prison sentences.", release_date: "2019-01-01")
        
        guard let filme = self.filme else{
            fatalError("Erro ao mostrar detalhes do filme selecionado")
        }
        
        
        navigationBar.title = filme.title
//        notaLabel.text = "\(NSLocalizedString("detalhes.nota", comment: ""))\(String(Double(round(100*filme.vote_average)/100)))"
        let notaString = NSLocalizedString("detalhes.nota", comment: "")
        notaLabel.text = String.localizedStringWithFormat(notaString, String(Double(round(100*filme.vote_average)/100)))
        sinopseTextField.text = filme.overview
        generoTextField.text = filme.genre.joined(separator: ",")
        
        //TODO verificar qual a melhor maneira de carregar a imagem de uma url
        //TODO ler o baseUrl da constantes
        let url = NSURL(string: "https://image.tmdb.org/t/p/w780\(filme.poster_path)")! as URL
        if let imageData: NSData = NSData(contentsOf: url) {
            posterImage.image = UIImage(data: imageData as Data)
        }
    }
    
    func preencherLabels(){
        voltarButton.title = NSLocalizedString("detalhes.voltar", comment: "")
        sinopseLabel.text = NSLocalizedString("detalhes.sinopse", comment: "")
        generoLabel.text = NSLocalizedString("detalhes.generos", comment: "")
    }
    
    @IBAction func clickFavorito(_ sender: Any) {
        // TODO implementar a funcao - chamar o servico de salvar remover um favorito
        if(favoritoButton.image == imagemFavoritado){
            favoritoButton.image = imagemNaoFavoritado
        } else{
            favoritoButton.image = imagemFavoritado
        }
    }
    
    @IBAction func clickVoltar(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
