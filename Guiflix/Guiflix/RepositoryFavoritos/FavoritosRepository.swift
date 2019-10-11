//
//  FavoritosRepository.swift
//  Guiflix
//
//  Created by Guilherme Miranda Lopes on 10/10/19.
//  Copyright © 2019 Guilherme Miranda Lopes. All rights reserved.
//

import UIKit

class FavoritosRepository: NSObject {
    
    let preferences = UserDefaults.standard
    
    let favoritolKey = "favorito"
    
    private static var instance : FavoritosRepository?
    
    private override init(){
        super.init()
    }
    
    public static func getInstance() -> FavoritosRepository{
        if(instance == nil){
            instance = FavoritosRepository.init()
        }
        return instance!
    }
    
    func add(filme : Filme) {
        var list = listMovies()

        // Se já existe não add
        for (_, filmeLocal) in list.enumerated() {
            if(filmeLocal.id == filme.id) {
                return
            }
        }
        
        list.append(filme)

        do {
            let jsonList = try? JSONEncoder().encode(list)
            preferences.setValue(jsonList, forKey: favoritolKey)
            //  Save to disk
            let didSave = preferences.synchronize()
            print(didSave)
        }
    }
    
    func remove(filme: Filme) {
        var list = listMovies()
        
        for (index, filmeLocal) in list.enumerated() {
            if(filmeLocal.id == filme.id) {
                list.remove(at: index)
                
                do {
                    let jsonList = try? JSONEncoder().encode(list)
                    preferences.setValue(jsonList, forKey: favoritolKey)
                    //  Save to disk
                    let didSave = preferences.synchronize()
                    print(didSave)
                }
                return
            }
        }
    }
    
    func removeAll() {
        preferences.removeObject(forKey: favoritolKey) 
        //  Save to disk
        let didSave = preferences.synchronize()
        print(didSave)
    }
    
    func listMovies() -> [Filme] {
        var films = [Filme]()
        if preferences.object(forKey: favoritolKey) != nil {
            if let filmesJson = preferences.value(forKey: favoritolKey) as? Data {
                do {
                   if let f = try? JSONDecoder().decode([Filme].self, from: filmesJson) {
                    films = f
                    }
                }
            }
        }
        return films
    }
    
    func findMovieById(id: CLong) -> Filme?{
        let list = listMovies()
        for (_, filmeLocal) in list.enumerated() {
            if(filmeLocal.id == id) {
                return filmeLocal
            }
        }
        return nil
    }
    
    func findMovieByNome(name: String) -> [Filme]{
        let list = listMovies()
        var filmes = [Filme]()
        for (_, filmeLocal) in list.enumerated() {
            if((filmeLocal.title?.lowercased().contains(name.lowercased()))!) {
                filmes.append(filmeLocal)
            }
        }
        return filmes
    }
}
