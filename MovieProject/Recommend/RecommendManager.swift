//
//  RecommendManager.swift
//  MovieProject
//
//  Created by 여성은 on 6/25/24.
//

import UIKit
import Alamofire

class RecommendManager {
    
    static let shared = RecommendManager()
    
    private init() { }
    
    func recommendationsRequest(id: Int, completionHander: @escaping ([MovieResult]) -> Void) {
        let url = "https://api.themoviedb.org/3/movie/\(id)/recommendations?api_key=\(APIKey.tmdbKey)"
        
        AF.request(url).responseDecodable(of: Movie.self) { response in
            switch response.result {
            case .success(let value):
                completionHander(value.results)
            case .failure(let error):
                print(error)
            }
        }
    }
    func similarRequest(id: Int, completionHander: @escaping ([MovieResult]) -> Void) {
        let url = "https://api.themoviedb.org/3/movie/\(id)/similar?api_key=\(APIKey.tmdbKey)"
        AF.request(url).responseDecodable(of: Movie.self) { response in
            switch response.result {
            case .success(let value):
                completionHander(value.results)
            case .failure(let error):
                print(error)
            }
        }
    }
    func posterRequest(id: Int, completionHander: @escaping ([PosterResult]) -> Void) {
        let url = "https://api.themoviedb.org/3/movie/\(id)/images?api_key=\(APIKey.tmdbKey)"
        AF.request(url).responseDecodable(of: Poster.self) { response in
            switch response.result {
            case .success(let value):
                completionHander(value.posters)
            case .failure(let error):
                print(error)
            }
        }
    }
}
