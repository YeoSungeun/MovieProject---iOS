//
//  TrendManager.swift
//  MovieProject
//
//  Created by 여성은 on 6/27/24.
//

import Foundation
import Alamofire

final class TrendManager {
    static let shared = TrendManager()
    
    private init() { }
    
    func apiRequest<T: Decodable>(api: TMDBRequest, model: T.Type, completionHandler: @escaping (T) -> Void) {
        
        AF.request(api.endpoint, 
                   method: api.method,
                   parameters: api.parameter).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value)
            case .failure(let error):
                print(error)
            }
        }
    }

}
