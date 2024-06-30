//
//  UIImageView.swift
//  MovieProject
//
//  Created by 여성은 on 6/30/24.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImageView(path: String) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/original\(path)") else { return }
        self.kf.setImage(with: url)
    }
}

