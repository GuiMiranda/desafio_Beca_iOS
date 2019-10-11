//
//  File.swift
//  Guiflix
//
//  Created by Andre Medeiros Silva on 10/10/19.
//  Copyright © 2019 Guilherme Miranda Lopes. All rights reserved.
//

import Foundation
import ObjectMapper

class FilmesResponse: Codable {
    var page: Int?
    var total_results: CLong?
    var total_pages: CLong?
    var results: [Filme]?
    var status_code: Int?
    var status_message: String?
    var success: Bool?
}

