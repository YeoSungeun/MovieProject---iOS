//
//  VideoViewController.swift
//  MovieProject
//
//  Created by 여성은 on 7/2/24.
//

import UIKit
import WebKit

class VideoViewController: UIViewController {
    
    var id: Int = 0
    var url: String = "https://www.youtube.com/watch?v="

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        print(id)
        TrendManager.shared.apiRequest(api: .video(id: id), model: Video.self) { [self] value in
            print(value)
            guard let key = value.results[0]?.key else { return }
            self.url += key
            print(self.url)
        }
 
    }
    



}
