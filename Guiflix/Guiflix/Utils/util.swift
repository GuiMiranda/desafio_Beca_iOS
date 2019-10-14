//
//  util.swift
//  Guiflix
//
//  Created by Andre Medeiros Silva on 09/10/19.
//  Copyright © 2019 Guilherme Miranda Lopes. All rights reserved.
//
import UIKit
import Foundation

public typealias completionImage = ( (_ image: UIImage) -> Void)

func getGenres(idsGenre: [Int]?) -> String {
    guard let idsGen = idsGenre else {
        return ""
    }
    var i = 0
    var generos: String = ""
    while i != idsGen.count {
        if !getGenre(idGenre: idsGen[i]).isEmpty{
            if !generos.isEmpty{
                generos = "\(generos) - " + getGenre(idGenre: idsGen[i])
            }else{
                generos = "\(generos)" + getGenre(idGenre: idsGen[i])
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

func getPoster(poster_path: String, imagem: @escaping completionImage){
    let url = URL(string: "https://image.tmdb.org/t/p/w500\(String(describing: poster_path))")!
    DispatchQueue.global().async {
        
        guard let data = try? Data(contentsOf: url) else {
            return
        }
        
        guard let image = UIImage(data: data) else {
            return
        }
        
        DispatchQueue.main.async {
            imagem(image)
        }
    }
}

func arredondarNota(_ nota: CDouble) -> Double{
    return Double(round(100*nota)/100)
}

extension String {

    func toDate(withFormat format: String = "yyyy-MM-dd")-> Date? {

        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Tehran")
        dateFormatter.locale = Locale(identifier: "fa-IR")
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)

        return date
    }
    
    func getYear()-> String? {
        let calendar = Calendar.current
        if let date = self.toDate() {
            return String(calendar.component(.year, from: date))
        }
        return nil
    }
}

enum imageSize: Int{
    case w92 = 92
    case w154 = 154
    case w185 = 185
    case w342 = 342
    case w500 = 500
    case w780 = 780
}



extension UIImageView {
    
    func load(url: String?, size: imageSize) {
        guard let urlString = url else {
            return
        }
        
        let urlConverted = URL(string: "https://image.tmdb.org/t/p/w\(size.rawValue)\(urlString)")
        guard let urlOk = urlConverted else {
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: urlOk) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
