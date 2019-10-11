//
//  util.swift
//  Guiflix
//
//  Created by Andre Medeiros Silva on 09/10/19.
//  Copyright © 2019 Guilherme Miranda Lopes. All rights reserved.
//
import UIKit
import Foundation

func getGenres(idsGenre: [Int]) -> String{
    var i = 0
    var generos: String = ""
    while i != idsGenre.count {
        if !getGenre(idGenre: idsGenre[i]).isEmpty{
            if !generos.isEmpty{
                generos = "\(generos) - " + getGenre(idGenre: idsGenre[i])
            }else{
                generos = "\(generos)" + getGenre(idGenre: idsGenre[i])
            }
        }
        i = i + 1        
    }
    return generos
}

func getGenre(idGenre: Int) -> String{
    
    switch idGenre {
    case 28:
        return "Action"
    case 12:
        return "Adventure"
    case 16:
        return "Animation"
    case 80:
        return "Crime"
    case 99:
        return "Documentary"
    case 18:
        return "Drama"
    case 10751:
        return "Family"
    case 14:
        return "Fantasy"
    case 36:
        return "History"
    case 27:
        return "Horror"
    case 10402:
        return "Music"
    case 9648:
        return "Mystery"
    case 10749:
        return "Romance"
    case 878:
        return "Science Fiction"
    case 10770:
        return "TV Movie"
    case 53:
        return "Thriller"
    case 10752:
        return "War"
    case 37:
        return "Western"
    default:
        return ""
    }
}




func getPoster(poster_path: String) -> UIImage{
    let url = URL(string: "https://image.tmdb.org/t/p/w500\(String(describing: poster_path))")!
    var image = UIImage()
    // Perform on background thread
    DispatchQueue.global().async {
        
        // Create data from url (You can handle exeption with try-catch)
        guard let data = try? Data(contentsOf: url) else {
            return
        }
        
        // Create image from data
        guard let image = UIImage(data: data) else {
            return
        }
        
        // Perform on UI thread
        DispatchQueue.main.async {
            return image
            /* Do some stuff with your imageView */
        }
    }
    return image
}

