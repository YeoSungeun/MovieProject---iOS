//
//  Video.swift
//  MovieProject
//
//  Created by 여성은 on 7/2/24.
//

import Foundation

struct Video: Decodable {
    let id: Int
    let results: [VideoResult?]
}
struct VideoResult: Decodable {
    let key: String
}
