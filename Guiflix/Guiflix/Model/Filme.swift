//
//  Filme.swift
//  Guiflix
//
//  Created by Andre Medeiros Silva on 09/10/19.
//  Copyright © 2019 Guilherme Miranda Lopes. All rights reserved.
//
import UIKit

struct Filme: Codable{
    public var popularity: Double?
    public var vote_count: CLong?
    public var video: Bool?
    public var poster_path: String?
    public var id: CLong?
    public var adult: Bool?
    public var backdrop_path: String?
    public var original_language: String?
    public var original_title: String?
    public var genre_ids: [Int]?
    public var title: String?
    public var vote_average: Double?
    public var overview: String?
    public var release_date: String?
    public var isFavorite: Bool?
}
