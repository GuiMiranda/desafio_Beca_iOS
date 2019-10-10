//
//  Filme.swift
//  Guiflix
//
//  Created by Andre Medeiros Silva on 09/10/19.
//  Copyright © 2019 Guilherme Miranda Lopes. All rights reserved.
//

import UIKit

struct Filme : Codable {
    var popularity: Double
    var vote_count: CLong
    var video: Bool
    var poster_path: String
    var id: CLong
    var adult: Bool
    var backdrop_path: String
    var original_language: String
    var original_title: String
    var genre_ids: [Int]
    // usar somente genre nas views
    var genre: [String]
    var title: String
    var vote_average: Double
    var overview: String
    var release_date: String

}








