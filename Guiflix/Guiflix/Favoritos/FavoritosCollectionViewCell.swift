//
//  FavoritosCollectionViewCell.swift
//  Guiflix
//
//  Created by Raphael Matrone on 11/10/19.
//  Copyright © 2019 Guilherme Miranda Lopes. All rights reserved.
//

import UIKit

class FavoritosCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var favPoster: UIImageView!
    @IBOutlet weak var favTitle: UILabel!
    @IBOutlet weak var favYear: UILabel!
    
    
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        favPoster.layer.cornerRadius = 5.0
        favPoster.layer.masksToBounds = true
        
    }
    
    func setup(filme : Filme){
        self.favTitle.text = filme.title
        self.favPoster.load(url: filme.poster_path, size: .w780)
        self.favYear.text = filme.release_date?.getYear()
    }
}

