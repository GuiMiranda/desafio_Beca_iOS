//
//  APIService.swift
//  Guiflix
//
//  Created by Andre Medeiros Silva on 10/10/19.
//  Copyright © 2019 Guilherme Miranda Lopes. All rights reserved.
//
import UIKit

class APIService {
    
    public typealias ListSuccess = ((_ resposta: FilmesResponse) -> Void)
    public typealias ListError = ((_ errorMessage: String) -> Void)
    var favoritos: [Filme] = []
    
    func getPopularFilmes(pagina: Int, success: @escaping ListSuccess,  failure: @escaping ListError) {
        
        let url: URL?
        if pagina != 0{
             url = URL(string: "\(URL_BASE_API)\(API_KEY)&page=\(pagina)")
        }else{
             url = URL(string: "\(URL_BASE_API)\(API_KEY)")
        }
        
        guard let urlOK = url else {
            return
        }
  
        let session = URLSession.shared
        session.dataTask(with: urlOK) {data, response, error in
            if error != nil {
                 print(error!.localizedDescription)
             }
             guard let data = data else { return }
                do {
                    let filmesResponse = try JSONDecoder().decode(FilmesResponse.self, from: data)
                    DispatchQueue.main.async {
                        let response = filmesResponse
                        let filmesAPI = response.results
                        let favorities = FavoritosRepository.getInstance().listMovies()
                       
                        for var filme in filmesAPI ?? []{
                            filme.isFavorite = false
                            for favorito in favorities{
                                if filme.id == favorito.id{
                                    filme.isFavorite = true
                                }
                            }
                        }
                        success(response)
                    }
                } catch {
                    failure("JSON error: \(error.localizedDescription)")
                }
        }.resume()
    }
}
        








