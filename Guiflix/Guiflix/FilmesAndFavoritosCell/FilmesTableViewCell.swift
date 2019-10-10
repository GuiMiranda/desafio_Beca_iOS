//
//  FilmesTableViewCell.swift
//  Guiflix
//
//  Created by Lucas Fernandes Araujo on 09/10/19.
//  Copyright © 2019 Guilherme Miranda Lopes. All rights reserved.
//

import UIKit

class FilmesTableViewCell: UITableViewCell {

    @IBOutlet weak var ivPoster: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    
    var model: String = "Teste" {
        didSet {
            self.lblTitle?.text = model
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ivPoster.layer.cornerRadius = 5.0
        ivPoster.layer.masksToBounds = true
    }
    
    func setup(filme: String, imagem: String, ano: String){
        self.lblTitle.text = filme
        self.ivPoster.image = UIImage(named: imagem) ?? UIImage()
        self.lblYear.text = ano
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
