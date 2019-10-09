//
//  FavoritoViewController.swift
//  Guiflix
//
//  Created by Guilherme Miranda Lopes on 09/10/19.
//  Copyright © 2019 Guilherme Miranda Lopes. All rights reserved.
//

import UIKit

class FavoritoViewController: UIViewController {

    var favoritoView : FavoritoView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        favoritoView = FavoritoView(frame: view.frame)
        if let v = favoritoView {
            self.view.addSubview(v)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
      
    }

}
