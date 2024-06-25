//
//  RecomendViewController.swift
//  MovieProject
//
//  Created by 여성은 on 6/25/24.
//

import UIKit

class RecommendViewController: UIViewController {
    
    var id: Int = 0
    var movieTitle: String = ""
    
    lazy var recommendList: [MovieResult] = []
    lazy var similarList: [MovieResult] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        RecommendManager.recommendationsRequest(id: id) { movie in
            print(movie.results[0].title)
            for i in 0...9 {
                self.recommendList.append(movie.results[i])
            }
            print(self.recommendList,"추천목록")
        }
        RecommendManager.similarRequest(id: id) { movie in
            print(movie.results[0].title)
            for i in 0...10 {
                self.similarList.append(movie.results[i])
            }
            print(self.similarList,"추천목록")
        }

    }
    
    
}
