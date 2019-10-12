//
//  FilmesCollectionViewCell.swift
//  testeCollection
//
//  Created by Raphael Rosa Matrone on 11/10/19.
//  Copyright © 2019 Raphael Rosa Matrone. All rights reserved.
//

import UIKit

class FilmesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var releaseDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        poster.layer.cornerRadius = 5.0
        poster.layer.masksToBounds = true
    }
    
    func setup(title: String, poster: String, year: String){
        self.title.text = title
        self.poster.load(url: poster, size: .w92)
        self.releaseDate.text = year
    }
    


}
