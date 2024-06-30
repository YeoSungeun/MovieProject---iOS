//
//  Credit.swift
//  MovieProject
//
//  Created by 여성은 on 6/30/24.
//

import Foundation

struct Cast: Decodable {
    let id: Int
    let cast: [CastResult]
}

struct CastResult: Decodable {
    let id: Int
    let name: String
    let character: String
    let profile_path: String?
}
