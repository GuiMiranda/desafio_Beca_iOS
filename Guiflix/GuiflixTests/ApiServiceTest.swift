//
//  ApiServiceTest.swift
//  GuiflixTests
//
//  Created by Scott Yamagami Takahashi on 14/10/19.
//  Copyright © 2019 Guilherme Miranda Lopes. All rights reserved.
//

import XCTest
@testable import Guiflix

class ApiServiceTest: XCTestCase {
    
    var apiService = APIService()
    
    /**
     * Testa a estrutura da response.
     * TODO - mockar o endpoint
    */
    func testaEstruturaDaResposta(){
        let expectation =  XCTestExpectation(description: "Success foi chamado")
        apiService.getPopularFilmes(pagina: 0, success: { (response) in
            XCTAssertNotNil(response.page)
            XCTAssertNotNil(response.results)
            self.testaEstruturaMovie(filme: response.results!.first!)
            expectation.fulfill()
        }) { (erro) in
            
        }
        
    }
    
    /**
     * Funcao auxiliar para testar as propriedades do filme que sao utilizadas pelo app
    */
    private func testaEstruturaMovie(filme: Filme){
        XCTAssertNotNil(filme.id)
        XCTAssertNotNil(filme.overview)
        XCTAssertNotNil(filme.release_date)
        XCTAssertNotNil(filme.release_date?.getYear)
        XCTAssertNotNil(filme.poster_path)
        XCTAssertNotNil(filme.genre_ids)
    }

}
