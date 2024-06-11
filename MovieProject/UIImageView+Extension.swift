//
//  UIImageView+Extension.swift
//  MovieProject
//
//  Created by 여성은 on 6/11/24.
//

import UIKit
import Alamofire

extension UIImageView {
    func configureImageFromURL(path: String) {
        let url = "https://image.tmdb.org/t/p/original\(path)"
        
        AF.request(url).responseData { response in
            switch response.result {
            case .success(let imageData):
                DispatchQueue.main.async {
                    guard let image = UIImage(data: imageData) else {return}
                    self.image = image
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

