//
//  Movie.swift
//  MovieProject
//
//  Created by 여성은 on 6/25/24.
//

import Foundation

struct Movie: Decodable {
    var results: [MovieResult]
}

struct MovieResult: Decodable {
    var id: Int
    var title: String
    var poster_path: String?
    
}
