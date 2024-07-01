//
//  CreditManager.swift
//  MovieProject
//
//  Created by 여성은 on 7/1/24.
//

import UIKit
import Alamofire

final class CreditManager {
    static let shared = CreditManager()
    
    private init() { }
    
    func creditRequest(api: TMDBRequest, completionHandler: @escaping (Cast) -> Void) {
        
        AF.request(api.endpoint,
                   method: api.method,
                   parameters: api.parameter).responseDecodable(of: Cast.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value)
            case .failure(let error):
                print(error)
            }
        }
        
    }
}
