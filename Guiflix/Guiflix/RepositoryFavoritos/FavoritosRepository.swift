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
    
    func add(filme : Filme) {
        var list = listMovies()

        // Se já existe não add
        for (index, filmeLocal) in list.enumerated() {
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
        var filmes = [Filme]()
        if preferences.object(forKey: favoritolKey) != nil {
            if let filmesJson = preferences.value(forKey: favoritolKey) as? Data {
                do {
                   if let f = try? JSONDecoder().decode([Filme].self, from: filmesJson) {
                    filmes = f
                    }
                }
            }
        }
        return filmes
    }
}
