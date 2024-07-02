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
    case genre
    case credit(id: Int)
    case video(id: Int)
    
    
    var baseURL: String {
        return APIURL.tmdbURL 
    }
    var endpoint: URL {
        switch self {
        case .recommendMovie(let id):
            return URL(string: baseURL + "movie/\(id)/recommendations?api_key=\(APIKey.tmdbKey)")!
        case .similarMovie(let id):
            return URL(string: baseURL + "movie/\(id)/similar?api_key=\(APIKey.tmdbKey)")!
        case .images(let id):
            return URL(string: baseURL + "movie/\(id)/images?api_key=\(APIKey.tmdbKey)")!
        case .trend(let type):
            return URL(string: baseURL + "trending/\(type.rawValue)/day?api_key=\(APIKey.tmdbKey)")!
        case .genre:
            return URL(string: baseURL + "genre/movie/list?api_key=\(APIKey.tmdbKey)")!
        case .credit(let id):
            return URL(string: baseURL + "movie/\(id)/credits?api_key=\(APIKey.tmdbKey)")!
        case .video(id: let id):
            return URL(string: baseURL + "movie/\(id)/videos?api_key=\(APIKey.tmdbKey)")!
        }
        
   
    }
    var method: HTTPMethod {
        return .get
    }
    var parameter: Parameters {
        switch self {
        case .recommendMovie, .similarMovie, .trend:
            return ["language": "ko-KR"]
        case .images, .genre, .credit, .video:
            return ["":""]
        }
    }
    
}
