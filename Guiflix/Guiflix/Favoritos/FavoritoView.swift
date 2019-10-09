//
//  FavoritoView.swift
//  Guiflix
//
//  Created by Guilherme Miranda Lopes on 09/10/19.
//  Copyright © 2019 Guilherme Miranda Lopes. All rights reserved.
//

import UIKit

class FavoritoView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        
        let nib = UINib(nibName: "FavoritoView", bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        addSubview(view)
    }
    
}
