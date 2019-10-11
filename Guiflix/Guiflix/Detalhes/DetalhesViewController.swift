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
    private let imagemNaoFavoritado = UIImage(named: "favorite_border_black_24pt")
    private let imagemFavoritado = UIImage(named: "favorite_black_24pt")
    private let favoritosRepository = FavoritosRepository.getInstance()
    var favorito = false
    
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
        preencherAcessibilidade()
    }
    
    private func popularCamposFilme(){
        guard let filme = self.filme else{
            fatalError("Erro ao mostrar detalhes do filme selecionado")
        }
        navigationBar.title = filme.title
        let notaString = NSLocalizedString("detalhes.nota", comment: "")
        notaLabel.text = String.localizedStringWithFormat(notaString, String(Double(round(100*filme.vote_average!)/100)))
        sinopseTextField.text = filme.overview
        generoTextField.text = getGenres(idsGenre: filme.genre_ids!)     
        posterImage.load(url: filme.poster_path ?? "", size: .w780)
        
        favorito = favoritosRepository.findMovieById(id: filme.id!) != nil
        favoritoButton.image = favorito ? imagemFavoritado : imagemNaoFavoritado
    }
    
    private func preencherLabels(){
        voltarButton.title = NSLocalizedString("detalhes.voltar", comment: "")
        sinopseLabel.text = NSLocalizedString("detalhes.sinopse", comment: "")
        generoLabel.text = NSLocalizedString("detalhes.generos", comment: "")
    }
    
    @IBAction func clickFavorito(_ sender: Any) {
        if(favoritoButton.image == imagemFavoritado){
            favoritoButton.image = imagemNaoFavoritado
            favoritosRepository.remove(filme: filme!)
        } else{
            favoritoButton.image = imagemFavoritado
            favoritosRepository.add(filme: filme!)
        }
    }
    
    @IBAction func clickVoltar(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    private func preencherAcessibilidade(){
        voltarButton.accessibilityHint = NSLocalizedString("detalhes.voltar", comment: "")
        voltarButton.accessibilityValue = NSLocalizedString("detalhes.voltar", comment: "")
        
        sinopseLabel.accessibilityValue = NSLocalizedString("detalhes.sinopse", comment: "")
        sinopseLabel.accessibilityHint = NSLocalizedString("detalhes.sinopse", comment: "")
        
        generoLabel.accessibilityHint = NSLocalizedString("detalhes.generos", comment: "")
        generoLabel.accessibilityValue = NSLocalizedString("detalhes.generos", comment: "")
        
        generoTextField.accessibilityValue = generoTextField.text
        sinopseTextField.accessibilityValue = sinopseTextField.text
        
        notaLabel.accessibilityValue = notaLabel.text
        
        favoritoButton.accessibilityValue = NSLocalizedString(favorito ? "detalhes.desfavoritar" : "detalhes.favoritar", comment: "")
    }
    
}
