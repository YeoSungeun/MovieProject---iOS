//
//  TrendManager.swift
//  MovieProject
//
//  Created by 여성은 on 6/27/24.
//

import Foundation
import Alamofire

class TrendManager {
    static let shared = TrendManager()
    
    private init() { }
    
    func trendRequest(api: TMDBRequest,completionHanlder: @escaping ([TrendResult]) -> Void) {
        
        AF.request(api.endpoint, 
                   method: api.method,
                   parameters: api.parameter).responseDecodable(of: Trend.self) { response in
            switch response.result {
            case .success(let value):
                completionHanlder(value.results)
            case .failure(let error):
                print(error)
            }
        }
    }
     
}
