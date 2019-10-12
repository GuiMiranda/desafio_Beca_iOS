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
//        self.contentView.translatesAutoresizingMaskIntoConstraints = false
//        let screenWidth = UIScreen.main.bounds.size.width
//        let screenHeight = UIScreen.main.bounds.size.height
//        widthConstraint.constant = screenWidth - (2 * 4)
//        heightConstraint.constant = screenHeight - (2 * 4)
        
        favPoster.layer.cornerRadius = 5.0
        favPoster.layer.masksToBounds = true

    }
    
    func setup(title: String, poster: String, year: String){
        self.favTitle.text = title
        self.favPoster.load(url: poster, size: .w780)
        self.favYear.text = year
    }
}

