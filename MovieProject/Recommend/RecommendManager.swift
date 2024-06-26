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
    // recommend, similar
    func recommendationsRequest(api: TMDBRequest, completionHandler: @escaping ([MovieResult]?, String?) -> Void) {
      // MARK: failure 처리 대응 생각해보기
        AF.request(api.endpoint, parameters: api.parameter).responseDecodable(of: Movie.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value.results, nil)
            case .failure(let error):
                print(error)
                completionHandler(nil, "잠시 후 다시 시도해주세요")
            }
            // success 일때도 , error일때도 completionHandler를 거쳐서 group.leave를 거칠 수 있도록 해준다!!
        }
    }

    func posterRequest(api: TMDBRequest, completionHander: @escaping ([PosterResult]) -> Void, errorHandler: @escaping (String) -> Void) {
        
        AF.request(api.endpoint).responseDecodable(of: Poster.self) { response in
            switch response.result {
            case .success(let value):
                completionHander(value.posters)
            case .failure(let error):
                print(error)
                errorHandler("이미지를 불러오는데 실패했습니다.")
            }
        }
    }
}
