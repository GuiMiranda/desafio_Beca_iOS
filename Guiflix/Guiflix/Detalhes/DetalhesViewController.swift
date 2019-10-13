//
//  DetalheViewController.swift
//  Guiflix
//
//  Created by Scott Yamagami Takahashi on 10/10/19.
//  Copyright © 2019 Guilherme Miranda Lopes. All rights reserved.
//

import UIKit
import Lottie

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
    
    override func viewDidAppear(_ animated: Bool) {
        if (AppDelegate.addFavorito) {
            let alert = UIAlertController(title: nil, message: "Estamos quase lá, agora toque no coração", preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: { (a) in
                
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func popularCamposFilme(){
        guard let filmeOK = self.filme else{
            fatalError("Erro ao mostrar detalhes do filme selecionado")
        }
        navigationBar.title = filmeOK.title
        navigationBar.leftBarButtonItem?.tintColor = .white
        let notaString = NSLocalizedString("detalhes.nota", comment: "")
        notaLabel.text = String.localizedStringWithFormat(notaString, String(Double(round(100*filmeOK.vote_average!)/100)))
        sinopseTextField.text = filmeOK.overview

        generoTextField.text = getGenres(idsGenre: filmeOK.genre_ids)
        posterImage.load(url: filmeOK.poster_path ?? "", size: .w780)
        
        //TODO, quando a tabela mostrar o favoritos, teremos que alterar esse trecho
        //
        favorito = (favoritosRepository.findMovieById(id: filmeOK.id) != nil)
        favoritoButton.image = favorito ? imagemFavoritado : imagemNaoFavoritado
    }
    
    private func preencherLabels(){
        voltarButton.title = NSLocalizedString("detalhes.voltar", comment: "")
        sinopseLabel.text = NSLocalizedString("detalhes.sinopse", comment: "")
        generoLabel.text = NSLocalizedString("detalhes.generos", comment: "")
    }
    
    @IBAction func clickFavorito(_ sender: Any) {
        if(favorito){
            favoritoButton.image = imagemNaoFavoritado
            favorito=false
            favoritosRepository.remove(filme: filme)
        } else{
            favoritoButton.image = imagemFavoritado
            favorito=true
            favoritosRepository.add(filme: filme)
            addSucesso()
            addFavoriteAnimation()
        }
    }
    
    func addSucesso() {
        if (AppDelegate.addFavorito) {
            let alert = UIAlertController(title: nil, message: "Muito bom, agora você já tem o seu primeiro filme favorito", preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: { (a) in
                AppDelegate.addFavorito = false
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func addFavoriteAnimation() {
        let animation = Animation.named("favorite-heart", subdirectory: nil)

        let animationView = AnimationView()
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        posterImage.addSubview(animationView)

        animationView.backgroundBehavior = .pauseAndRestore
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.centerYAnchor.constraint(equalTo: posterImage.centerYAnchor).isActive = true
        animationView.centerXAnchor.constraint(equalTo: posterImage.centerXAnchor).isActive = true


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
        })
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
