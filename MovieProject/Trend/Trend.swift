//
//  Trend.swift
//  MovieProject
//
//  Created by 여성은 on 6/11/24.
//

import Foundation

enum MediaType: String {
    case all = "all"
    case movie = "movie"
    case tv = "tv"
    case person = "person"
    
}

enum time_window: String {
    case day
    case week
}

struct Trend: Decodable {
    let results: [TrendResult]
}
struct TrendResult: Decodable {
    let backdrop_path: String
    let id: Int
    let overview: String
    let poster_path: String
    let title: String
    let genre_ids: [Int]
    let release_date: String
    let vote_average: Double
    
    var voteAverageFormat: String {
        return String(format: "%.1f", vote_average)
    }
    var releas_date_string: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: release_date) // Date로 변환

        dateFormatter.dateFormat = "MM/dd/yyyy"
        let dateString = dateFormatter.string(from: date!) // Date String으로 변환

        return dateString
    }
}

// MARK: - Genres
struct Genres: Codable {
    let genres: [Genre]
}

struct Genre: Codable {
    let id: Int
    let name: String
}
