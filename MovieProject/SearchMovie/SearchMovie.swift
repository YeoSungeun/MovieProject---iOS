//
//  SearchMovie.swift
//  MovieProject
//
//  Created by 여성은 on 6/12/24.
//

import Foundation

struct SearchMovie: Decodable {
    let page: Int
    let total_pages: Int
    let total_results: Int
    var results: [Result]
}

struct Result: Decodable {
    let id: Int
    let title: String
    let backdrop_path: String?
    let poster_path: String?
    let genre_ids: [Int]
    let overview: String
    let release_date: String
}

