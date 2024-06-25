//
//  Poster.swift
//  MovieProject
//
//  Created by 여성은 on 6/26/24.
//

import Foundation

struct Poster: Decodable {
    var posters: [PosterResult]
}

struct PosterResult: Decodable {
    var file_path: String?
}
