//
//  TMDBRequest.swift
//  MovieProject
//
//  Created by 여성은 on 6/26/24.
//

import Foundation
import Alamofire


enum TMDBRequest {
    case recommendMovie(id: Int)
    case similarMovie(id: Int)
    case images(id: Int)
    case trend(mediaType: MediaType)
    
    var baseURL: String {
        return APIURL.tmdbURL 
    }
    var endpoint: URL {
        switch self {
        case .recommendMovie(let id):
            return URL(string: baseURL + "movie/\(id)/recommendations?api_key=\(APIKey.tmdbKey)") ?? URL(string: "")!
        case .similarMovie(let id):
            return URL(string: baseURL + "movie/\(id)/similar?api_key=\(APIKey.tmdbKey)") ?? URL(string: "")!
        case .images(let id):
            return URL(string: baseURL + "movie/\(id)/images?api_key=\(APIKey.tmdbKey)") ?? URL(string: "")!
        case .trend(let type):
            return URL(string: baseURL + "trending/\(type.rawValue)/day?api_key=\(APIKey.tmdbKey)") ?? URL(string: "")!
        }
    }
    var method: HTTPMethod {
        return .get
    }
    var parameter: Parameters {
        switch self {
        case .recommendMovie, .similarMovie, .trend:
            return ["language": "ko-KR"]
        case .images:
            return ["":""]
        }
    }
    
}
