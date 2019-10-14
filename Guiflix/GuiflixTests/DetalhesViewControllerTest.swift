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
    
    let viewController = DetalhesViewController()
    
//    let filmeMock = Filme(popularity: 1, vote_count: 1, video: false, poster_path: "/e1mjopzAS2KNsvpbpahQ1a6SkSn.jpg", id: 123, adult: false, backdrop_path: "", original_language: "", original_title: "", genre_ids: [], genre: ["Suspense", "Acao"], title: "Filme blabla", vote_average: 9.98, overview: "From DC Comics comes the Suicide Squad, an antihero team of incarcerated supervillains who act as deniable assets for the United States government, undertaking high-risk black ops missions in exchange for commuted prison sentences.", release_date: "2019-01-01")
    
    func testaViewControllerSemFilme(){
        viewController.viewDidLoad()
        
    }

}
