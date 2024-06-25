//
//  RecommendManager.swift
//  MovieProject
//
//  Created by 여성은 on 6/25/24.
//

import UIKit
import Alamofire

class RecommendManager {
    private init() { }
    
    static func recommendationsRequest(id: Int, completionHander: @escaping (Movie) -> Void) {
        let url = "https://api.themoviedb.org/3/movie/\(id)/recommendations?api_key=\(APIKey.tmdbKey)"
        
        AF.request(url).responseDecodable(of: Movie.self) { response in
            switch response.result {
            case .success(let value):
                print(value)
                completionHander(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    static func similarRequest(id: Int, completionHander: @escaping (Movie) -> Void) {
        let url = "https://api.themoviedb.org/3/movie/\(id)/similar?api_key=\(APIKey.tmdbKey)"
        AF.request(url).responseDecodable(of: Movie.self) { response in
            switch response.result {
            case .success(let value):
                print(value)
                completionHander(value)
            case .failure(let error):
                print(error)
            }
        }
    }
}
