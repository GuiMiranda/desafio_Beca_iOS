//
//  DetalhesViewControllerTest.swift
//  GuiflixTests
//
//  Created by Scott Yamagami Takahashi on 11/10/19.
//  Copyright © 2019 Guilherme Miranda Lopes. All rights reserved.
//

import XCTest
@testable import Guiflix

class DetalhesViewControllerTest: XCTestCase {
    private var rootWindow : UIWindow?
    
    private let filmeMock = Filme(popularity: 48.261451, vote_count: 1466, video: false, poster_path: "/e1mjopzAS2KNsvpbpahQ1a6SkSn.jpg", id: 1, adult: false, backdrop_path: "/ndlQ2Cuc3cjTL7lTynw6I4boP4S.jpg", original_language: "en", original_title: "Suicide Squad", genre_ids: [14,28], title: "Suicide Squad", vote_average: 5.91, overview: "From DC Comics comes the Suicide Squad, an antihero team of incarcerated supervillains who act as deniable assets for the United States government, undertaking high-risk black ops missions in exchange for commuted prison sentences.", release_date: "2016-08-03", isFavorite: false)
    
    override func setUp() {
        rootWindow  = UIWindow(frame: UIScreen.main.bounds)
        rootWindow!.isHidden = false
    }
    
    //TODO ver como fazer o asser do fatalError
//    func testaViewControllerSemFilme(){
//        viewController.viewDidLoad()
//
//    }
    
    override func tearDown() {
        rootWindow!.rootViewController = nil
        rootWindow!.isHidden = true
        rootWindow = nil
    }
    
    func testaViewControllerComFilmeNaoFavoritado(){
        let viewController = DetalhesViewController(nibName: "DetalhesView", bundle: nil)
        viewController.filme = filmeMock
        rootWindow!.rootViewController = viewController
        
        XCTAssertEqual(viewController.navigationBar.title, filmeMock.title)
        XCTAssertEqual(viewController.sinopseTextField.text, filmeMock.overview)
        XCTAssertTrue((viewController.notaLabel.text?.contains(String(arredondarNota(filmeMock.vote_average!))))!)
        XCTAssertEqual(viewController.sinopseTextField.text, filmeMock.overview)

        //TODO testar o conteudo da imagem
//        sleep(4)
//        let imageExpected = UIImage(named: "imgTestExpected.jpg")
//        XCTAssertEqual(viewController.posterImage.image, imageExpected)
        //TODO fazer os asseerts que os campos estao devidamentes preenchidos
    }

}
